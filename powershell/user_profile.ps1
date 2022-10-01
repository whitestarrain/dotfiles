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
Set-Alias tig 'D:\scoop\shims\tig.exe'
Set-Alias grep findstr
Set-Alias f floaterm

# function
function vi() {
  nvim -u NONE $args[0]
}
function vim() {
  nvim --cmd 'let g:skip_project_plugs=1' $args[0]
}
function nvimC(){
  nvim --cmd "let g:code_language_list=['c']" $args[0]
}
function nvimLua(){
  nvim --cmd "let g:code_language_list=['lua']" $args[0]
}
function nvimRu(){
  nvim --cmd "let g:code_language_list=['rust']" $args[0]
}
function nvimPy(){
  nvim --cmd "let g:code_language_list=['python']" $args[0]
}
function nvimTex(){
  nvim --cmd "let g:code_language_list=['latex']" $args[0]
}
function nvimGo(){
  nvim --cmd "let g:code_language_list=['golang']" $args[0]
}
function nvimFE(){ # frond end
  nvim --cmd "let g:code_language_list=['front']" $args[0]
}
function nvimVue(){
  nvim --cmd "let g:code_language_list=['front','vue']" $args[0]
}
function nvimBash(){
  nvim --cmd "let g:code_language_list=['bash']" $args[0]
}
function nvimVim(){
  nvim --cmd "let g:code_language_list=['vim']" $args[0]
}
function nvimConfig(){
  nvim --cmd "let g:code_language_list=['vim','lua','bash','dot']" $args[0]
}
function nvimDot(){
  nvim --cmd "let g:code_language_list=['dot']" $args[0]
}
function nvimPower(){
  nvim --cmd "let g:code_language_list=['c','rust','python','latex','golang','front','vue','vim','lua','bash','dot']" $args[0]
}

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# oh-my-posh
oh-my-posh --init --shell pwsh --config D:\MyRepo\dotfiles\powershell\white_star_rain.omp.json | Invoke-Expression

# DEPN: Install-Module -Name z
# DEPN: Install-Module -Name Terminal-Icons -Repository PSGallery -Force
# DEPN: Install-Module -Name PSReadLine --AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
# DEPN: scoop install fzf
# DEPN: Install-Module -Name PSFzf -Scope CurrentUser -Force
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
