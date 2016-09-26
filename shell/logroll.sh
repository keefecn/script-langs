#! /bin/bash
# logroll
# roll over the log files if size have reached the MAX

# limit size of log
BACK_LIMIT=4

MYDATE=`date +%d%m`
#list of logs to check...
LOGS="/home/wuqifu/log/siege.log /home/wuqifu/log/0.log"
for LOG_FILE in $LOGS
do 
  if [ -f $LOG_FILE ] ; then
	# get block size
	F_SIZE=`du -a $LOG_FILE |cut -f1`
  else
	echo "`basename $0` cannot find $LOG_FILE" >&2
	# could exit here, but I want to make check all logs
	continue;

  fi

  #if [ "$F_SIZE" -gt "$BLOCK_LIMIT" ]; then
   # copy the log across and append a ddmm date on it
   cp $LOG_FILE $LOG_FILE$MYDATE
   # create /zero the new log
   >$LOG_FILE
  #fi
done

