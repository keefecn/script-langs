#! /bin/sh
# @brief:  convert file format:  
#   dos format file to unix us: "\r\n"-->"\n"

# method 1: cmd--tr 
cat $1 |tr -d "\r" > $1.new
mv $1.new $1

# method 2: vim---set fileformat=dos/unix

# method 3: cmd--dos2unix,unix2dos
# convert directory
find -iname "*.py" |xargs dos2unix
for f in *.txt 
do
    dos2unix $f
done