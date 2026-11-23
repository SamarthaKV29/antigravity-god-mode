#Requires -Version 5.1
<#
.SYNOPSIS
    Non-destructive one-step installer & updater for antigravity-god-mode on Windows.
.DESCRIPTION
    Safe by default:
    - Creates ~/.gemini/config if missing, or adds ONLY new/missing items from this repo
      without deleting or overwriting existing user configs, rules, skills, or plugins.
    - Repairs broken 1-line Git POSIX symlink stub files in skills/ with real directories.
    - Pass -Update to overwrite existing repo-managed files (backing up modified files first).
    - Pass -LinkIde (optional) to link ~/.gemini/antigravity & ~/.gemini/antigravity-ide via
      Windows Directory Junctions (no Admin/Developer Mode required; symlinks are NOT used).
    - Works both from a local git clone (.\setup.ps1) and via 1-step remote install (irm ... | iex).
#>

[CmdletBinding()]
param(
    [switch]$Update,
    [switch]$LinkIde
)

$ErrorActionPreference = 'Stop'

$RepoUrl    = 'https://github.com/SamarthaKV29/antigravity-god-mode.git'
$ConfigRoot = Join-Path $HOME '.gemini\config'
$CoreSkills = @(
    'api-design-principles',
    'architecture',
    'clean-code',
    'commit',
    'concise-planning',
    'debugger',
    'error-handling-patterns',
    'skill-picker',
    'subagent-routing',
    'testing-patterns'
)

function Write-Step { param([string]$Message) Write-Host "[*] $Message" -ForegroundColor Cyan }
function Write-Ok   { param([string]$Message) Write-Host "[+] $Message" -ForegroundColor Green }
function Write-Skip { param([string]$Message) Write-Host "[=] $Message" -ForegroundColor DarkGray }
function Write-Warn { param([string]$Message) Write-Host "[!] $Message" -ForegroundColor Yellow }

function Repair-CoreSkills {
    param([Parameter(Mandatory)][string]$RootDir)
    $skillsDir  = Join-Path $RootDir 'skills'
    $catalogDir = Join-Path $RootDir 'skills-catalog'
    if (-not (Test-Path -LiteralPath $catalogDir)) { return }
    New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null

    foreach ($skill in $CoreSkills) {
        $src = Join-Path $catalogDir $skill
        $dst = Join-Path $skillsDir $skill
        if (-not (Test-Path -LiteralPath $src)) { continue }

        $needsRepair = $false
        if (-not (Test-Path -LiteralPath $dst)) {
            $needsRepair = $true
        } else {
            $item = Get-Item -LiteralPath $dst -Force
            # Replace broken 1-line Git POSIX symlink stub files (e.g. "../skills-catalog/clean-code")
            if (-not $item.PSIsContainer) {
                $needsRepair = $true
                Remove-Item -LiteralPath $dst -Force
            }
        }
        if ($needsRepair) {
            Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
            Write-Ok "Populated core skill directory: $skill"
        }
    }
}

function Sync-DirectorySafe {
    param(
        [Parameter(Mandatory)][string]$SourceDir,
        [Parameter(Mandatory)][string]$TargetDir,
        [switch]$OverwriteExisting
    )
    if (-not (Test-Path -LiteralPath $SourceDir)) { return }
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

    $srcRoot = (Resolve-Path -LiteralPath $SourceDir).Path.TrimEnd('\', '/')
    $added   = 0
    $updated = 0
    $skipped = 0

    Get-ChildItem -LiteralPath $srcRoot -Recurse -Force | ForEach-Object {
        $rel = $_.FullName.Substring($srcRoot.Length).TrimStart('\', '/')
        $dstPath = Join-Path $TargetDir $rel

        if ($_.PSIsContainer) {
            if (-not (Test-Path -LiteralPath $dstPath)) {
                New-Item -ItemType Directory -Path $dstPath -Force | Out-Null
            } elseif (-not (Get-Item -LiteralPath $dstPath -Force).PSIsContainer) {
                # Broken stub file where a directory should be (e.g. Git symlink file)
                Remove-Item -LiteralPath $dstPath -Force
                New-Item -ItemType Directory -Path $dstPath -Force | Out-Null
            }
            return
        }

        $dstParent = Split-Path -Parent $dstPath
        if (-not (Test-Path -LiteralPath $dstParent)) {
            New-Item -ItemType Directory -Path $dstParent -Force | Out-Null
        }

        if (-not (Test-Path -LiteralPath $dstPath)) {
            Copy-Item -LiteralPath $_.FullName -Destination $dstPath -Force
            $added++
        } elseif ($OverwriteExisting) {
            $srcHash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash
            $dstHash = (Get-FileHash -LiteralPath $dstPath -Algorithm SHA256).Hash
            if ($srcHash -ne $dstHash) {
                $stamp = Get-Date -Format 'yyyyMMddHHmmss'
                Copy-Item -LiteralPath $dstPath -Destination "$dstPath.bak.$stamp" -Force
                Copy-Item -LiteralPath $_.FullName -Destination $dstPath -Force
                $updated++
            }
        } else {
            $skipped++
        }
    }

    Write-Ok "$TargetDir -> added: $added, updated: $updated, preserved existing: $skipped"
}

function Ensure-Junction {
    param(
        [Parameter(Mandatory)][string]$LinkPath,
        [Parameter(Mandatory)][string]$TargetPath
    )
    if (-not (Test-Path -LiteralPath $TargetPath)) {
        New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
    }
    if (Test-Path -LiteralPath $LinkPath) {
        $item = Get-Item -LiteralPath $LinkPath -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            $currentTarget = ($item.Target | Select-Object -First 1)
            if ($currentTarget -eq $TargetPath) {
                return
            }
            Remove-Item -LiteralPath $LinkPath -Force
        } else {
            Write-Skip "Kept existing directory: $LinkPath (not overwritten)"
            return
        }
    }
    $parent = Split-Path -Parent $LinkPath
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    New-Item -ItemType Junction -Path $LinkPath -Target $TargetPath | Out-Null
    Write-Ok "Linked $LinkPath -> $TargetPath"
}

# Resolve source: local repo clone OR 1-step remote bootstrap (irm ... | iex)
$TempClone = $null
$RepoRoot  = $null

if ($PSScriptRoot -and (Test-Path -LiteralPath (Join-Path $PSScriptRoot 'rules\GEMINI.md'))) {
    $RepoRoot = (Resolve-Path -LiteralPath $PSScriptRoot).Path
} else {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git is required for one-step remote install. Install Git and re-run."
    }
    if (-not (Test-Path -LiteralPath $ConfigRoot)) {
        Write-Step "Cloning antigravity-god-mode directly into $ConfigRoot..."
        New-Item -ItemType Directory -Path (Split-Path -Parent $ConfigRoot) -Force | Out-Null
        git clone --depth 1 $RepoUrl $ConfigRoot
        $RepoRoot = (Resolve-Path -LiteralPath $ConfigRoot).Path
    } else {
        $TempClone = Join-Path ([IO.Path]::GetTempPath()) ("agm-install-" + [Guid]::NewGuid().ToString('N').Substring(0, 8))
        Write-Step "Existing config detected at $ConfigRoot. Fetching latest repo to staging..."
        git clone --depth 1 $RepoUrl $TempClone
        $RepoRoot = $TempClone
    }
}

try {
    Write-Step "Verifying core skills in $RepoRoot\skills..."
    Repair-CoreSkills -RootDir $RepoRoot

    $NormalizedRepo   = (Resolve-Path -LiteralPath $RepoRoot).Path.TrimEnd('\', '/')
    $NormalizedConfig = if (Test-Path -LiteralPath $ConfigRoot) { (Resolve-Path -LiteralPath $ConfigRoot).Path.TrimEnd('\', '/') } else { $ConfigRoot }

    if ($NormalizedRepo -ne $NormalizedConfig) {
        $modeLabel = if ($Update) { 'update (with .bak backups)' } else { 'additive (new/missing only)' }
        Write-Step "Syncing customizations to $ConfigRoot [$modeLabel]..."
        New-Item -ItemType Directory -Path $ConfigRoot -Force | Out-Null

        foreach ($dir in @('rules', 'skills', 'skills-catalog', 'workflows', 'global_workflows')) {
            Sync-DirectorySafe `
                -SourceDir (Join-Path $RepoRoot $dir) `
                -TargetDir (Join-Path $ConfigRoot $dir) `
                -OverwriteExisting:$Update
        }

        foreach ($plugin in @('antigravity-god-mode', 'agency-agents')) {
            $pSrc = Join-Path $RepoRoot "plugins\$plugin"
            $pDst = Join-Path $ConfigRoot "plugins\$plugin"
            if (Test-Path -LiteralPath $pSrc) {
                Sync-DirectorySafe -SourceDir $pSrc -TargetDir $pDst -OverwriteExisting:$Update
            }
        }
    } else {
        Repair-CoreSkills -RootDir $ConfigRoot
    }

    if ($LinkIde) {
        Write-Step "Linking missing slots in Antigravity & Antigravity IDE to $ConfigRoot (using NTFS Junctions)..."
        $agRoot  = Join-Path $HOME '.gemini\antigravity'
        $ideRoot = Join-Path $HOME '.gemini\antigravity-ide'

        foreach ($root in @($agRoot, $ideRoot)) {
            foreach ($item in @('rules', 'skills', 'workflows', 'global_workflows', 'plugins')) {
                Ensure-Junction -LinkPath (Join-Path $root $item) -TargetPath (Join-Path $ConfigRoot $item)
            }
        }

        foreach ($shared in @('conversations', 'brain', 'code_tracker')) {
            Ensure-Junction -LinkPath (Join-Path $agRoot $shared) -TargetPath (Join-Path $ideRoot $shared)
        }
    }
} finally {
    if ($TempClone -and (Test-Path -LiteralPath $TempClone)) {
        Remove-Item -LiteralPath $TempClone -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Ok "antigravity-god-mode setup complete! (Existing user configs preserved)"
if (-not $LinkIde) {
    Write-Host "[i] Optional dual-IDE linking skipped. Pass -LinkIde if you want to link ~/.gemini/antigravity & ~/.gemini/antigravity-ide via Windows Junctions." -ForegroundColor Gray
}
