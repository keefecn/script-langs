#! /bin/bash
#@file: security_check.sh

dir=$1

# check out db passwd
key="connect"
key2="root"
#find $dir -iname "*.php" |xargs grep $key
#grep -rl $key $dir | xargs grep $key
grep -rl $key2 $dir | xargs grep $key2
