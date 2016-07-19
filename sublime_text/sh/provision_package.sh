#!/bin/bash

script_name=$(basename "$0")
dpkg_package="sublime-text"
apt_package="ibus-mozc emacs-mozc"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} -i architecture
  ${script_name} -u
  ${script_name} -h

DESCRIPTION
  ${dpkg_package} ${apt_package} をインストール / アンインストールします。

OPTIONS
  -i architecture
    OS のアーキテクチャに合わせたパッケージをインストールします。

    有効な値:

    * 32bit
    * 64bit

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
    source_path=$(ls | grep "$1")
    dpkg -i "$source_path"
    apt-get install $apt_package
    rm "$source_path"
  )
}

function uninstall_package(){
  dpkg -P "$dpkg_package"
  apt-get purge $apt_package
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
  architecture="$1"

  if [ $architecture = "32bit" ]; then
    install_package "i386"
  elif [ $architecture = "64bit" ]; then
    install_package "amd64"
  fi
elif [ $u_flag -eq 1 ]; then
  uninstall_package
fi
