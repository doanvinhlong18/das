param(
    [string]$SourceRoot = (Join-Path $PSScriptRoot "..\..\.."),

    [Parameter(Mandatory = $true)]
    [string]$EvidenceRoot,

    [string]$CodexCommand = "codex"
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
        throw "Refusing to overwrite validation evidence: $Path"
    }
    $parent = Split-Path -Parent $Path
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($false))
}

function Copy-DirectoryContents {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination
    )

    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    Get-ChildItem -LiteralPath $Source -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $Destination -Recurse -Force
    }
}

function Get-ResolvedLinkTarget {
    param([Parameter(Mandatory = $true)][string]$Path)

    $item = Get-Item -LiteralPath $Path -Force
    $targets = @($item.Target)
    if ($targets.Count -eq 0 -or [string]::IsNullOrWhiteSpace([string]$targets[0])) {
        return $null
    }
    $target = [string]$targets[0]
    if (-not [System.IO.Path]::IsPathRooted($target)) {
        $target = Join-Path (Split-Path -Parent $Path) $target
    }
    return Get-AbsolutePath $target
}

function Invoke-PromptInput {
    param(
        [Parameter(Mandatory = $true)][string]$ProjectRoot,
        [Parameter(Mandatory = $true)][string]$OutputPath,
        [Parameter(Mandatory = $true)][string]$ErrorPath,
        [Parameter(Mandatory = $true)][string]$Command
    )

    if ((Test-Path -LiteralPath $OutputPath) -or (Test-Path -LiteralPath $ErrorPath)) {
        throw "Refusing to overwrite prompt evidence."
    }

    $executable = (Get-Command $Command -ErrorAction Stop).Source
    $process = Start-Process -FilePath $executable `
        -ArgumentList @("debug", "prompt-input", "adapter-validation-probe") `
        -WorkingDirectory $ProjectRoot `
        -WindowStyle Hidden `
        -RedirectStandardOutput $OutputPath `
        -RedirectStandardError $ErrorPath `
        -Wait `
        -PassThru

    if ($process.ExitCode -ne 0) {
        $stderr = if (Test-Path -LiteralPath $ErrorPath) { Get-Content -Raw $ErrorPath } else { "" }
        throw "Codex prompt-input failed for $ProjectRoot with exit $($process.ExitCode): $stderr"
    }
}

function Add-Check {
    param(
        [Parameter(Mandatory = $true)][AllowEmptyCollection()][System.Collections.ArrayList]$Checks,
        [Parameter(Mandatory = $true)][string]$Id,
        [Parameter(Mandatory = $true)][bool]$Passed,
        [Parameter(Mandatory = $true)][string]$Evidence
    )

    [void]$Checks.Add([PSCustomObject]@{
        id = $Id
        result = if ($Passed) { "PASS" } else { "FAIL" }
        evidence = $Evidence
    })
}

$source = Get-AbsolutePath $SourceRoot
$evidence = Get-AbsolutePath $EvidenceRoot
$fixtures = Join-Path $source "adapters\codex\fixtures"
$installer = Join-Path $source "adapters\codex\scripts\install.ps1"

if (-not (Test-Path -LiteralPath $installer -PathType Leaf)) {
    throw "Installer not found: $installer"
}

New-Item -ItemType Directory -Path $evidence -Force | Out-Null
if (Get-ChildItem -LiteralPath $evidence -Force | Select-Object -First 1) {
    throw "EvidenceRoot must be empty to preserve immutable validation evidence: $evidence"
}

$tempBase = Get-AbsolutePath ([System.IO.Path]::GetTempPath())
$tempRoot = Join-Path $tempBase ("dev-agent-skills-codex-" + [guid]::NewGuid().ToString("N"))
$projectA = Join-Path $tempRoot "project-a"
$projectB = Join-Path $tempRoot "project-b"
$collisionProject = Join-Path $tempRoot "collision-project"

$checks = [System.Collections.ArrayList]::new()
$linkManifest = @()
$hashManifest = @()

try {
    Copy-DirectoryContents -Source (Join-Path $fixtures "project-a") -Destination $projectA
    Copy-DirectoryContents -Source (Join-Path $fixtures "project-b") -Destination $projectB
    New-Item -ItemType Directory -Path $collisionProject -Force | Out-Null

    $installAFirstText = (& $installer -Scope Project -ProjectRoot $projectA -SourceRoot $source -Json | Out-String).Trim()
    $installBFirstText = (& $installer -Scope Project -ProjectRoot $projectB -SourceRoot $source -Json | Out-String).Trim()
    $installASecondText = (& $installer -Scope Project -ProjectRoot $projectA -SourceRoot $source -Json | Out-String).Trim()

    Write-NewTextFile -Path (Join-Path $evidence "project-a-install-first.json") -Content $installAFirstText
    Write-NewTextFile -Path (Join-Path $evidence "project-b-install-first.json") -Content $installBFirstText
    Write-NewTextFile -Path (Join-Path $evidence "project-a-install-repeat.json") -Content $installASecondText

    $installAFirst = @(($installAFirstText | ConvertFrom-Json) | ForEach-Object { $_ })
    $installBFirst = @(($installBFirstText | ConvertFrom-Json) | ForEach-Object { $_ })
    $installASecond = @(($installASecondText | ConvertFrom-Json) | ForEach-Object { $_ })

    $expectedSkills = @()
    foreach ($layer in @("core", "domains")) {
        $expectedSkills += Get-ChildItem -LiteralPath (Join-Path $source $layer) -Directory |
            Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName "SKILL.md") } |
            Select-Object -ExpandProperty Name
    }
    $expectedSkills = @($expectedSkills | Sort-Object -Unique)

    Add-Check -Checks $checks -Id "skill-count" `
        -Passed (($installAFirst.Count -eq $expectedSkills.Count) -and ($installBFirst.Count -eq $expectedSkills.Count)) `
        -Evidence "Project A and B each installed $($expectedSkills.Count) linked skills."

    Add-Check -Checks $checks -Id "idempotent-install" `
        -Passed (@($installASecond | Where-Object { $_.status -ne "already-linked" }).Count -eq 0) `
        -Evidence "Repeated Project A installation returned already-linked for every skill."

    foreach ($projectRecord in @(@{ name = "project-a"; root = $projectA }, @{ name = "project-b"; root = $projectB })) {
        foreach ($skill in $expectedSkills) {
            $linkPath = Join-Path $projectRecord.root ".agents\skills\$skill"
            $resolvedTarget = Get-ResolvedLinkTarget -Path $linkPath
            $centralCandidates = @(@(
                (Join-Path $source "core\$skill")
                (Join-Path $source "domains\$skill")
            ) | Where-Object { Test-Path -LiteralPath $_ -PathType Container })
            $centralTarget = Get-AbsolutePath $centralCandidates[0]
            $item = Get-Item -LiteralPath $linkPath -Force

            $linkManifest += [PSCustomObject]@{
                project = $projectRecord.name
                skill = $skill
                link_path = Get-AbsolutePath $linkPath
                link_type = [string]$item.LinkType
                resolved_target = $resolvedTarget
                expected_target = $centralTarget
                matches = $resolvedTarget.Equals($centralTarget, [StringComparison]::OrdinalIgnoreCase)
            }
        }
    }

    Add-Check -Checks $checks -Id "central-link-targets" `
        -Passed (@($linkManifest | Where-Object { -not $_.matches }).Count -eq 0) `
        -Evidence "Every project link resolves to its central core/ or domains/ directory."

    $centralSkill = Join-Path $source "core\guided-development\SKILL.md"
    $projectASkill = Join-Path $projectA ".agents\skills\guided-development\SKILL.md"
    $projectBSkill = Join-Path $projectB ".agents\skills\guided-development\SKILL.md"
    foreach ($record in @(
        @{ name = "central"; path = $centralSkill },
        @{ name = "project-a"; path = $projectASkill },
        @{ name = "project-b"; path = $projectBSkill }
    )) {
        $hashManifest += [PSCustomObject]@{
            source = $record.name
            path = Get-AbsolutePath $record.path
            sha256 = (Get-FileHash -LiteralPath $record.path -Algorithm SHA256).Hash
        }
    }
    $uniqueHashes = @($hashManifest.sha256 | Sort-Object -Unique)
    Add-Check -Checks $checks -Id "shared-source-hash" `
        -Passed ($uniqueHashes.Count -eq 1) `
        -Evidence "Central and both linked guided-development SKILL.md paths have the same SHA-256."

    $promptA = Join-Path $evidence "project-a-prompt-input.json"
    $promptAError = Join-Path $evidence "project-a-prompt-input.stderr.txt"
    $promptB = Join-Path $evidence "project-b-prompt-input.json"
    $promptBError = Join-Path $evidence "project-b-prompt-input.stderr.txt"
    Invoke-PromptInput -ProjectRoot $projectA -OutputPath $promptA -ErrorPath $promptAError -Command $CodexCommand
    Invoke-PromptInput -ProjectRoot $projectB -OutputPath $promptB -ErrorPath $promptBError -Command $CodexCommand

    $promptAText = Get-Content -Raw $promptA
    $promptBText = Get-Content -Raw $promptB
    $centralForward = $source.Replace("\", "/")

    $sharedDiscovery = $promptAText.Contains("guided-development") -and
        $promptBText.Contains("guided-development") -and
        $promptAText.Contains($centralForward) -and
        $promptBText.Contains($centralForward)
    Add-Check -Checks $checks -Id "codex-shared-discovery" -Passed $sharedDiscovery `
        -Evidence "Codex prompt input for both projects lists guided-development from the central repository path."

    $projectIsolation = $promptAText.Contains("PROJECT_A_CONTEXT") -and
        (-not $promptAText.Contains("PROJECT_B_CONTEXT")) -and
        $promptAText.Contains("mvn test -Dtest=RelevantTest") -and
        $promptBText.Contains("PROJECT_B_CONTEXT") -and
        (-not $promptBText.Contains("PROJECT_A_CONTEXT")) -and
        $promptBText.Contains("npm test -- --runInBand")
    Add-Check -Checks $checks -Id "project-context-isolation" -Passed $projectIsolation `
        -Evidence "Each prompt includes only its own project marker and focused test command."

    $conditionalGate = $promptAText.Contains("Understanding Gates remain conditional") -and
        $promptBText.Contains("Understanding Gates remain conditional") -and
        $promptAText.Contains("documentation and mechanical work are not automatically gated") -and
        $promptBText.Contains("documentation and mechanical work are not automatically gated")
    Add-Check -Checks $checks -Id "conditional-understanding" -Passed $conditionalGate `
        -Evidence "Both project prompts preserve conditional gates and the documentation/mechanical exception."

    $projectAConfig = Get-Content -Raw (Join-Path $projectA ".codex\config.toml")
    $projectBConfig = Get-Content -Raw (Join-Path $projectB ".codex\config.toml")
    $independentConfig = $projectAConfig.Contains('personality = "pragmatic"') -and
        $projectBConfig.Contains('personality = "friendly"') -and
        (-not $projectAConfig.Contains('personality = "friendly"')) -and
        (-not $projectBConfig.Contains('personality = "pragmatic"'))
    Add-Check -Checks $checks -Id "project-config-independence" -Passed $independentConfig `
        -Evidence "Project-local config files contain different host settings and remain outside the central source."

    $templateText = Get-Content -Raw (Join-Path $source "adapters\codex\templates\project-AGENTS.template.md")
    $coreInvariantText = $promptAText.Contains("cannot be weakened by project rules") -and
        $promptBText.Contains("cannot be weakened by project rules") -and
        $templateText.Contains("must not weaken core")
    Add-Check -Checks $checks -Id "core-invariant-floor" -Passed $coreInvariantText `
        -Evidence "Both active project prompts and the reusable bridge reject weakening core invariants."

    $conflictPath = Join-Path $collisionProject ".agents\skills\guided-development"
    New-Item -ItemType Directory -Path $conflictPath -Force | Out-Null
    [System.IO.File]::WriteAllText((Join-Path $conflictPath "owner.txt"), "pre-existing", [System.Text.UTF8Encoding]::new($false))
    $collisionRejected = $false
    $collisionMessage = ""
    try {
        & $installer -Scope Project -ProjectRoot $collisionProject -SourceRoot $source -Json | Out-Null
    }
    catch {
        $collisionRejected = $true
        $collisionMessage = $_.Exception.Message
    }
    $collisionPreserved = (Get-Content -Raw (Join-Path $conflictPath "owner.txt")) -eq "pre-existing"
    $collisionExplained = $collisionMessage.Contains("Destination exists and is not a link")
    Add-Check -Checks $checks -Id "conflict-no-overwrite" `
        -Passed ($collisionRejected -and $collisionPreserved -and $collisionExplained) `
        -Evidence "Installer rejected a non-link destination and preserved its marker: $collisionMessage"

    Write-NewTextFile -Path (Join-Path $evidence "link-manifest.json") `
        -Content ($linkManifest | ConvertTo-Json -Depth 5)
    Write-NewTextFile -Path (Join-Path $evidence "skill-hashes.json") `
        -Content ($hashManifest | ConvertTo-Json -Depth 5)

    $version = (& $CodexCommand --version | Out-String).Trim()
    $result = [PSCustomObject]@{
        adapter = "codex"
        codex_version = $version
        source_root = $source
        expected_skill_count = $expectedSkills.Count
        projects = @("project-a", "project-b")
        result = if (@($checks | Where-Object { $_.result -eq "FAIL" }).Count -eq 0) { "PASS" } else { "FAIL" }
        checks = $checks
        limitations = @(
            "Prompt-input validates discovery and active instructions without executing a model response.",
            "Project config values are inspected for independence; effective trusted-project config precedence is documented from the Codex manual rather than exposed by prompt-input.",
            "Instruction adherence remains model-mediated and is not a mechanical policy guarantee."
        )
    }

    Write-NewTextFile -Path (Join-Path $evidence "validation.json") `
        -Content ($result | ConvertTo-Json -Depth 8)

    $result | ConvertTo-Json -Depth 8
    if ($result.result -ne "PASS") {
        exit 1
    }
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        $resolvedTemp = Get-AbsolutePath $tempRoot
        if (-not $resolvedTemp.StartsWith($tempBase, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Unsafe temporary cleanup target: $resolvedTemp"
        }
        Remove-Item -LiteralPath $resolvedTemp -Recurse -Force
    }
}
