#! /bin/bash
# pingall

#grep /etc/hosts and ping each host
cat /etc/hosts |grep -v '^#' | while read LINE
do
  ADDR=`awk '{print $1}'`
  for MACHINE in $ADDR
  do 
	ping -s -c1 $MACHINE
  done
done
