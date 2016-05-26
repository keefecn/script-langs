#!/bin/bash

file=$1
filename=`basename $file`
PYREVERSE="$(which pyreverse)"
PY_FLAG="-A -S --ignore=test"
#PY_FLAG="-k --ignore=test"
DOT="$(which dot)"

# -A包括父类，-S包括关联，-p生成的文件名，最后生成classes_$file.dot
# fienaem.ext: ${file%.*} ${file##*.}
$PYREVERSE $PY_FLAG -p ${filename%.*} $file

# read dot by 'xdot'(ubuntu), 'dotty'(windows)
DOTFILE="classes_${filename%.*}"
#$DOT -Tpng $DOTFILE.dot > $DOTFILE.png
dot -Tjpg $DOTFILE.dot > $DOTFILE.jpg
