#!/bin/bash
#file: 
#author: denny, wuqifu@gmail.com
#date: 2016/5/8

if [ $# -lt "1" ]; then
 echo usage: $0 [dirname]
 dir=.
else
 dir=$1
fi 

# cmake 
find $dir -name "CMakeFiles" -exec rm -rf {} \;
find $dir -name "CMakeCache.txt" -exec rm -rf {} \;
find $dir -name "CPa*.cmake" -exec rm -rf {} \;
find $dir -name "cmake_install.cmake" -exec rm -rf {} \;
find $dir -name "install_manifest.txt" -exec rm -rf {} \;
find $dir -name "Makefile" -exec rm -rf {} \;

# lib
find $dir -name "lib*.*" -exec rm -rf {} \;
#find $dir -name ".svn" -exec rm -rf {} \;

# c/c++
find $dir -name ".o" -exec rm -rf {} \;

# python
find $dir -iname "*.pyc" |xargs rm