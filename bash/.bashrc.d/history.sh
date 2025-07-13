#!/usr/bin/env bash

# command history limit
export HISTFILESIZE=10000                            # HISTFILE limit
export HISTSIZE=5000                                 # shell session history limit
export HISTIGNORE="&:[ ]*:exit:clear"                # ignore command pattern, separated by :

# history append
shopt -s histappend

# realtime update history file
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# support multiline command
shopt -s cmdhist
shopt -s lithist
export HISTTIMEFORMAT='%F %T ' # history format

