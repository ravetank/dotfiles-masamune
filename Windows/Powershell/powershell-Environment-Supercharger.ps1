================================================================================
 ** PowerShell Environment Supercharger by Jacksonstrut - 2025.05.12 **
 **                    Enhanced Version with Fixes & Upgrades                   **
================================================================================

# PowerShell Environment Supercharger
# This script will set up a powerhouse PowerShell environment with premium modules and customizations

# 1. First, let's enable the PowerShell Gallery and set execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Check if PSGallery exists, if not register it
if (-not (Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue)) {
    Register-PSRepository -Default
}

# Trust the PSGallery repository
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

# 2. Install core PowerShell enhancement modules
$CoreModules = @(
    # Terminal enhancement
    "PSReadLine"          # Command line editing experience improvements
    "Terminal-Icons"      # File and folder icons in directory listings
    "posh-git"            # Git integration and status display
    "oh-my-posh"          # Prompt theming engine (cross-platform)
    "PSFzf"               # Fuzzy finder integration
    
    # Productivity & Functionality
    "ImportExcel"         # Excel interaction without Excel installed
    "PSScriptAnalyzer"    # Static code analysis for PowerShell
    "PowerShellGet"       # Package management for PowerShell
    "ThreadJob"           # Thread-based background jobs
    "Microsoft.PowerShell.SecretManagement" # Secure credential storage
    "Microsoft.PowerShell.SecretStore"      # Backend store for SecretManagement
    
    # System Management
    "PSWindowsUpdate"     # Windows Update management
    "Carbon"              # Windows system administration automation
    "PowerShellCookbook"  # Collection of useful functions
    "WingetTools"         # Winget package manager extensions
    
    # Network & Diagnostics
    "Pester"              # PowerShell testing framework
    "PSNetTools"          # Network diagnostic tools
    "DNSClient"           # DNS query utilities
    
    # Advanced & Development
    "PowerShellAI"        # AI tools for PowerShell (OpenAI API connection)
    "PSWriteHTML"         # HTML report generation
    "PSWriteColor"        # Colored output for scripts
    "PSMenu"              # Interactive menu systems for scripts
    "InvokeBuild"         # Task automation similar to make/rake
    "ModuleBuilder"       # Advanced module building
    "PoshRSJob"           # Runspace-based jobs for high performance
    "PSFramework"         # Advanced function framework
    "PSDesiredStateConfiguration" # DSC resources
)

Write-Host "Installing core modules. This may take some time..." -ForegroundColor Cyan

# Install modules (silently handling errors for any that might already exist or fail)
foreach ($Module in $CoreModules) {
    try {
        if (-not (Get-Module -ListAvailable -Name $Module -ErrorAction SilentlyContinue)) {
            Write-Host "Installing $Module..." -ForegroundColor Yellow
            Install-Module -Name $Module -Scope CurrentUser -AllowClobber -Force -SkipPublisherCheck
        } else {
            Write-Host "$Module is already installed" -ForegroundColor Green
        }
    } catch {
        Write-Host "Could not install $Module. Error: $_" -ForegroundColor Red
    }
}

# 3. Install Nerd Font (for terminal icons)
Write-Host "Installing a Nerd Font is recommended for Terminal-Icons. Open a web browser to download?" -ForegroundColor Yellow
$openNerdFonts = Read-Host "Open Nerd Fonts website? (Y/N)"
if ($openNerdFonts -eq "Y") {
    Start-Process "https://www.nerdfonts.com/font-downloads"
}

# 4. Set up Oh-My-Posh with a cool theme
$OhMyPoshThemes = @(
    "agnoster"
    "atomic"
    "bubblesline"
    "cyberpunk"
    "dracula"
    "hotstick"
    "jandedobbeleer"
    "lambda"
    "material"
    "paradox"
    "powerlevel10k_classic"
    "spaceship"
    "star"
    "thecyberden"
)

Write-Host "Available Oh-My-Posh themes:" -ForegroundColor Cyan
$i = 1
foreach ($theme in $OhMyPoshThemes) {
    Write-Host "$i. $theme" -ForegroundColor Yellow
    $i++
}

$themeChoice = Read-Host "Select a theme number (default: 10 - paradox)"
if (-not $themeChoice) { $themeChoice = 10 }
$selectedTheme = $OhMyPoshThemes[$themeChoice - 1]

if (-not $selectedTheme) { $selectedTheme = "paradox" }

# 5. Choose package manager for additional tools
Write-Host "Choose your preferred package manager for additional tools:" -ForegroundColor Cyan
Write-Host "1. Winget (Windows Package Manager)" -ForegroundColor Yellow
Write-Host "2. Scoop (Command-line installer)" -ForegroundColor Yellow
Write-Host "3. Chocolatey (Package manager)" -ForegroundColor Yellow
Write-Host "4. Skip package manager installation" -ForegroundColor Yellow

$packageManagerChoice = Read-Host "Select option (1-4, default: 1)"
if (-not $packageManagerChoice) { $packageManagerChoice = 1 }

switch ($packageManagerChoice) {
    1 {
        # Winget installation
        if (Get-Command winget -ErrorAction SilentlyContinue) {
            Write-Host "Installing additional tools via winget..." -ForegroundColor Cyan
            $wingetPackages = @(
                "Microsoft.PowerToys"
                "JanDeDobbeleer.OhMyPosh"
                "wez.wezterm"
                "Clement.bottom"
                "sharkdp.fd"
                "BurntSushi.ripgrep.MSVC"
                "ajeetdsouza.zoxide"
                "Microsoft.WindowsTerminal"
                "sharkdp.bat"
                "dandavison.delta"
                "Starship.Starship"
            )
            
            foreach ($package in $wingetPackages) {
                Write-Host "Installing $package..." -ForegroundColor Yellow
                winget install --id $package --silent --accept-package-agreements --accept-source-agreements 2>$null
            }
        } else {
            Write-Host "Winget not found. Please install Windows Package Manager first." -ForegroundColor Red
        }
    }
    2 {
        # Scoop installation
        if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
            Write-Host "Installing Scoop..." -ForegroundColor Cyan
            Invoke-RestMethod get.scoop.sh | Invoke-Expression
        }
        
        if (Get-Command scoop -ErrorAction SilentlyContinue) {
            Write-Host "Installing additional tools via scoop..." -ForegroundColor Cyan
            scoop bucket add extras
            scoop bucket add nerd-fonts
            
            $scoopPackages = @(
                "powertoys", "oh-my-posh", "wezterm", "bottom", 
                "fd", "ripgrep", "zoxide", "windows-terminal",
                "bat", "delta", "starship"
            )
            
            foreach ($package in $scoopPackages) {
                Write-Host "Installing $package..." -ForegroundColor Yellow
                scoop install $package 2>$null
            }
        }
    }
    3 {
        # Chocolatey installation
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            Write-Host "Installing Chocolatey..." -ForegroundColor Cyan
            Set-ExecutionPolicy Bypass -Scope Process -Force
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        }
        
        if (Get-Command choco -ErrorAction SilentlyContinue) {
            Write-Host "Installing additional tools via chocolatey..." -ForegroundColor Cyan
            $chocoPackages = @(
                "powertoys", "oh-my-posh", "wezterm", "bottom",
                "fd", "ripgrep", "zoxide", "microsoft-windows-terminal",
                "bat", "delta", "starship"
            )
            
            foreach ($package in $chocoPackages) {
                Write-Host "Installing $package..." -ForegroundColor Yellow
                choco install $package -y 2>$null
            }
        }
    }
    4 {
        Write-Host "Skipping package manager installation." -ForegroundColor Yellow
    }
}

# 6. Back up existing profile and create/update PowerShell profile
$ProfileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path $ProfileDir)) {
    New-Item -Path $ProfileDir -ItemType Directory -Force | Out-Null
}

# Backup existing profile
if (Test-Path $PROFILE) {
    $backupPath = "$PROFILE.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Host "Backing up existing profile to: $backupPath" -ForegroundColor Yellow
    Copy-Item -Path $PROFILE -Destination $backupPath -Force
}

# Define Show-ModuleCommands function before it's referenced
function Show-ModuleCommands {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ModuleName
    )
    
    if (Get-Module -ListAvailable -Name $ModuleName) {
        Get-Command -Module $ModuleName | Format-Table -Property Name, CommandType
    } else {
        Write-Host "Module '$ModuleName' is not installed." -ForegroundColor Red
    }
}

$ProfileContent = @"
# ⚙️  PowerShell Environment Supercharger Profile Configuration
# Generated by PowerShell Environment Supercharger
# Last updated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

#region 🔧 Prerequisites and Imports
try {
    # Import essential modules
    Import-Module PSReadLine -ErrorAction Stop
    Import-Module Terminal-Icons -ErrorAction Stop
    Import-Module posh-git -ErrorAction Stop
    Import-Module PSFzf -ErrorAction Stop
} catch {
    Write-Warning "Some modules failed to load. Run the installer script again."
}
#endregion

#region ⚙️ PSReadLine Configuration
# Enable predictive IntelliSense
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -Colors @{
    Command = 'Cyan'
    Parameter = 'DarkCyan'
    Comment = 'DarkGreen'
    Operator = 'DarkYellow'
    Variable = 'Green'
    String = 'DarkRed'
    Number = 'DarkMagenta'
    Type = 'DarkGray'
    Member = 'Gray'
}

# Custom keybindings and history search
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key F2 -Function SwitchPredictionView

# Advanced tab completion
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Smart history search shortcuts
Set-PSReadLineKeyHandler -Chord Ctrl+r -Function ReverseSearchHistory
Set-PSReadLineKeyHandler -Chord Ctrl+f -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfHistory()
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
#endregion

#region 🔍 FZF Configuration
if (Get-Module -Name PSFzf -ListAvailable) {
    # Enable PSFzf key bindings
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    # Improve appearance with bat preview (if available)
    if (Get-Command bat -ErrorAction SilentlyContinue) {
        `$env:FZF_DEFAULT_OPTS = '--height 40% --layout=reverse --border --inline-info --preview "bat --style=numbers --color=always --line-range :500 {}"'
    } else {
        `$env:FZF_DEFAULT_OPTS = '--height 40% --layout=reverse --border --inline-info'
    }
}
#endregion

#region 🎨 Theme Configuration
# Try Oh-My-Posh first, then Starship as fallback
try {
    # Initialize Oh-My-Posh with selected theme
    oh-my-posh --init --shell pwsh --config "`$env:POSH_THEMES_PATH\$selectedTheme.omp.json" | Invoke-Expression
} catch {
    # Fallback to Starship if Oh-My-Posh fails
    if (Get-Command starship -ErrorAction SilentlyContinue) {
        Write-Host "Oh-My-Posh failed, using Starship as fallback..." -ForegroundColor Yellow
        Invoke-Expression (&starship init powershell)
    } else {
        Write-Warning "Neither Oh-My-Posh nor Starship are available. Using basic prompt."
    }
}
#endregion

#region 🚀 Custom Aliases and Functions
# Git shortcuts
function ggs { git status }
function ggl { git log --oneline --graph --decorate }
function ggp { git pull }
function ggc { param([string]`$msg = "Update") git add . ; git commit -m `$msg }

# Navigation shortcuts
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ~ { Set-Location `$HOME }

# Utility functions
function which (`$command) { Get-Command -Name `$command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path }
function touch (`$file) { if (Test-Path `$file) { (Get-Item `$file).LastWriteTime = Get-Date } else { New-Item -Type File `$file } }
function mkcd (`$path) { New-Item -Path `$path -ItemType Directory -Force; Set-Location -Path `$path }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }
function sudo { Start-Process pwsh -Verb RunAs -ArgumentList "-NoExit", "-Command", "cd `$pwd; `$args" }

# System info and utilities
function sysinfo {
    `$os = Get-CimInstance -ClassName Win32_OperatingSystem
    `$proc = Get-CimInstance -ClassName Win32_Processor
    `$mem = Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
    
    Write-Host "OS: `$(`$os.Caption) `$(`$os.Version)" -ForegroundColor Cyan
    Write-Host "CPU: `$(`$proc.Name)" -ForegroundColor Cyan
    Write-Host "Memory: `$(([math]::Round(`$mem.Sum / 1GB, 2))) GB" -ForegroundColor Cyan
    Write-Host "PowerShell: `$(`$PSVersionTable.PSVersion)" -ForegroundColor Cyan
}

function Get-Weather {
    param (
        [string]`$Location = ""
    )
    
    `$url = "https://wttr.in/`$Location"
    if (`$Location -eq "") {
        `$url = "https://wttr.in"
    }
    
    (Invoke-WebRequest -Uri `$url -UserAgent "curl" -UseBasicParsing).Content
}

# Quick directory traversal with zoxide if available
if (Get-Command "zoxide" -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
    # Add aliases
    Set-Alias -Name cd -Value __zoxide_zi -Option AllScope -Force
    Set-Alias -Name z -Value __zoxide_zi
}
#endregion

#region 📦 PowerShell Module Management
function Update-AllModules {
    # Update all installed modules
    Write-Host "Updating PowerShell modules..." -ForegroundColor Yellow
    Get-Module -ListAvailable | Where-Object { `$_.RepositorySourceLocation -ne `$null } | 
        Select-Object -Property Name -Unique | 
        ForEach-Object { 
            try {
                Update-Module -Name `$_.Name -ErrorAction SilentlyContinue -Force
                Write-Host "Updated `$(`$_.Name)" -ForegroundColor Green
            } catch {
                Write-Host "Failed to update `$(`$_.Name): `$_" -ForegroundColor Red
            }
        }
    Write-Host "Module updates complete!" -ForegroundColor Green
}

function Install-DevTools {
    # Install additional developer tools
    `$devModules = @(
        "Pester"
        "platyPS" 
        "PSScriptAnalyzer"
        "PSDepend"
        "PSRule"
        "PSRule.Rules.Azure"
    )
    
    foreach (`$module in `$devModules) {
        if (-not (Get-Module -ListAvailable -Name `$module)) {
            Install-Module -Name `$module -Scope CurrentUser -Force
        }
    }
}

function Show-ModuleCommands {
    param (
        [Parameter(Mandatory = `$true)]
        [string]`$ModuleName
    )
    
    if (Get-Module -ListAvailable -Name `$ModuleName) {
        Get-Command -Module `$ModuleName | Format-Table -Property Name, CommandType
    } else {
        Write-Host "Module '`$ModuleName' is not installed." -ForegroundColor Red
    }
}
#endregion

#region 🎯 Prompt Customization (Fallback)
function global:PromptWriteErrorInfo() {
    if (`$LASTEXITCODE -ne 0) {
        Write-Host " [Exit: `$LASTEXITCODE] " -NoNewline -ForegroundColor Red
    }
}

# If not using Oh-My-Posh or Starship for some reason, this is a good backup prompt
if (-not (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue) -and -not (Get-Command -Name starship -ErrorAction SilentlyContinue)) {
    function global:prompt {
        `$location = (Get-Location).Path.Replace(`$HOME, "~")
        `$host.UI.RawUI.WindowTitle = "`$location"
        
        Write-Host ""
        Write-Host "[" -NoNewline
        Write-Host (Get-Date -Format "HH:mm:ss") -NoNewline -ForegroundColor Blue
        Write-Host "] " -NoNewline
        
        # Git status if in git repo
        if (Get-Command -Name git -ErrorAction SilentlyContinue) {
            try {
                `$gitBranch = git rev-parse --abbrev-ref HEAD 2>`$null
                if (`$gitBranch) {
                    Write-Host "git:" -NoNewline -ForegroundColor White
                    Write-Host "`$gitBranch" -NoNewline -ForegroundColor Magenta
                    
                    # Check for changes
                    `$gitStatus = git status --porcelain
                    if (`$gitStatus) {
                        Write-Host "*" -NoNewline -ForegroundColor Red
                    }
                    Write-Host " " -NoNewline
                }
            } catch {}
        }
        
        # Path
        Write-Host `$location -NoNewline -ForegroundColor Yellow
        PromptWriteErrorInfo
        
        # Final prompt character
        Write-Host ""  # Newline
        Write-Host "PS>" -NoNewline -ForegroundColor Green
        return " "
    }
}
#endregion

#region 🔄 Auto-Reload Profile on Save (Development Mode)
if (Test-Path `$PROFILE) {
    try {
        Register-ObjectEvent -InputObject (Get-Item `$PROFILE) -EventName "Changed" -Action {
            . `$PROFILE
            Write-Host "🔄 PowerShell profile reloaded automatically!" -ForegroundColor Green
        } -ErrorAction SilentlyContinue
    } catch {
        # Silently continue if auto-reload fails
    }
}
#endregion

#region 🎉 Startup Banner and Initialization
# Display startup banner
Write-Host "🚀 PowerShell Super Environment Loaded!" -ForegroundColor Cyan
Write-Host "💡 Type 'Get-Command -Module <ModuleName>' to see available commands in a module" -ForegroundColor DarkGray
Write-Host "🌡️  Type 'sysinfo' to see system information" -ForegroundColor DarkGray
Write-Host "🌤️  Type 'Get-Weather' to check the weather" -ForegroundColor DarkGray
Write-Host "📦 Type 'Update-AllModules' to update all PowerShell modules" -ForegroundColor DarkGray

# Initialize Terminal-Icons
Import-Module Terminal-Icons

# Initialize PSReadLine with smart suggestions
Set-PSReadLineOption -PredictionSource History

# Initialize Posh-Git for Git integration
Import-Module posh-git
#endregion
"@

# Write the profile using Set-Content instead of Out-File
Set-Content -Path $PROFILE -Value $ProfileContent -Encoding UTF8

# 7. Configure package manager settings if available
if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Configuring winget settings..." -ForegroundColor Cyan
    
    $wingetSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json"
    
    if (Test-Path $wingetSettingsPath) {
        $wingetSettings = Get-Content -Path $wingetSettingsPath -Raw | ConvertFrom-Json
    } else {
        $wingetSettings = @{}
    }
    
    # Configure winget settings
    $wingetSettings | Add-Member -NotePropertyName 'experimentalFeatures' -NotePropertyValue @{
        'experimentalArg' = $true
        'experimentalCmd' = $true
        'experimentalMSStore' = $true
        'list' = $true
        'directMSI' = $true
        'resume' = $true
    } -Force
    
    $wingetSettings | ConvertTo-Json | Out-File -FilePath $wingetSettingsPath -Force -Encoding UTF8
}

# 8. Final setup and verification
Write-Host "🎉 PowerShell environment setup is complete!" -ForegroundColor Green
Write-Host "🔄 Close and reopen PowerShell to apply all changes." -ForegroundColor Yellow
Write-Host "⚡ Or run '. `$PROFILE' to reload the profile in the current session." -ForegroundColor Yellow

# One-line installation command (for clipboard) for future reference
$oneLineInstaller = "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; Install-Module PSReadLine, Terminal-Icons, posh-git, oh-my-posh, PSFzf -Scope CurrentUser -Force"

Write-Host "`n📋 For quick setup on other machines, use this one-liner:" -ForegroundColor Cyan
Write-Output $oneLineInstaller
Write-Host "`n"

# Optional: Create a system restore point
$createRestorePoint = Read-Host "🛡️  Create a System Restore Point before continuing? (Y/N)"
if ($createRestorePoint -eq "Y") {
    Write-Host "Creating system restore point..." -ForegroundColor Cyan
    Checkpoint-Computer -Description "PowerShell Environment Supercharger Installation" -RestorePointType "APPLICATION_INSTALL"
}

# Finished!
Write-Host "✅ Everything is set up. Enjoy your new PowerShell environment!" -ForegroundColor Green

# Show available commands
Write-Host "💡 To see available commands in your new modules, use:" -ForegroundColor Cyan
Write-Host "Show-ModuleCommands -ModuleName PSReadLine" -ForegroundColor Yellow