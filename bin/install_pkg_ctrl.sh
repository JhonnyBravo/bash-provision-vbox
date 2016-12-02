#!/bin/bash

script_name=$(basename "$0")

dst="${HOME}/.config/sublime-text-3/Installed Packages"
src="./Package Control.sublime-package"

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} [-h]

DESCRIPTION
  Package Control を Sublime Text へインストールします。

OPTIONS
  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "h" option
do
  case $option in
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ ! -d "$dst" ]; then
  echo "${dst} は存在しません。"
  exit 1
elif [ ! -f "$src" ]; then
  echo "${src} は存在しません。"
  exit 1
fi

cp "$src" "$dst"
rm "$src"
