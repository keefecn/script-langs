#!/bin/bash
# @desc: 根据传入端口杀进程，只能杀死一个监听进程。根据实际使用。

DEFAULT_PORT=9999
PORT=$1

if [ -z $PORT ]; then
    echo usage: $0 [port]
    PORT=$DEFAULT_PORT
    exit 0
fi

PID=$(netstat -nlp | grep ":$PORT" | awk '{print $7}' | awk -F '[ / ]' '{print $1}')
if [ $? == 0 ]; then
    echo "process id is: ${PID}"
else
    echo "process ${PORT} no exit"
    exit 0
fi

kill -9 ${PID}
if [ $? == 0 ]; then
    echo "kill $PORT success"
else
    echo "kill $PORT fail"
fi