#
# ~/.bash_profile
#

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

# default editor, manpager
if which nvim &> /dev/null; then
  export EDITOR='nvim -u NONE'
  export MANPAGER="nvim +Man!"
fi

# prevent timeout
export TMOUT=0

# command history limit
export HISTFILESIZE=2000
export HISTSIZE=2000

# GnuPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Javascript
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# Python
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/repl_startup.py
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python
export IPYTHONDIR="$XDG_DATA_HOME"/ipython

# Rust
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup


# .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

