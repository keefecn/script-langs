#!/bin/bash
#@requirement: 
#  file mv rename


# tools: file
# get file info
file [xx]

# tools: mv, rename
# batch rename filename
#   txt -> cpp
for name in `ls *.txt`; do mv $name ${name%.txt}.cpp; done

