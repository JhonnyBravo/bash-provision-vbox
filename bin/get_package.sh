#!/bin/bash

script_name=$(basename "$0")
package_name="vagrant"

function usage(){
cat <<_EOT_
NAME
  ${script_name} architecture file_name
  ${script_name} -h

DESCRIPTION
  ${package_name} をダウンロードします。

OPTIONS
  architecture
    OS のアーキテクチャに合わせたパッケージをダウンロードします。

    有効な値:

    * 32bit
    * 64bit

  file_name
    URL のリストが記載されたファイルのパスを指定します。

  -h
    ヘルプを表示します。
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

architecture="$1"
file_name="$2"

if [ "$architecture" = "32bit" ]; then
  url=$(awk '/i686/ {print $2}' < "$file_name")
  wget "$url"
elif [ "$architecture" = "64bit" ]; then
  url=$(awk '/x86_64/ {print $2}' < "$file_name")
  wget "$url"
else
  exit 2
fi
