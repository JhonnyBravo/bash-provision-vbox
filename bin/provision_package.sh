#!/bin/bash

script_name=$(basename "$0")
dpkg_package="virtualbox"
apt_package="libsdl1.2debian"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} -i architecture
  ${script_name} -u file_name
  ${script_name} -h

DESCRIPTION
  ${dpkg_package} と ${apt_package} をインストール / アンインストールします。

OPTIONS
  -i architecture
    OS のアーキテクチャに合わせたパッケージをインストールします。

    有効な値:

    * 32bit
    * 64bit

  -u file_name
    パッケージをアンインストールします。

  -h
    ヘルプを表示します。
_EOT_
exit 1
}

function install_package(){
  source_path=$(find . -name "virtualbox-*${1}.deb")
  apt-get install "$apt_package"
  dpkg -i "$source_path"
  rm "$source_path"
}

function uninstall_package(){
  version=$(
    basename $(awk '{print $2}' < "$1") \
      | tr "-" " " \
      | tr "_" " " \
      | awk '{print $2}'
  )

  dpkg -P "${dpkg_package}-${version}"
  apt-get purge "$apt_package"
}

while getopts "i:u:h" option
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

  if [ "$architecture" = "32bit" ]; then
    install_package "i386"
  elif [ "$architecture" = "64bit" ]; then
    install_package "amd64"
  fi
elif [ $u_flag -eq 1 ]; then
  shift $((OPTIND - 2))
  file_name="$1"
  uninstall_package "$file_name"
fi
