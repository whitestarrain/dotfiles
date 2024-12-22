#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

dot_bashd_path="$(dirname -- "$(realpath "${BASH_SOURCE[0]}")")/.bashrc.d"

function check_source_file {
  if [ ! $# -gt 0 ]; then
    return
  fi
  local file_name=$1
  file_path="$dot_bashd_path/$file_name"
  if [ -s "$file_path" ]; then
    source "$file_path"
  fi
}

# base config
check_source_file xdg.sh
check_source_file base.sh
check_source_file base_extra.sh
check_source_file alias.sh
check_source_file path.sh

# command line tool
check_source_file fzf.sh
check_source_file z.sh
check_source_file ranger.sh
check_source_file node.sh
check_source_file starship.sh

# history config, must be placed last
check_source_file history.sh

unset -f check_source_file
