#! /bin/bash
# ----------------------------------------------------------------------
# file: security_check.sh
# author: keefe, wuqifu@gmail.com
# date: 2016/5/8, 2017/10/15
# note: check database password, langs sensitive functions(string,...)
#   use check_langs_list.xls to compare
# ----------------------------------------------------------------------

dir=$1

# check db passwd
key="connect"
key2="root"
#find $dir -iname "*.php" |xargs grep $key
#grep -rl $key $dir | xargs grep $key
grep -rl $key2 $dir | xargs grep $key2

# check c/cpp


# check java


# check python
