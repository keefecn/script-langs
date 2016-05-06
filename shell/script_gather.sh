#!/bin/bash
# script_gather.sh: some offer used script
#
#tools: grep/find, awk, xargs, sort/uniq/wc
#  lsof/netstat, pgrep/ps, du/df/top
#  vi+ctags
#
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2006 Denny
# ----------------------------------------------------------------------

### 1: replace space line
sed  -i '/^$/d'  filename
cat $1 |grep ^[^$]

### stat code lines 统计行数
# find file backfix: 查找后缀名为h, c, cpp的文件
find . -regex '.*\.\(c\|h\|min\|cpp\|py\|php\)'  | xargs wc -l
# trim space line
find /a -name "*.c" |xargs cat|grep -v ^$|wc -l

###1: find file 
# syntax: ind pathname -options [-print -exec -ok ...]
# syntax: grep [options] PATTERN [FILE...]
# shell flag: {} \;
# regular expression: ^ $ . [ ] | ( ) * + ?
### [0-9], [A-Z]
# options: name, type, size, perm, group, print/exec/ok
## Eg: delete *.log, modify before 5 days, ask first when delete the log.
find . -name "*.log" -mtime +5 -ok rm {} \;

## Eg: list the file which size=0
find / -type f -size 0 -exec ls -l {} \;

## Eg: find match string("setLinger") in directory include subDir
find -iname "*.cpp" |xargs grep "setLinger"
find -iname "*.cpp" -exec grep "setLinger" {} \;
grep -rl "setLinger" .
## Eg: replace str in some file, oldstr-->newstr 
sed -i "s/oldstr/newstr/g" `grep "newstr" -rl dirname`
grep "oldstr" -rl dirname | xargs sed -i "s/oldstr/newstr/g" 
find -name 'filename' | xargs perl -pi -e 's|oldstr|newstr|g'

## Eg: find exclude directory: -path [path] -prune
find . -path ./201008 -prune -o -iname "stockInfo???.dat" |xargs rm

### 3: awk -options 'program txt' [file...]
## Eg: list open file: {num, pid}
lsof -n | awk '{print $2}'|sort |uniq -c |sort -nr

## Eg: printf tcp connect state
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

## Eg: replace ',' into space, and count $9 if $4>100, then print $sum
sed -i 's/,//g' $1
awk 'BEGIN{sum=0}{if($4>100)sum+=$9}END{print "concurrencies = " sum}' $1

### 4: xargs: xargs - build and execute command lines from standard input
## Eg: Generates a compact listing of all the users on the system.
cut -d: -f1 < /etc/passwd | sort | xargs echo

## Eg:  {}=[replacestr, any string]
find . -name "*.txt"|xargs -I {} cp {} {}.bak


######## some usefull tools #############################
#1 kill process by name
ps -ef |grep java |grep -v grep |awk '{print $2}' |xargs kill -9  
 
#2 start 1-n process
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

# http://blog.csdn.net/wqf363/archive/2006/11/12/1380142.aspx
#3 截取完整路径中的文件名, 如下列str中的filename
str='/a/b/c/d/e/f/filename'
echo ${str##*/}
echo ${str/\/*\//}
basename $str

#4 patch
#first: sudo make mrproper
#usage: make patch
version_num=2.6.30
diff -ruNa linux-$version_num-origin/ linux-$version_num >linux-$version_num.patch

#5 test
 for i in `seq 1 100`; do touch $i.txt; done

##########################################
## shell symbol 
#  # coments
#  ~ home directory
#  . current dir	.. parent dir
#  ''  ""   express string
#  + - * % = ==  ! || &&
# ` `  system(command); 
# ;  command separator		;; Terminator
# $# total varibale	$? status variable 
# << input stream separator 
##########################################
