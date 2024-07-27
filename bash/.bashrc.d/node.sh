#!/usr/bin/env bash

# fnm
if which fnm &>/dev/null; then
  export FNM_NODE_DIST_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
  fnm completions --shell bash &>/dev/null
  eval "$(fnm env)"
else
  # nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
  [ ! -s "$NVM_DIR/nvm.sh" ] && [ -f "/usr/share/nvm/nvm.sh" ] && source /usr/share/nvm/nvm.sh
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
  [ ! -s "$NVM_DIR/bash_completion" ] && [ -f "/usr/share/nvm/bash_completion" ] && source /usr/share/nvm/bash_completion
fi

