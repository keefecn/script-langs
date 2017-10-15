#! /bin/bash
# ----------------------------------------------------------------------
# file: stat_codeline.sh
# author: keefe, wuqifu@gmail.com
# date: 2016/5/8, 2017/10/15
# note: statics codeline, include *.cpp, *.h, no include spaceline
# tools: wc -l
# Eg.
#  $./stat_codeline.sh ccs-idx-2
#  14421, 3347
# ----------------------------------------------------------------------

DIRNAME=$1
# stat file nums
find $DIRNAME -iname "*.cpp" |xargs cat |grep -v ^$|wc -l

# find file backfix: 查找后缀名为h, c, cpp的文件
find $DIRNAME -regex '.*\.\(c\|h\|min\|cpp\|py\|php\)'  | xargs wc -l

# trim space line
find $DIRNAME /a -name "*.c" |xargs cat|grep -v ^$|wc -l
