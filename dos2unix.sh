#! /bin/bash
# 配置文件转换为unix格式（windos->mac/linux）

function read_dir(){

  if [[ $1 =~ "vim_plug_download" ]] || [[ $1 =~ "exe" ]]
  then
    return 
  fi

  for file in $(ls "$1")
  do
    if [ -d "$1""/""$file" ];
    then read_dir "$1""/""$file"
    else
      dos2unix "$1""/""$file"
    fi
  done
}

read_dir "."
