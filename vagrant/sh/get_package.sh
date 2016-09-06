#!/bin/bash

script_name=$(basename "$0")
package_name="vagrant"

function usage(){
cat <<_EOT_
NAME
  ${script_name} architecture
  ${script_name} -h

DESCRIPTION
  ${package_name} をダウンロードします。

OPTIONS
  architecture
    OS のアーキテクチャに合わせたパッケージをダウンロードします。

    有効な値:

    * 32bit
    * 64bit

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

if [ "$architecture" = "32bit" ]; then
  url=$(awk '/i686/ {print $2}' < ../debian/url_list.txt)
  wget "$url"
elif [ "$architecture" = "64bit" ]; then
  url=$(awk '/x86_64/ {print $2}' < ../debian/url_list.txt)
  wget "$url"
fi
