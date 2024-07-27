#!/usr/bin/env bash

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

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

