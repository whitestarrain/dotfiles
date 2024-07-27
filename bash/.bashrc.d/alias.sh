#!/usr/bin/env bash

# prompt before overwrite
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pc='proxychains4'
alias ssh='TERM=xterm-256color ssh'
alias hisupdate='history -a; history -c; history -r;'

# swich proxy
alias sp="switchproxy"
function switchproxy {
  if [ -n "$http_proxy" ] || [ -n "$https_proxy" ] || [ -n "$all_proxy" ]; then
    echo "unset terminal proxy"
    unset http_proxy https_proxy all_proxy
    return
  fi
  default_proxy="http://127.0.0.1:7890"
  export http_proxy="$default_proxy"
  export https_proxy="$default_proxy"
  export all_proxy="$default_proxy"
  echo "set terminal proxy"
}

