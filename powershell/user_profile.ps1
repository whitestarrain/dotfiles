# chcp 65001
# Env
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"
$env:LESSCHARSET="utf-8"  # for git less
# env reload
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
# $env:JAVA_TOOL_OPTIONS=' -Dfile.encoding=UTF-8'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8  # fix Unrecognizable Code for `findstr` and `grep`

# Alias
Set-Alias ll ls
Set-Alias tig 'D:\learn\Git\usr\bin\tig.exe'
Set-Alias grep findstr

# function
function vi() {
  nvim -u NONE $args[0]
}
function vim() {
  nvim --cmd "let g:skip_project_plugs=1" $args[0]
}
function nvimC(){
  nvim --cmd "let g:c=1" $args[0]
}
function nvimRu(){
  nvim --cmd "let g:rust=1" $args[0]
}
function nvimPy(){
  nvim --cmd "let g:python=1" $args[0]
}
function nvimTex(){
  nvim --cmd "let g:latex=1" $args[0]
}
function nvimGo(){
  nvim --cmd "let g:golang=1" $args[0]
}
function nvimTS(){
  nvim --cmd "let g:typescript=1" $args[0]
}
function nvimVSC(){
  nvim --cmd "let g:vscode=1" $args[0]
}
function nvimFE(){
  nvim --cmd "let g:front=1" $args[0]
}
function nvimPower(){
  nvim --cmd "let g:power_lsp=1" $args[0]
}
function SpaceVim(){
  nvim -u D:/MyRepo/SpaceVim/init.vim $args[0]
}

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# oh-my-posh
D:\ProgramFiles\scoop\apps\oh-my-posh\current\bin\oh-my-posh.exe --init --shell pwsh --config D:\MyRepo\dotfiles\powershell\white_star_rain.omp.json | Invoke-Expression

# powershell module import for pwsh
# other installed module: z
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
