#!/usr/bin/env bash

# default editor, manpager
if which nvim &>/dev/null; then
  export EDITOR='nvim -u NONE'
  export MANPAGER="nvim +Man!"
fi

# dircolors
test -r ~/.dir_colors && eval "$(dircolors ~/.dir_colors)"

