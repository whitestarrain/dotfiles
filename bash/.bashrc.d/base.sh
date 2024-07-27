#!/usr/bin/env bash

# default editor, manpager
if which nvim &>/dev/null; then
  export EDITOR='nvim -u NONE'
  export MANPAGER="nvim +Man!"
fi

# prevent timeout
export TMOUT=0

# don't logout when press ctrl-d
set -o ignoreeof

# dircolors
test -r ~/.dir_colors && eval "$(dircolors ~/.dir_colors)"

