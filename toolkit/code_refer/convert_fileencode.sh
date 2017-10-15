#!/bin/sh
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2007 Denny
# File: convert_file_encode.sh:  convert file encode
# Date: 2007/11/14
# last updated: 2017/10/15
# ----------------------------------------------------------------------

if [ "$1" =  "" ]; then
	echo "Usage: $0 convertDir"
	exit 1;
fi

# convert code tools
CODE="$(which iconv)"
for i in `find ./$1 -type f`;
  do $CODE $i -f gb2312 -t utf-8 -o ${i}.tmp && mv ${i}.tmp $i;
done
