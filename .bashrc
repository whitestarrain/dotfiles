# .bashrc

# prompt before overwrite
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# default editor
export EDITOR='nvim -u NONE'

# don't logout when press ctrl-d
set -o ignoreeof

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# z
[ -f ~/.z.bash ] && source ~/.z.bash
[ -f /opt/z/z.sh ] && source /opt/z/z.sh

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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
