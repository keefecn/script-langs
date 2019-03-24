#!/bin/sh
# ============================================================== 
# Script Name:  get_cmd_src.sh 
# Desciption:   get cmd source on ubuntu
# interface 
# Date:         2019/3/24 
# Refer: https://blog.csdn.net/robertsong2004/article/details/52398920 
# Example: $ sh ./get_cmd_src.sh /usr/bin/msgfmt
# ============================================================= 

match_line=$(dpkg -S "$1" | grep ":" | head -1) 
if [ $? != 0 ]; 
    then echo "no pkg found!" 
    exit 1
fi 

match_pkg=$(echo $match_line | sed -e 's/:.*//') 
echo "start to get source of $match_pkg ..." 
apt-get source $match_pkg
