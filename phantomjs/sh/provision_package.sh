#!/bin/bash

script_name=$(basename "$0")
package_name="phantomjs"
destination_path="/usr/local/bin"

i_flag=0
u_flag=0

function usage(){
cat <<_EOT_
NAME
  ${script_name} -i architecture
  ${script_name} -u
  ${script_name} -h

DESCRIPTION
  ${package_name} をインストール / アンインストールします。

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
    package_dir=$(find . -name "phantomjs*${1}*" | sed -e "s/.tar.bz2//")
    tar jxf "${package_dir}.tar.bz2"
    source_path="${package_dir}/bin/${package_name}"
    install "$source_path" "$destination_path"
    rm "${package_dir}.tar.bz2"
    rm -R "$package_dir"
  )
}

function uninstall_package(){
  rm "${destination_path}/${package_name}"
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

  if [ "$architecture" = "32bit" ]; then
    install_package "i686"
  elif [ "$architecture" = "64bit" ]; then
    install_package "x86_64"
  fi
elif [ $u_flag -eq 1 ]; then
  uninstall_package
fi
