#! /bin/bash
#open-ssh: ssh-keygen -t rsa
if [ $# -lt "1" ]
then
host=192.168.1.170
#  echo usage: $0 [hostname] [port]
#  exit 1;
else
host=$1
fi
user=wuqifu
port=10088
ssh -p $port $host -l $user
