#!/bin/bash

function usage(){
cat <<_EOT_
Usage:
   get_child_item.sh [path] [-h]
   get_child_item.sh -i pattern [path]
   get_child_item.sh -e pattern [path]

Description:
   指定した path の配下にあるファイル / ディレクトリを一覧表示します。
   path を省略した場合、現在のディレクトリ内に存在する
   ファイル / ディレクトリを一覧表示します。

Options:
   -i pattern [path] pattern に合致する名前を持つ
                     ファイル / ディレクトリを一覧表示します。
   -e pattern [path] pattern に合致しない名前を持つ
                     ファイル / ディレクトリを一覧表示します。
   -h ヘルプを表示します。
_EOT_
exit 1
}

i_flag=0
e_flag=0

while getopts "ieh" option
do
   case $option in
      i)
         i_flag=1
         ;;
      e)
         e_flag=1
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
   shift $(expr $OPTIND - 1)
   pattern="$1"
   path="$2"
   ls "${path:=.}" | grep "${pattern}"
elif [ $e_flag -eq 1 ]; then
   shift $(expr $OPTIND - 1)
   pattern="$1"
   path="$2"
   ls "${path:=.}" | sed -e "/${pattern}/d"
else
   path="$1"
   ls "${path:=.}"
fi
