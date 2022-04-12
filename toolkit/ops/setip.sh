#/bin/bash
#@file: setip.sh 
#@examples: ./setip.sh eth0 192.168.0.111
#@refer: https://blog.csdn.net/chengwo1874/article/details/100703710
# manual set: IPADDR, NETMASK, GATEWAY, DNS1, ONBOOT, BOOTPROTO
# netmask 192.168.0.0/28 -> 255.255.255.240
# $ sudo ifconfig eth0 192.168.0.14 netmask 255.255.255.240

devices=`ls /etc/sysconfig/network-scripts/ifcfg-* |grep -v 'ifcfg-lo'`
device=`basename $devices`
echo "device=$device"
device="$1"
echo "device=$device"
hwaddr=""
bootproto="static"
broadcast=""
ipaddr="$2"
netmask="255.255.255.0"
gateway=""
network=""
onboot="yes"
nm_controlled="yes"
 
if [ "$device" = "" ] || [ "$ipaddr" = "" ]; then
    echo "Usage: $0 \"ethx\" ipaddress"
    exit 1
fi
 
set_static_ip()
{
    file="/etc/sysconfig/network-scripts/ifcfg-$device"
    if [ ! -f "$file" ]; then
        touch "$file"
    fi
    cp "$file" "$file"".bak"
    echo "$old_gateway"
    #value="${old_gateway#*=}"
    #echo "value:$value"
     
    device=$(ifconfig "$device" | grep 'HWaddr' | awk '{print $1}')
    hwaddr=$(ifconfig "$device" | grep 'HWaddr' | awk '{print $5}')
    broadcast=${ipaddr%.*}".255"
    gateway=${ipaddr%.*}".1"
    network=${ipaddr%.*}".0"
     
    comment=$(grep '#' "$file")
    if [ "$comment" = "" ]; then
        comment="# Here is the ip configuration file"
    fi

cat << !here! > "$file"
$comment
DEVICE=$device
HWADDR=$hwaddr
BOOTPROTO=$bootproto
IPADDR=$ipaddr
NETMASK=$netmask
NETWORK=$network
BROADCAST=$broadcast
GATEWAY=$gateway
NM_CONTROLLED=$nm_controlled
ONBOOT=$onboot
!here!
}

set_resolv()
{
    # resolv.conf文件更改nameserver，一般不需要修改
    nameserverfile="/etc/resolv.conf"
    if [ ! -f "$nameserverfile" ]; then
        touch "$nameserverfile"
    fi
    chattr -i /etc/resolv.conf
     
    #cat << !EOF! > /etc/resolv.conf
    #nameserver 202.101.224.69
    #nameserver 202.101.226.68
    #!EOF!
    chattr +i /etc/resolv.conf
}

set_static_ip
#set_resolv

ifdown $device
ifup "$device"


