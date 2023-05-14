# git env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
$env:LESSCHARSET="utf-8"  # for git less

# env:path reload
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# $env:JAVA_TOOL_OPTIONS=' -Dfile.encoding=UTF-8'

# fix Unrecognizable Code for `findstr` and `grep`
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Shut down automatically update。issue: https://github.com/PowerShell/PowerShell/issues/8663
$env:POWERSHELL_UPDATECHECK="Off"

# Alias
Set-Alias ll ls
Set-Alias tig 'D:\scoop\shims\tig.exe'
Set-Alias grep findstr
Set-Alias f floaterm
Set-Alias vi nvim
Set-Alias vim nvim

# function
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# starship
# DEPN: scoop install starship
Invoke-Expression (&starship init powershell)

# DEPN: Install-Module -Name z
# DEPN: Install-Module -Name Terminal-Icons -Repository PSGallery -Force
# DEPN: Install-Module -Name PSReadLine --AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
# DEPN: scoop install fzf
# DEPN: Install-Module -Name PSFzf -Scope CurrentUser -Force
if ($PSVersionTable.PSVersion.Major -eq 7){
  # Import-Module posh-git
  Import-Module -Name Terminal-Icons
  
  # command history: ~\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine
  # PSReadLine
  Set-PSReadLineOption -EditMode Emacs
  Set-PSReadLineOption -BellStyle None
  Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineOption -PredictionViewStyle ListView
  Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
  Set-PSReadLineOption -Colors @{
    Command            = 'Magenta'
    Variable           = 'DarkGreen'
    Parameter          = '#636363'
    Operator           = '#ddfff2'
    Default            = '#ebdbb2'
    # Number             = 'DarkGray'
    # Member             = 'DarkGray'
    # Type               = 'DarkGray'
    # ContinuationPrompt = 'DarkGray'
  }

  # clean command history for PSReadLine
  # Remove-Item (Get-PSReadlineOption).HistorySavePath

  # Fzf
  Import-Module PSFzf
  $env:FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
}

clear
