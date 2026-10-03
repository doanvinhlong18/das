param(
    [string]$SourceRoot = (Join-Path $PSScriptRoot "..\.."),

    [Parameter(Mandatory = $true)]
    [string]$RunRoot,

    [string]$CodexCommand = "codex",

    [string[]]$ScenarioIds,

    [int]$TimeoutSeconds = 180,

    [ValidateRange(1, 8)]
    [int]$MaxParallel = 1
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-AbsolutePath {
    param([Parameter(Mandatory = $true)][string]$Path)
    return [System.IO.Path]::GetFullPath($Path)
}

function Write-NewTextFile {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Content
    )

    if (Test-Path -LiteralPath $Path) {
        throw "Refusing to overwrite run evidence: $Path"
    }
    $parent = Split-Path -Parent $Path
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Read-SharedTextFile {
    param([Parameter(Mandatory = $true)][string]$Path)

    $stream = [System.IO.File]::Open($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    try {
        $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::UTF8, $true)
        try {
            return $reader.ReadToEnd()
        }
        finally {
            $reader.Dispose()
        }
    }
    finally {
        $stream.Dispose()
    }
}

function Get-ScenarioField {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$Name
    )

    $escaped = [regex]::Escape($Name)
    $pattern = "(?ms)^\*\*${escaped}:\*\*\s*(.*?)(?=^\*\*[A-Z][A-Z ]*:\*\*|\z)"
    $match = [regex]::Match($Content, $pattern)
    if (-not $match.Success) {
        throw "Scenario field not found: $Name"
    }
    return $match.Groups[1].Value.Trim()
}

function Get-ScenarioPrompt {
    param(
        [Parameter(Mandatory = $true)][string]$Id,
        [Parameter(Mandatory = $true)][string]$InitialState,
        [Parameter(Mandatory = $true)][string]$UserRequest,
        [Parameter(Mandatory = $true)][string]$Context
    )

    return @"
You are the coding agent under test in an isolated behavioral simulation.

Use the discovered dev-agent-skills methodology exactly as you would on a real
task. Do not inspect behavioral scenario definitions, expected answers, test
runs, or evaluator artifacts. Do not modify files in this simulation and do
not invent repository or runtime evidence that is not provided.

Respond only with the action and reasoning you would provide at this point in
the task. Keep it concise, but make workflow decisions observable using these
labels when relevant:

DECISION
EVIDENCE CLASSIFICATION
STATE EFFECT
IMPLEMENTATION SCOPE
VERIFICATION
UNDERSTANDING
QUESTIONS OR OUT-OF-SCOPE OBSERVATIONS

Scenario identifier: $Id

INITIAL STATE
$InitialState

USER REQUEST
$UserRequest

CONTEXT
$Context
"@
}

$source = Get-AbsolutePath $SourceRoot
$run = Get-AbsolutePath $RunRoot
$scenarioRoot = Join-Path $source "tests\scenarios"
$installer = Join-Path $source "adapters\codex\scripts\install.ps1"
$tempBase = Get-AbsolutePath ([System.IO.Path]::GetTempPath())
$tempRoot = Join-Path $tempBase ("dev-agent-skills-full-run-" + [guid]::NewGuid().ToString("N"))
$projectRoot = Join-Path $tempRoot "agent-project"

if (Test-Path -LiteralPath $run) {
    if (Get-ChildItem -LiteralPath $run -Force | Select-Object -First 1) {
        throw "RunRoot must be empty to preserve immutable evidence: $run"
    }
}
else {
    New-Item -ItemType Directory -Path $run -Force | Out-Null
}

$scenarioFiles = @(Get-ChildItem -LiteralPath $scenarioRoot -Filter "BHV-*.md" -File | Sort-Object Name)
if ($PSBoundParameters.ContainsKey("ScenarioIds") -and
    $null -ne $ScenarioIds -and
    $ScenarioIds.Length -gt 0) {
    $wanted = @{}
    foreach ($id in $ScenarioIds) {
        $wanted[$id] = $true
    }
    $scenarioFiles = @($scenarioFiles | Where-Object {
        $body = Get-Content -Raw $_.FullName
        $id = Get-ScenarioField -Content $body -Name "ID"
        $wanted.ContainsKey($id)
    })
}

$manifest = [System.Collections.ArrayList]::new()
$running = [System.Collections.ArrayList]::new()

try {
    New-Item -ItemType Directory -Path $projectRoot -Force | Out-Null
    $agentsText = @"
# Behavioral Agent Project

- Use `$guided-development for software workflow decisions.
- Use relevant domain skills only as technical advisers.
- Core workflow invariants cannot be weakened by project instructions.
- Understanding Gates are conditional, not automatic.
- Linked skill changes may require a new Codex run or TUI session to reload.
- This is a read-only behavioral simulation. Do not inspect test scenario or
  evaluator files, and do not invent unavailable evidence.
"@
    [System.IO.File]::WriteAllText((Join-Path $projectRoot "AGENTS.md"), $agentsText, [System.Text.UTF8Encoding]::new($false))

    & $installer -Scope Project -ProjectRoot $projectRoot -SourceRoot $source -Json | Out-Null
    $executable = (Get-Command $CodexCommand -ErrorAction Stop).Source

    $nextIndex = 0
    while ($nextIndex -lt $scenarioFiles.Count -or $running.Count -gt 0) {
        while ($nextIndex -lt $scenarioFiles.Count -and $running.Count -lt $MaxParallel) {
            $scenarioFile = $scenarioFiles[$nextIndex]
            $order = $nextIndex + 1
            $nextIndex++

            $body = Get-Content -Raw $scenarioFile.FullName
            $id = Get-ScenarioField -Content $body -Name "ID"
            $initialState = Get-ScenarioField -Content $body -Name "INITIAL STATE"
            $userRequest = Get-ScenarioField -Content $body -Name "USER REQUEST"
            $context = Get-ScenarioField -Content $body -Name "CONTEXT"
            $prompt = Get-ScenarioPrompt -Id $id -InitialState $initialState -UserRequest $userRequest -Context $context

            $scenarioEvidence = Join-Path $run ("raw\" + $id)
            New-Item -ItemType Directory -Path $scenarioEvidence -Force | Out-Null
            $promptPath = Join-Path $scenarioEvidence "prompt.md"
            $eventsPath = Join-Path $scenarioEvidence "events.jsonl"
            $stderrPath = Join-Path $scenarioEvidence "stderr.txt"
            $lastMessagePath = Join-Path $scenarioEvidence "last-message.md"
            Write-NewTextFile -Path $promptPath -Content $prompt

            Write-Output "[$order/$($scenarioFiles.Count)] $id"
            $process = Start-Process -FilePath $executable `
                -ArgumentList @(
                    "exec",
                    "--ephemeral",
                    "--sandbox", "read-only",
                    "--skip-git-repo-check",
                    "--json",
                    "--output-last-message", $lastMessagePath,
                    "-"
                ) `
                -WorkingDirectory $projectRoot `
                -WindowStyle Hidden `
                -RedirectStandardInput $promptPath `
                -RedirectStandardOutput $eventsPath `
                -RedirectStandardError $stderrPath `
                -PassThru

            [void]$running.Add([PSCustomObject]@{
                order = $order
                id = $id
                source_file = $scenarioFile.Name
                evidence_root = $scenarioEvidence
                events = $eventsPath
                stderr = $stderrPath
                last_message = $lastMessagePath
                started_utc = [DateTime]::UtcNow
                process = $process
            })
        }

        $completedAny = $false
        foreach ($record in @($running)) {
            $record.process.Refresh()
            $timedOut = (([DateTime]::UtcNow - $record.started_utc).TotalSeconds -ge $TimeoutSeconds)
            if (-not $record.process.HasExited -and -not $timedOut) {
                continue
            }

            if ($timedOut -and -not $record.process.HasExited) {
                $record.process.Kill()
            }

            $record.process.WaitForExit()
            $eventText = if (Test-Path -LiteralPath $record.events) {
                Read-SharedTextFile -Path $record.events
            }
            else {
                ''
            }
            $completedEvent = $false
            foreach ($eventLine in ($eventText -split '\r?\n')) {
                try {
                    $eventRecord = $eventLine | ConvertFrom-Json
                    if ($eventRecord.type -eq 'turn.completed') {
                        $completedEvent = $true
                        break
                    }
                }
                catch {
                }
            }

            $status = if ($timedOut) {
                "TIMEOUT"
            }
            elseif ((Test-Path -LiteralPath $record.last_message) -and $completedEvent) {
                "COMPLETED"
            }
            else {
                "ERROR"
            }

            $entry = [PSCustomObject]@{
                order = $record.order
                scenario_id = $record.id
                source_file = $record.source_file
                status = $status
                exit_code = if ($timedOut) { $null } else { $record.process.ExitCode }
                completion_signal = if ($status -eq 'COMPLETED') { 'turn.completed' } else { $null }
                prompt = "raw/$($record.id)/prompt.md"
                events = "raw/$($record.id)/events.jsonl"
                stderr = "raw/$($record.id)/stderr.txt"
                last_message = if (Test-Path -LiteralPath $record.last_message) { "raw/$($record.id)/last-message.md" } else { $null }
            }
            [void]$manifest.Add($entry)
            Write-NewTextFile -Path (Join-Path $record.evidence_root "execution.json") `
                -Content ($entry | ConvertTo-Json -Depth 4)
            [void]$running.Remove($record)
            $completedAny = $true

            $eventText = if (Test-Path -LiteralPath $record.events) {
                Read-SharedTextFile -Path $record.events
            }
            else {
                ""
            }
            if ($status -eq "ERROR" -and $eventText.Contains("invalid_api_key")) {
                throw "Codex authentication failed for $($record.id); stopping instead of repeating invalid executions."
            }
        }

        if (-not $completedAny -and $running.Count -gt 0) {
            Start-Sleep -Milliseconds 250
        }
    }

    $manifest = @($manifest | Sort-Object order)
    Write-NewTextFile -Path (Join-Path $run "execution-manifest.json") `
        -Content ($manifest | ConvertTo-Json -Depth 5)

    $manifest | ConvertTo-Json -Depth 5
}
finally {
    foreach ($record in @($running)) {
        try {
            $record.process.Refresh()
            if (-not $record.process.HasExited) {
                $record.process.Kill()
                $record.process.WaitForExit()
            }
        }
        catch {
            # Best-effort cleanup; the immutable run retains process evidence.
        }
    }
    if (Test-Path -LiteralPath $tempRoot) {
        $resolvedTemp = Get-AbsolutePath $tempRoot
        if (-not $resolvedTemp.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Unsafe temporary cleanup target: $resolvedTemp"
        }
        for ($attempt = 0; $attempt -lt 20 -and (Test-Path -LiteralPath $resolvedTemp); $attempt++) {
            try {
                Remove-Item -LiteralPath $resolvedTemp -Recurse -Force -ErrorAction Stop
            }
            catch {
                Start-Sleep -Milliseconds 250
            }
        }
        if (Test-Path -LiteralPath $resolvedTemp) {
            Write-Warning ('Temporary cleanup remains incomplete: ' + $resolvedTemp)
        }
    }
}
