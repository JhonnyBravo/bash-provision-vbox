#!/bin/bash

function usage(){
cat <<_EOT_
Usage:
  ${0} -i pattern path
  ${0} -e pattern path
  ${0} -h

Description:
  path に指定したファイルを読み込み、
  pattern に合致する行または合致しない行のみを表示します。

Options:
  -i pattern path  pattern に合致する行のみを表示します。
  -e pattern path  pattern に合致しない行のみを表示します。
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

shift $((OPTIND - 1))
pattern="$1"
path="$2"

if [ $i_flag -eq 1 ]; then
  grep "${pattern}" <"$path"
elif [ $e_flag -eq 1 ]; then
  sed -e "/${pattern}/d" <"$path"
elif [ $i_flag -eq 0 -a $e_flag -eq 0 ]; then
  usage
fi