#! /bin/bash
# ----------------------------------------------------------------------
# file: replace_str.sh
# author: keefe, wuqifu@gmail.com
# date: 2021/7/8
# note: replace new_str to old_str in directory
# tools: 
#   regex support tools: find grep
# ----------------------------------------------------------------------


if [ $# -lt "2" ]; then
  echo usage: $0 [old_str] [new_str]
  exit 1;
fi

$OLDSTR=$1
$NEWSTR=$2
$DIR=$3


replace_word()
{
    sed -i "s/$OLDSTR/$NEWSTR/g" `grep -rl "$OLDSTR" $DIR`
}
