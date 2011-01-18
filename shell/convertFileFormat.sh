#! /bin/sh
# to convert dos format file to unix: "\r\n"-->"\n"
cat $1 |tr -d "\r" > $1.new
mv $1.new $1
