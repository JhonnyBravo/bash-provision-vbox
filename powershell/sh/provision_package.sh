#!/bin/bash

script_name=$(basename "$0")
package_name="powershell"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} -i version
  ${script_name} -u
  ${script_name} -h

DESCRIPTION
  ${package_name} をインストール / アンインストールします。

OPTIONS
  -i version
    OS のバージョンに合わせたパッケージをインストールします。

    有効な値:

    * 14.04
    * 16.04

  -u
    パッケージをアンインストールします。

  -h
    ヘルプを表示します。
_EOT_
exit 1
}

function install_package(){
  (
    cd ../
    source_path=$(find . -name "powershell*${1}*.deb")
    dpkg -i "$source_path"
    rm "$source_path"
  )
}

function uninstall_package(){
  dpkg -P "$package_name"
}

while getopts "i:uh" option
do
  case $option in
    i)
      i_flag=1
      ;;
    u)
      u_flag=1
      ;;
    h)
      usage
      ;;
    \?)
      usage
      ;;
  esac
done

if [ $i_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  version="$1"

  if [ "$version" = "14.04" ]; then
    apt-get install libunwind8 libicu52
    install_package "14.04"
  elif [ "$version" = "16.04" ]; then
    apt-get install libunwind8 libicu55
    install_package "16.04"
  fi
elif [ $u_flag -eq 1 ]; then
  uninstall_package
fi
