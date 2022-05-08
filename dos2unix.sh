#! /bin/bash
# 配置文件转换为unix格式（windos->mac/linux）

function read_dir() {

	if [[ $1 =~ "vim_plug_download" ]] || [[ $1 =~ "exe" ]]; then
		return
	fi

	for file in "$1"/*; do
		if [ -d "$file" ]; then
			read_dir "$file"
		else
			dos2unix -f "$file"
		fi
	done
}

read_dir "."
