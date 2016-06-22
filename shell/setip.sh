#! /bin/bash

# get dhcp: ip, mask, getway, dns
#ip route show 1)staic 2)dhcp
#denny@denny-ubuntu:~$ ip route show
#default via 192.168.0.1 dev wlan0  proto static 
#192.168.0.0/28 dev wlan0  proto kernel  scope link  src 192.168.0.10  metric 9
iface=`ip route show | awk '/^default/{print $5}'`
getway=`ip route show | awk '/^default/{print $3}'`
echo $getway
echo $iface

# manual set: static ip, mask, getway, dns
# netmask 192.168.0.0/28 -> 255.255.255.240
#sudo ifconfig eth0 192.168.0.14 netmask 255.255.255.240


# restart web service


