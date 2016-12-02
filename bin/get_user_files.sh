#!/bin/bash

script_name=$(basename "$0")
g_flag=0

base_path="${HOME}/.config/sublime-text-3/Packages/User"
pkg_ctrl="${base_path}/Package Control.sublime-settings"
preferences="${base_path}/Preferences.sublime-settings"

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} -g path
  ${script_name} -h

DESCRIPTION
  ${pkg_ctrl} と
  ${preferences} を指定したディレクトリへコピーします。

OPTIONS
  -g path
      コピー先ディレクトリを指定します。

  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "g:h" option
do
  case $option in
    g)
      g_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $g_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  path="$1"

  if [ -f "$pkg_ctrl" ]; then
    cp "$pkg_ctrl" "$path"
  fi

  if [ -f "$preferences" ]; then
    cp "$preferences" "$path"
  fi
fi
