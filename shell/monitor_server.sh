# usage: monitor sever status
# start:
#  $./$0 &  then use exit to exit terminal. 
#  $nohup $0 > myout.file 2>&1 &  
# stop: $pkill bash
# author: Denny 2010-5-20 2010-6-22

#! /bin/bash
PROC_NAME=talkMidlayer
START_SCRIPT=./start.sh
LOG=/tmp/maiiltmp
EMAIL_NAME=wuqifu@gmail.com

for(( i=0; ; ++i ))
do
        #pid=$(ps -ef | grep $PROC_NAME |grep -v grep| awk '{print $2}' | head -1) 
        pid=`pgrep $PROC_NAME`
        if [ -z $pid  ]; then
                echo "["$i"]$PROC_NAME ok...." >/tmp/monitor_server.tmp
        else
                echo "$PROC_NAME is down!!! and restart it now......"  >$LOG 2>&1
                $START_SCRIPT >>$LOG 2>&1
                restartTime=`date '+%F %T'` ;
                echo "TIME: $restartTime" >>$LOG 2>&1
                mail -s "$PROC_NAME Alert"  $EMAIL_NAME < $LOG
                #TIME: $restartTime
#mailtmp
        fi  
        sleep 5;
done;
