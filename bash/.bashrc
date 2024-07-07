# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# prevent timeout
export TMOUT=0

# add path
PATH=$PATH:~/go/bin
PATH=$PATH:~/.bin

# prompt before overwrite
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pc='proxychains4'
alias ssh='TERM=xterm-256color ssh'

# don't logout when press ctrl-d
set -o ignoreeof

# dircolors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# fzf
[ -f "~/.fzf.bash" ] && source ~/.fzf.bash
[ -f "/usr/share/fzf/completion.bash" ] && source /usr/share/fzf/completion.bash
[ -f "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash

# z
[ -f "~/.z.bash" ] && source ~/.z.bash
[ -f "/opt/z/z.sh" ] && source /opt/z/z.sh
[ -f "/usr/share/z/z.sh" ] && source /usr/share/z/z.sh

# starship
[ -n $(which starship 2>/dev/null) ] && eval "$(starship init bash)"

# ranger
alias ra='ranger'
function ranger {
  local IFS=$'\t\n'
  local tempfile="$(mktemp -t tmp.XXXXXX)"
  local ranger_cmd=(
    command
    ranger
    --cmd="map Q chain shell echo %d > \"$tempfile\"; quitall"
  )

  ${ranger_cmd[@]} "$@"
  if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
    cd -- "$(cat -- "$tempfile")" || return
  fi
  command rm -f -- "$tempfile" 2>/dev/null
}

# fnm
if which fnm &> /dev/null; then
  export FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
  fnm completions --shell bash &> /dev/null
  eval "$(fnm env)"
else
  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
  [ ! -s "$NVM_DIR/nvm.sh" ] &&  [ -f "/usr/share/nvm/nvm.sh" ] && source /usr/share/nvm/nvm.sh
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  [ ! -s "$NVM_DIR/bash_completion" ] && [ -f "/usr/share/nvm/bash_completion" ] && source /usr/share/nvm/bash_completion
fi
