#@brief get system infomation
#@author Denny
#@date 2011-2-16
#! /bin/bash
# imp:  strace [cmd]  //Eg: strace uptime

# cpu.sh
# tools: sar-System Activity Reporter, mpstat	
# imp: /proc/stat    = 100   *（user   +   nice   +   system）/（user   +   nice   +   system   +   idle）    
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
# imp: /proc/loadavg
uptime |awk -Faverage '{print $2}'|awk '{print $2}'|awk -F, '{print $1}'

# mem.sh
# tools: free, vmstat
# imp: /proc/meminfo   = 100   *   (cmem   /   umem)  
#	/proc/vmstat
/usr/bin/free |grep Mem|awk '{print $4/$2*100}'
/usr/bin/free |grep Swap|awk '{print $4/$2*100}'
# application momory utilization ratio
/usr/bin/free |grep Mem|awk '{print ($3-$7_$8)/$2*100}'


# netconn.sh
# tools: netstat
tem=`netstat -tun|wc -l`
echo $tem

# tcpstate.sh
# tools: netstat
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'

# ulimit.sh
# tools: ulimit, lsof
# imp:  /etc/security/limits.conf   /proc/sys/fs/file-max
ulimit -a
