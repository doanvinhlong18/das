param(
    [ValidateSet("User", "Project")]
    [string]$Scope = "User",

    [string]$SourceRoot = (Join-Path $PSScriptRoot "..\..\.."),

    [string]$ProjectRoot,

    [ValidateSet("Auto", "SymbolicLink", "Junction")]
    [string]$LinkType = "Auto",

    [switch]$Json
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-AbsolutePath {
    param([Parameter(Mandatory = $true)][string]$Path)

    return [System.IO.Path]::GetFullPath($Path)
}

function Get-UserHome {
    if (-not [string]::IsNullOrWhiteSpace($env:HOME)) {
        return $env:HOME
    }
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        return $env:USERPROFILE
    }

    $profile = [Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
    if ([string]::IsNullOrWhiteSpace($profile)) {
        throw "Unable to determine the user home directory."
    }
    return $profile
}

function Resolve-LinkTarget {
    param(
        [Parameter(Mandatory = $true)][System.IO.FileSystemInfo]$Item,
        [Parameter(Mandatory = $true)][string]$Parent
    )

    $targets = @($Item.Target)
    if ($targets.Count -eq 0 -or [string]::IsNullOrWhiteSpace([string]$targets[0])) {
        return $null
    }
    $target = [string]$targets[0]
    if (-not [System.IO.Path]::IsPathRooted($target)) {
        $target = Join-Path $Parent $target
    }
    return Get-AbsolutePath $target
}

function New-DirectoryLink {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Target,
        [Parameter(Mandatory = $true)][string]$RequestedType
    )

    if ($RequestedType -eq "SymbolicLink") {
        New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
        return "SymbolicLink"
    }

    if ($RequestedType -eq "Junction") {
        if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
            throw "Junction links are supported only on Windows."
        }
        New-Item -ItemType Junction -Path $Path -Target $Target | Out-Null
        return "Junction"
    }

    try {
        New-Item -ItemType SymbolicLink -Path $Path -Target $Target | Out-Null
        return "SymbolicLink"
    }
    catch {
        if ([Environment]::OSVersion.Platform -ne [PlatformID]::Win32NT) {
            throw
        }
        New-Item -ItemType Junction -Path $Path -Target $Target | Out-Null
        return "Junction"
    }
}

$source = Get-AbsolutePath $SourceRoot
if (-not (Test-Path -LiteralPath (Join-Path $source "core"))) {
    throw "Source root does not contain core/: $source"
}
if (-not (Test-Path -LiteralPath (Join-Path $source "domains"))) {
    throw "Source root does not contain domains/: $source"
}

if ($Scope -eq "User") {
    $destinationRoot = Join-Path (Get-UserHome) ".agents\skills"
}
else {
    if ([string]::IsNullOrWhiteSpace($ProjectRoot)) {
        throw "ProjectRoot is required when Scope is Project."
    }
    $project = Get-AbsolutePath $ProjectRoot
    if (-not (Test-Path -LiteralPath $project -PathType Container)) {
        throw "ProjectRoot does not exist: $project"
    }
    $destinationRoot = Join-Path $project ".agents\skills"
}

New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null

$skillDirectories = @()
foreach ($layer in @("core", "domains")) {
    $layerPath = Join-Path $source $layer
    $skillDirectories += Get-ChildItem -LiteralPath $layerPath -Directory |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName "SKILL.md") }
}

$duplicates = $skillDirectories | Group-Object Name | Where-Object Count -gt 1
if ($duplicates) {
    $names = ($duplicates | ForEach-Object Name) -join ", "
    throw "Duplicate skill directory names cannot be linked safely: $names"
}

$results = @()
foreach ($skill in ($skillDirectories | Sort-Object Name)) {
    $target = Get-AbsolutePath $skill.FullName
    $destination = Join-Path $destinationRoot $skill.Name
    $status = "created"
    $actualType = $null

    if (Test-Path -LiteralPath $destination) {
        $existing = Get-Item -LiteralPath $destination -Force
        $resolvedTarget = Resolve-LinkTarget -Item $existing -Parent $destinationRoot
        if ($null -eq $resolvedTarget) {
            throw "Destination exists and is not a link: $destination"
        }
        if (-not $resolvedTarget.Equals($target, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Destination link points elsewhere: $destination -> $resolvedTarget"
        }
        $status = "already-linked"
        $actualType = [string]$existing.LinkType
    }
    else {
        $actualType = New-DirectoryLink -Path $destination -Target $target -RequestedType $LinkType
    }

    $results += [PSCustomObject]@{
        skill = $skill.Name
        source = $target
        destination = Get-AbsolutePath $destination
        link_type = $actualType
        status = $status
    }
}

if ($Json) {
    $results | ConvertTo-Json -Depth 4
}
else {
    $results
}
