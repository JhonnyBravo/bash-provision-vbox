#!/bin/bash

script_name=$(basename "$0")
s_flag=0

base_path="${HOME}/.config/sublime-text-3/Packages/User"
dst_pkg_ctrl="${base_path}/Package Control.sublime-settings"
dst_preferences="${base_path}/Preferences.sublime-settings"

function usage(){
cat <<_EOT_
NAME
  ${script_name}

USAGE
  ${script_name} -s path
  ${script_name} -h

DESCRIPTION
  指定したディレクトリに存在するユーザ設定ファイルを
  ${dst_pkg_ctrl} と
  ${dst_preferences} へコピーします。

OPTIONS
  -s path
      コピー元ディレクトリを指定します。

  -h  ヘルプを表示します。
_EOT_
exit 1
}

while getopts "s:h" option
do
  case $option in
    s)
      s_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $s_flag -eq 1 ]; then
  shift $((OPTIND - 2))

  path="$1"
  src_pkg_ctrl=$(find "$path" -name "Package Control.sublime-settings")
  src_preferences=$(find "$path" -name "Preferences.sublime-settings")

  if [ -f "$src_pkg_ctrl" ]; then
    cp "$src_pkg_ctrl" "$dst_pkg_ctrl"
  fi

  if [ -f "$src_preferences" ]; then
    cp "$src_preferences" "$dst_preferences"
  fi
fi
