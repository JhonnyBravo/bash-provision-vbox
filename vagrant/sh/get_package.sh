#!/bin/bash

script_name=$(basename "$0")
package_name="vagrant"
a_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} [-a architecture]
  ${script_name} -h

DESCRIPTION
  ${package_name} をダウンロードします。
  -a オプションを指定しない場合は、
  32bit パッケージと 64bit パッケージの両方をダウンロードします。

OPTIONS
  -a architecture
    OS のアーキテクチャに合わせたパッケージをダウンロードします。

    有効な値:

    * 32bit
    * 64bit

  -h
    ヘルプを表示します。
_EOT_
exit 1
}

function get_package(){
  (
    cd ../
    url=$(cat debian/url_list.txt | grep "$1")
    wget "$url"
  )
}

while getopts "a:h" option
do
  case $option in
    a)
      a_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $a_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  architecture="$1"

  if [ $architecture = "32bit" ]; then
    get_package "i686"
  elif [ $architecture = "64bit" ]; then
    get_package "x86_64"
  fi
else
  (
    cd ..
    wget -i debian/url_list.txt
  )
fi
