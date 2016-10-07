#! /bin/bash
#@file: codeformat.sh

dir=$1

# remove line end space, 去除行尾空格
find $dir -iname "*.py"  |xargs sed -i 's/\s\+$//g' 

# change sh fileformat: dos2unix
find $dir -iname "*.sh" | grep -v $0 |xargs dos2unix

# stat codeline
find $dir -name "*.py" |xargs cat |grep -v ^$ |wc -l
