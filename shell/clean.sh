#!/bin/bash
dir=$1
find $dir -name "CMakeFiles" -exec rm -rf {} \;
find $dir -name "CMakeCache.txt" -exec rm -rf {} \;
find $dir -name "CPa*.cmake" -exec rm -rf {} \;
find $dir -name "cmake_install.cmake" -exec rm -rf {} \;
find $dir -name "install_manifest.txt" -exec rm -rf {} \;
find $dir -name "Makefile" -exec rm -rf {} \;
find $dir -name "lib*.*" -exec rm -rf {} \;
#find $dir -name ".svn" -exec rm -rf {} \;
find $dir -name ".o" -exec rm -rf {} \;
