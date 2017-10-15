#! /bin/bash
# ----------------------------------------------------------------------
# file: convert_fileformat.sh
# author: keefe, wuqifu@gmail.com
# date: 2016/5/8, 2017/10/15
# note: convert file format~ dos format file to unix us: "\r\n"-->"\n"
# tools: dos2unix unix2dos tr vim sed
#  method 1: dos2unitx
#  method 2: tr -d '\r'
#  method 3: vim~  set fileformat=dos/unix
# ----------------------------------------------------------------------

# method 1: cmd--dos2unix,unix2dos
#  convert directory or multiple files
#find -iname "*.py" |xargs dos2unix
echo "fileformat convert: dos2unix"
for i in `find $dir`
do
    if [ ! -d $i ]
    then
        echo "processing file..." $i
        dos2unix $i $i
    fi
done
exit

# method 2: cmd--tr
cat $1 |tr -d "\r" > $1.new
mv $1.new $1

# method 2: vim---
#set fileformat=dos/unix
#:%s/^m//g
