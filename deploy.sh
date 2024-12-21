#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(dirname -- "$(realpath "${BASH_SOURCE[0]}")")"

symlink_file() {
  filename="$1"
  destination="$2"

  if [ -L "$destination" ]; then
    if [ "$(realpath "$filename")" == "$(realpath "$destination")" ]; then
      echo "[SKIP] $destination already point to $filename"
      return
    else
      echo "[ERROR] $filename already symlinked"
      return
    fi
  fi

  if [ -e "$destination" ]; then
    echo "[ERROR] $destination exists but it's not a symlink. Please fix that manually"
    exit 1
  fi

  ln -s "$filename" "$destination"
  echo "[OK] $filename -> $destination"
}

copy_file() {
  filename="$1"
  destination="$2"

  if [ ! -f "${filename}" ]; then
    echo "[ERROR] Can't copy ${filename} to ${destination}, Only common file support copy operation"
    return
  fi

  if which diff &> /dev/null; then
    file_diff=$(diff "${filename}" "${destination}")
    if [ -z "${file_diff}" ]; then
      echo "[SKIP] ${filename} and ${destination} has no diff"
      return
    fi
  fi

  sudo_prefix=""

  if [[ "$row" =~ ^/etc.* ]] && which feh &> /dev/null; then
    sudo_prefix="sudo "
  fi

  if [ -e "$destination" ]; then
    echo "[ERROR] $destination exists. Please fix that manually"
    return
  fi

  eval "${sudo_prefix} cp -rf ${filename} ${destination}"
  echo "[OK] cp $filename to $destination"
}

deploy() {
  IFS=$'\n' read -r -d '' -a lines < "$SCRIPT_DIR/$1" || echo ''
  for row in "${lines[@]}"; do
    if [[ "$row" =~ ^#.* ]]; then
      continue
    fi

    filename=$(echo "${SCRIPT_DIR}/$row" | cut -d \| -f 1)
    operation=$(echo "$row" | cut -d \| -f 2)
    destination=$(eval "echo $(echo "$row" | cut -d \| -f 3)")

    mkdir -p "$(dirname "$destination")"

    if [ "$(realpath "$(dirname "$filename")")" == "$(realpath "$(dirname "$destination")")" ]; then
      echo "[ERROR] The path to $filename and $destination are the same"
      exit 1
    fi

    if [ ! -e "${filename}" ]; then
      echo "[ERROR] ${filename} doesn't exist"
      exit 1
    fi

    case $operation in
    symlink)
      symlink_file "$filename" "$destination"
      ;;
    copy)
      copy_file "$filename" "$destination"
      ;;

    *)
      echo "[WARNING] Unknown operation $operation. Skipping..."
      ;;
    esac
  done
}

if [ -z "$*" ]; then
  echo "Usage: $0 <MANIFEST>"
  echo "ERROR: no MANIFEST file is provided"
  exit 1
fi

deploy "$1"

