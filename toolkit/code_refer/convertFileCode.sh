#!/bin/sh
# convertFileCode.sh:  convert file code 
#
# last updated: Dec 14,2007
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2007 Denny
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
