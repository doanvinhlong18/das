param(
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Path = @(),

    [string]$SourceRoot = (Join-Path $PSScriptRoot "..\..\.."),

    [ValidateSet("Auto", "SymbolicLink", "Junction")]
    [string]$LinkType = "Auto"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$source = [System.IO.Path]::GetFullPath($SourceRoot)
$installer = Join-Path $PSScriptRoot "install.ps1"
$blockFile = Join-Path $PSScriptRoot "..\templates\AGENTS.block.md"
$utf8 = New-Object System.Text.UTF8Encoding($false)
$beginMark = "<!-- dev-agent-skills:begin -->"
$endMark = "<!-- dev-agent-skills:end -->"

$block = ([System.IO.File]::ReadAllText([System.IO.Path]::GetFullPath($blockFile), $utf8)).TrimEnd() -replace "`r?`n", "`r`n"

$expected = @()
foreach ($layer in "core", "domains") {
    $expected += Get-ChildItem -LiteralPath (Join-Path $source $layer) -Directory |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName "SKILL.md") } |
        ForEach-Object Name
}

if ($Path.Count -eq 0) {
    $Path = @((Get-Location).ProviderPath)
}

$failed = 0
$report = foreach ($item in $Path) {
    $row = [ordered]@{ project = $item; skills = ""; agents_md = ""; status = "ok" }
    try {
        if (-not (Test-Path -LiteralPath $item -PathType Container)) {
            throw "Project folder not found"
        }
        $project = (Resolve-Path -LiteralPath $item).ProviderPath
        $row.project = $project

        & $installer -Scope Project -SourceRoot $source -ProjectRoot $project -LinkType $LinkType | Out-Null

        $skillDir = Join-Path $project ".agents\skills"
        $loaded = @($expected | Where-Object { Test-Path -LiteralPath (Join-Path $skillDir "$_\SKILL.md") })
        $row.skills = "$($loaded.Count)/$($expected.Count)"
        if ($loaded.Count -ne $expected.Count) {
            throw "Missing skills: $((@($expected | Where-Object { $loaded -notcontains $_ })) -join ', ')"
        }

        $agentsPath = Join-Path $project "AGENTS.md"
        if (-not (Test-Path -LiteralPath $agentsPath)) {
            [System.IO.File]::WriteAllText($agentsPath, "# AGENTS.md`r`n`r`n$block`r`n", $utf8)
            $row.agents_md = "created"
        }
        else {
            $current = [System.IO.File]::ReadAllText($agentsPath, $utf8)
            $pattern = "(?s)" + [regex]::Escape($beginMark) + ".*?" + [regex]::Escape($endMark)
            if ($current -match $pattern) {
                $updated = [regex]::Replace($current, $pattern, { param($m) $block })
                if ($updated -ceq $current) {
                    $row.agents_md = "up-to-date"
                }
                else {
                    [System.IO.File]::WriteAllText($agentsPath, $updated, $utf8)
                    $row.agents_md = "block-updated"
                }
            }
            else {
                [System.IO.File]::WriteAllText($agentsPath, $current.TrimEnd() + "`r`n`r`n$block`r`n", $utf8)
                $row.agents_md = "block-appended"
            }
        }
    }
    catch {
        $row.status = "ERROR: $($_.Exception.Message)"
        $failed++
    }
    [PSCustomObject]$row
}

$report | Format-Table -AutoSize | Out-String -Width 220 | Write-Host
if ($failed -gt 0) { exit 1 }
Write-Host "Done. Start a new Codex session in each project to load the changes."