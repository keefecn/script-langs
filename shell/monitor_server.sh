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
        pid=`pgrep $PROC_NAME`
        if [ "$pid"  ]; then
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


# method 2
# brief: crontab -l
# min hour  day month week   command
*/2 * * * * /home/jb-qfwu/backup/monitor.sh 1>/dev/null 2>&1

#!/bin/bash
# monitor.sh
PROC_NAME="searchd"
pidnum=$(ps -ef |grep -v "grep" | grep $PROC_NAME |wc -l) 
echo "pidnum=$pidnum"

ddate=`date +%Y-%m`
dir=/home/jb-qfwu/git/bin/debug
LOG=$dir/searchd_$ddate.log

restartTime=`date '+%F %T'`;
if (( $pidnum > 0 )) 
then
        echo "$restartTime $PROC_NAME is ok."  >>$LOG 1>/dev/null 2>&1
        echo "$restartTime $PROC_NAME is ok.";
else
        echo "$restartTime $PROC_NAME is down!!! and restart it now......"  >>$LOG 2>&1
        echo "$restartTime $PROC_NAME is down!!! and restart it now......" 
        cd $dir 
        ./start.sh & 1>/dev/null 2>&1
fi

#pid=`ps -ef | grep $PROC_NAME |grep -v "grep"`
#pid=`pgrep $PROC_NAME`
#ret=$?
#ddate=`date +%Y-%m-%d`

#if [ "$pidnum" -lt "2" ]; 
#if [[ "$ret" -eq "0" ]]; 
#if [ -n "$pid" ]; 