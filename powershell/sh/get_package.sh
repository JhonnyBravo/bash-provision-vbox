#!/bin/bash

script_name=$(basename "$0")
package_name="powershell"

function usage(){
cat <<_EOT_
NAME
  ${script_name} version
  ${script_name} -h

DESCRIPTION
  ${package_name} をダウンロードします。

OPTIONS
  version
    OS のバージョンに合わせたパッケージをダウンロードします。

    有効な値:

    * 14.04
    * 16.04

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

version="$1"

if [ "$version" = "14.04" ]; then
  url=$(awk '/14.04/ {print $2}' < ../ubuntu/url_list.txt)
  wget "$url"
elif [ "$version" = "16.04" ]; then
  url=$(awk '/16.04/ {print $2}' < ../ubuntu/url_list.txt)
  wget "$url"
fi
