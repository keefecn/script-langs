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

#############################　
## shell symbol 
#  # coments
#  ~ home directory
#  . current dir	.. parent dir
#  ''  ""   express string
#  + - * % = ==  ! || &&
# ` `  system(command); 
# ; command separator		;; Terminator
# $# total varibale	$? status variable 
# << input stream separator 
#############################　

#############################　
## regex
##　regular expression: ^ $ . [ ] | ( ) * + ?
##　[0-9], [A-Za-z]  \{n,m}
## use '\' to mark special char
## Unsupport(bash...):  \d
############################
#匹配数字
验证数字：^[0-9]*$
验证n位的数字：^\d{n}$
验证至少n位数字：^\d{n,}$
验证m-n位的数字：^\d{m,n}$
验证零和非零开头的数字：^(0|[1-9][0-9]*)$
验证有两位小数的正实数：^[0-9]+(.[0-9]{2})?$
验证有1-3位小数的正实数：^[0-9]+(.[0-9]{1,3})?$
验证非零的正整数：^\+?[1-9][0-9]*$
验证非零的负整数：^\-[1-9][0-9]*$
验证非负整数（正整数 + 0）  ^\d+$
验证非正整数（负整数 + 0）  ^((-\d+)|(0+))$
整数：^-?\d+$
非负浮点数（正浮点数 + 0）：^\d+(\.\d+)?$
正浮点数   ^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$
非正浮点数（负浮点数 + 0） ^((-\d+(\.\d+)?)|(0+(\.0+)?))$
负浮点数  ^(-(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*)))$
浮点数  ^(-?\d+)(\.\d+)?$

#匹配字符，字符串
验证长度为3的字符：^.{3}$
验证由26个英文字母组成的字符串：^[A-Za-z]+$
验证由26个大写英文字母组成的字符串：^[A-Z]+$
验证由26个小写英文字母组成的字符串：^[a-z]+$
验证由数字和26个英文字母组成的字符串：^[A-Za-z0-9]+$

#匹配实例
验证由数字、26个英文字母或者下划线组成的字符串：^\w+$
验证用户密码:^[a-zA-Z]\w{5,17}$ 正确格式为：以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+
验证汉字：^[\u4e00-\u9fa5],{0,}$
验证Email地址：^\w+[-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$
验证InternetURL：^http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$ ；^[a-zA-z]+://(w+(-w+)*)(.(w+(-w+)*))*(?S*)?$
匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
验证电话号码：^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$：--正确格式为：XXXX-XXXXXXX，XXXX- XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX。
匹配国内电话号码：\d{3}-\d{8}|\d{4}-\d{7}  匹配形式如 0511-4405222 或 021-87888822
验证身份证号（15位或18位数字）：^\d{15}|\d{18}$        或者sed 's/^[0-9]{15}18}
验证一年的12个月：^(0?[1-9]|1[0-2])$ 正确格式为：“01”-“09”和“1”“12”
验证一个月的31天：^((0?[1-9])|((1|2)[0-9])|30|31)$    正确格式为：01、09和1、31。
