#!/bin/bash
# ----------------------------------------------------------------------
# file: clean.sh
# author: keefe, wuqifu@gmail.com
# date: 2016/5/8, 2017/10/15
# ----------------------------------------------------------------------

if [ $# -lt "1" ]; then
 echo usage: $0 [dirname]
 dir=.
else
 dir=$1
fi

name='-name "*~" or -name "*.tmp"'

do_rm()
{       # shell call paras only from commandline
        # logic expr: -o/-a  eg., -name "" -o -name ""
        find $dir -name "*~" -o -name "*.tmp" |xargs rm
        #find $dir $name -exec rm -rf {} \;
}
do_rm
#exit 0

# general
find $dir -name "*~" -exec rm -rf {} \;

# cmake
find $dir -name "CMakeFiles" -exec rm -rf {} \;
find $dir -name "CMakeCache.txt" -exec rm -rf {} \;
find $dir -name "CPa*.cmake" -exec rm -rf {} \;
find $dir -name "cmake_install.cmake" -exec rm -rf {} \;
find $dir -name "install_manifest.txt" -exec rm -rf {} \;
#find $dir -name "Makefile" -exec rm -rf {} \;

# lib
#find $dir -name "lib*.*" -exec rm -rf {} \;
#find $dir -name ".svn" -exec rm -rf {} \;

# c/c++
find $dir -name ".o" -exec rm -rf {} \;

# python
find $dir -iname "*.pyc" |xargs rm
