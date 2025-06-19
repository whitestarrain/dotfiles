#!/usr/bin/env bash

# z

if type zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
else
  [ -f "/usr/share/z/z.sh" ] && source /usr/share/z/z.sh
fi
