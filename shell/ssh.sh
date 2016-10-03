#! /bin/bash
#open-ssh: ssh-keygen -t rsa
#cat .ssh/id_rsa.pub | ssh qfwu@61.145.124.32 -p 37856 "cat - >>.ssh/authorized_keys"
if [ $# -lt "1" ]; then
  echo usage: $0 [hostname_code_freq]
  exit 1;
else 
{
  if [ $1 = "3" ]; then
    # newspider
    host=61.145.124.165;
    user=bj-qfwu
  elif [ $1 = "5" ]; then
    # novel front 
    host=61.145.124.32;
    user=qfwu
  elif [ $1 = "10" ]; then
    # yyus test
    host=61.145.124.165;
    user=qfwu
  else
    # hanwei host
    host=119.161.158.21;
    user=wuqifu
  fi
}    
fi

port=37856
ssh -p $port $host -l $user

