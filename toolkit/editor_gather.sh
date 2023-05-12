#! /bin/bash
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2006-2010 Denny
# tools: 
#  regex support: find grep
#  other: sed renmae
# ----------------------------------------------------------------------

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
# use vimgrep:  %vimgrep /setLinger/ ./**/*.cpp

## Eg: find exclude directory: -path [path] -prune
find . -path ./201008 -prune -o -iname "stockInfo???.dat" |xargs rm


###2: replace string in file
# Eg: replace stringA to stringB in dir include subDir
sed -i "s/stringA/stringB/g" `grep -rl "stringA" Directory`


###3: rename filename
# method1: rename 
rename "s/$/\.txt/" *  
rename "s/\.html/\.php/" *  
# method2: mv
# method3: find . -name "*.txt"|xargs -I {} cp {} {}.bak
for filename in `ls`
do
  if [ -f $filename ]
  then
     if [ ${filename%.sh} == $filename ]
     then     
      mv $filename ./my${filename#./}
     fi
  fi
done


###4:  delete spaceline
# method1: sed --stream editor for filtering and transforming text
sed -i '/^$/d' $filename
# method2: vim
# %s/^n//g


###5:  convert file format:  dos(\r\n)-->unix(\n)
cat $1 |tr -d "\r" > $1.new
mv $1.new $1


###6: string stream edit
#method1:  "##", '#', "%%", "%"
${varible##*string}	从左向右截取最后一个string后的字符串
${varible#*string}	从左向右截取第一个string后的字符串
${varible%%string*}	从右向左截取最后一个string后的字符串
${varible%string*}	从右向左截取第一个string后的字符串

#method2: 截取变量varible从n1到n2之间的字符串
${varible:n1:n2}

#method3: cut -d [delimiter] -f [num]
## Eg: Generates a compact listing of all the users on the system.
cut -d: -f1 < /etc/passwd | sort | xargs echo

