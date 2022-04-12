#!/bin/bash
# get out ip 
curl checkip.amazonaws.com

# get inner ip
echo -e "\nip route show..."
ip route show

# get dhcp: ip, mask, getway, dns
#ip route show 1)staic 2)dhcp
#$ip route show
#default via 192.168.0.1 dev wlan0  proto static 
#default via 172.17.207.253 dev eth0 
#172.17.192.0/20 dev eth0 proto kernel scope link src 172.17.194.40 
# get result: 
gateway=`ip route show | awk '/^default/{print $3}'`
device=`ip route show | awk '/^default/{print $5}'`
ip=`ip route show | awk '/^$device/{print $9}'`
echo -e "geteway=$gateway, device=$device, ip=$ip"

default=`ip route show |grep 'default'`
echo -e ""

# get network-device
basename `ls /etc/sysconfig/network-scripts/ifcfg-* |grep -v 'ifcfg-lo'`

