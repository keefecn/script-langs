# statics codeline, include *.cpp, *.h, no include spaceline
# ccs-idx-2: 14421, 3347

# /bin/bash
DIRNAME=$1
find $DIRNAME -iname "*.cpp" |xargs cat |grep -v ^$|wc -l

# find file backfix: 查找后缀名为h, c, cpp的文件
find $DIRNAME -regex '.*\.\(c\|h\|min\|cpp\|py\|php\)'  | xargs wc -l
# trim space line
find $DIRNAME /a -name "*.c" |xargs cat|grep -v ^$|wc -l
