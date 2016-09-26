#!/bin/sh
# process.sh:  about process
#
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2006 Denny
# ----------------------------------------------------------------------

#1 如何批量杀掉进程
ps -ef |grep java |grep -v grep |awk '{print $2}' |xargs kill -9 


#2 批量启动进程
if [ $# -lt "4" ]
then
  echo usage: process port username_start username_stop
  exit 1;
fi 
name=$1
i=$3
j=$4
port=$2
while(( i < j ))
do
  $name $port user$i arg1 arg2 &
  ((i++))
  ((port++))
done
