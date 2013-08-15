# statics codeline, include *.cpp, *.h, no include spaceline
# ccs-idx-2: 14421, 3347
# /bin/bash
DIRNAME=$1
find $DIRNAME -iname "*.cpp" |xargs cat |grep -v ^$|wc -l
find $DIRNAME -iname "*.h" |xargs cat |grep -v ^$|wc -l
