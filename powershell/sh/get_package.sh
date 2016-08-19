#!/bin/bash

script_name=$(basename "$0")
package_name="powershell"
v_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} [-v version]
  ${script_name} -h

DESCRIPTION
  ${package_name} をダウンロードします。

OPTIONS
  -v version
    OS のバージョンに合わせたパッケージをダウンロードします。

    有効な値:

    * 14.04
    * 16.04

  -h
    ヘルプを表示します。
_EOT_
exit 1
}

function get_package(){
  (
    cd ../
    url=$(grep "$1" -a ubuntu/url_list.txt | awk '{print $2}')
    wget "$url"
  )
}

while getopts "v:h" option
do
  case $option in
    v)
      v_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $v_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  version="$1"

  if [ "$version" = "14.04" ]; then
    get_package "14.04"
  elif [ "$version" = "16.04" ]; then
    get_package "16.04"
  fi
fi
