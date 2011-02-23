#@brief get system infomation
#@author Denny
#@date 2011-2-16
#! /bin/bash

# cpu.sh
# tools: sar, mpstat
idle=`/usr/bin/mpstat 1 1 | /bin/grep Average | awk '{print $9}'`
used=`echo "100 - $idle" | /usr/bin/bc -l -s` 
echo $used 
echo $idle

# disk.sh
# tools: df
df -h |grep data|awk '{print $5}'|awk -F% '{print $1}'

# io.sh
# tools: iostat
iostat -x /dev/sda|grep sda |awk '{print $8}'
iostat -x /dev/sda|grep sda |awk '{print $9}'

# load.sh
# tools: uptime
uptime |awk -Faverage '{print $2}'|awk '{print $2}'|awk -F, '{print $1}'

# mem.sh
# tools: free
/usr/bin/free |grep Mem|awk '{print $4/$2*100}'
/usr/bin/free |grep Swap|awk '{print $4/$2*100}'

# netconn.sh
# tools: netstat
tem=`netstat -tun|wc -l`
echo $tem

# tcpstate.sh
# tools: netstat
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
