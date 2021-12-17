#!/bin/bash
# desc: 根据传入名称杀进程，禁止外面传入为空串并且要作传参检验，否则很容易误杀

DEFAULT_NAME=fuck

if [ $# -lt "1" ]; then
    echo usage: $0 [NAME]
    exit 1;
fi
NAME=$1
echo $NAME
if [[ $NAME != *env* ]]; then
    echo "incorrect name"
    exit 1;
fi

# | xargs -I {} kill -9 {}
ID=`ps -ef | grep "$NAME" | grep -v "grep" | awk '{print $2}'`
echo $ID
echo "---------------kill start"
for id in $ID
do
    kill -9 $id
    echo "killed $id"
done
echo "---------------kill end"

