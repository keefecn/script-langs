#!/bin/bash 
# have bug? need debug, contract me, denny
# ============================================================== 
# Script Name:  bandmonitor.sh 
# Desciption:   to monitor bandwidth utilization of specified Ethernet 
# interface 
# Date:         JUNE 15, 2009 
# http://www.ibm.com/developerworks/cn/aix/library/0909_jiangpeng_netinterface/
# ============================================================= 
# ------------------------------------------------------------- 
# Function definitions...                           函数定义
# ------------------------------------------------------------- 
function usage { 
   echo ""
   echo "usage: bandmonitor.sh -i interface [ -l LogFile ] \ 
[ -s durationseconds ] [ -c count] [ -u Utilization ]"
   echo ""
   echo "For example: bandmonitor.sh -i eth1 -l /tmp/logFile \ 
-s 30 -c 200000 -u 80 "
   exit 1 
} 

# --------------------------------------------------------------- 
# Process command-line arguments                  处理命令行参数
# --------------------------------------------------------------- 
while getopts :i:l:s:u:c: opt 
do 
       case "$opt" in 
       i) INT="$OPTARG";; 
       l) LogFile="$OPTARG";; 
       s) SEC="$OPTARG";; 
       u) Util="$OPTARG";; 
       c) COUNT="$OPTARG";; 
       \?) usage;; 
       esac 
done 
# --------------------------------------------------------------- 
# Input validation                                   输入校验
# --------------------------------------------------------------- 

if [ -z "$INT" ] 
then 
       echo "error: invalid Augument interface in OPTION -i "
       usage 
       exit 1 
fi 

# --------------------------------------------------------------- 
# Set values, if unset...                              设置默认值
# --------------------------------------------------------------- 

# 设置日志文件名
LogFile=${LogFile:-${INT}.log} 
# 设置查询网络接口流量的时间间隔
SEC=${SEC:-30} 
# 设置网络接口占用率的门限值
Util=${Util:-'80'} 
# 设置查询网络接口流量的次数
COUNT=${COUNT:-172800} 


# bandmonitor.sh 脚本查询网络接口连接模式和连接速度，对于 AIX 与 Linux 将调用不同的命令。
#  bandmonitor.sh 脚本查询网络接口连接模式和连接速度				 
# ---------------------------------------------------------------- 
# Query duplex type and speed              查询连接模式和连接速度
# ---------------------------------------------------------------- 
OS=`uname` 
case "$OS" in 
AIX) 
       # 获取网络接口连接速度和连接模式
       Media=`entstat -d ${INT}|grep 'Media Speed Running'` 
       DuplexType=`echo $Media|awk '{print $6}'` 
       Speed=`echo $Media|awk '{print $4}'` 
       
		 # 获取启动监控时网络接口接收和发送的字节数
       Traffic=`entstat ${INT}|grep Bytes` 
       OLD_TRAN=`echo ${Traffic}|awk '{print $2}'` 
       OLD_RECV=`echo ${Traffic}|awk '{print $4}` 
       ;; 
Linux) 
       # 获取网络接口连接速度和连接模式
		 DuplexType=`ethtool ${INT}|grep Duplex|awk '{print $2}` 
       Speed=`ethtool ${INT}|grep Speed|awk '{print $2}' \ 
|sed 's/Mb\/s//` 

		 # 获取启动监控时网络接口已接收和已发送的字节数
       Traffic=`grep ${INT} /proc/net/dev` 
       OLD_TRAN=`echo ${Traffic}|awk '{print $1}'|cut -d: -f2` 
       OLD_RECV=`echo ${Traffic}|awk '{print $9}` 
       ;; 
*)      echo "not support $OS operating system!"
       exit 1; 
       ;; 

esac 

# 在日志文件中记录监测信息，包括启动时间，监测网络接口，接口工作状态和告警门限
echo "Start to monitor interface ${INT} at `date +%Y%m%d%H%M%S`."  \ 
>> ${LogFile} 
echo "Interface ${INT} is working on Duplex:${DuplexType} \ Speed:${Speed}." \
      >> ${LogFile} 
echo "Utilization threshold is ${Util} percent." >> ${LogFile} 

# ---------------------------------------------------------------- 
 # Send admin an alert if bandwidth utilization reach defined threshold 
 # 如果带宽利用率达到门限值即发出告警邮件
 #---------------------------------------------------------------- 

 echo "Network traffic recording....." >> ${LogFile} 

 Alarm="NO"
 n=1 

 # 计算达到告警门限时所允许通过流量的字节数
 BYTETHRES=`expr ${Speed} \* 1024 \* 1024 \* ${Util} \* ${SEC} / 100` 
 while [ n -le $COUNT ] 
 do 
        case "$OS" in 
        AIX) 
		        # 获取网络接口已接收和已发送的字节数
                Traffic=`entstat ${INT}|grep Bytes` 
                Transmit=`echo ${Traffic}|awk '{print $2}'` 
                Receive=`echo ${Traffic}|awk '{print $4}` 
                ;; 
        Linux) 
                # 获取网络接口已接收和已发送的字节数
                Traffic=`grep ${INT} /proc/net/dev` 
                Transmit=`echo ${Traffic}|awk '{print $1}'|cut -d: -f2` 
                Receive=`echo ${Traffic}|awk '{print $9}` 
                ;; 
        *)      echo "not support $OS operating system!"
                exit 1; 
                ;; 

        esac 

        case "$DuplexType" in 
        Full) 
               # 连接模式全双工时，需要分别计算发送和接收流量是否超出门限
               if [ `expr $Transmit - $OLD_TRAN` -ge $BYTETHRES ] || \ 
                [ `expr $Receive - $OLD_RECV` -ge $BYTETHRES ] ;then 
                        Alarm="YES"
                fi 

                ;; 
        Half) 
                # 连接模式半双工时，需要合计计算发送和接收流量是否超出门限
                if [ `expr $Transmit - $OLD_TRAN + $Receive - $OLD_RECV` \
                       -ge $BYTETHRES ] ;then 
                        Alarm="YES"
                fi 

                ;; 
        *)      echo "not support Duplex type!"
                exit 1; 
                ;; 

        esac 
   
        # 在日志中记录流量信息
        echo "INT:${INT}        TIME:`date +%Y%m%d%H%M%S`        \ 
        TRANS:${Transmit}       RECV:${Receive} ALARM:${Alarm}" \ 
        >> ${LogFile} 
       
        # 如果超出告警门限， 给管理员发送告警门限
        if [ $Alarm = "YES" ];then 
                echo "INT:${INT}      TIME:`date +%Y%m%d%H%M%S`     \ 
                TRANS:${Transmit}  RECV:${Receive} ALARM:${Alarm}" \ 
                >> mail.tmp 
                mail -s "Bandwidth Alert"  root@localhost< mail.tmp 
        fi 

        # 设置下次循环前重值
        OLD_TRAN=$Transmit 
        OLD_RECV=$Receive 
        Alarm="NO"
        sleep $SEC 
        n=`expr $n + 1` 

 done 

 exit 0 

