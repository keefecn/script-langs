#!/bin/bash
#@requirement: 
#  file mv rename


# tools: file
# get file info
file [xx]

# tools: mv, rename
# batch rename filename
# Eg1:  txt -> cpp
for name in `ls *.txt`; do mv $name ${name%.txt}.cpp; done

# SYNOPSIS: rename implement by c
#    rename [options] expression replacement file...
# Eg2:  gif.png -> .png
rename .gif.png .png  *.gif.png

# SYNOPSIS: rename implement by perl
#    rename [ -h|-m|-V ] [ -v ] [ -0 ] [ -n ] [ -f ] [ -d ][ -e|-E perlexpr]*|perlexpr [ files ]
# Eg3:  gif.png -> .png
rename 's/\.gif.png/\.png/'  *.png

# batch rename in directory: 
# Eg:  .jpG -> .jpg
find . -name "*.jpG" | xargs rename 's/\.jpG/\.jpg/'  

