#!/bin/bash

script_name=$(basename "$0")
package_name="phantomjs"
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

shift $((OPTIND - 2))
architecture="$1"

if [ $a_flag -eq 1 ]; then
  if [ $architecture = "32bit" ]; then
    url=$(cat ../linux/url_list.txt | grep i686)
    file_path=$(basename "$url")
    destination_path="../${file_path}"

    wget -O "$destination_path" "$url"
  elif [ $architecture = "64bit" ]; then
    url=$(cat ../linux/url_list.txt | grep x86_64)
    file_path=$(basename "$url")
    destination_path="../${file_path}"

    wget -O "$destination_path" "$url"
  fi
else
  (
    cd ../
    wget -i linux/url_list.txt
  )
fi
