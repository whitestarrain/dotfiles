#!/usr/bin/env bash

add_to_path() {
    local dir re

    for dir; do # for dir in "$@"; do
        re="(^$dir:|:$dir:|:$dir$)"
        if ! [[ $PATH =~ $re ]]; then
            PATH="$dir:$PATH"
        fi
    done
}

# add path
add_to_path ~/.bin
add_to_path ~/go/bin
add_to_path ~/.local/share/cargo/bin

