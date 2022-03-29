#!/usr/bin/perl
# test.pl
#Author homepage: http://spot.126.com
use strict;
use Socket;

my $pop3server = "pop3.netease.com";
my $port = 110;

$|=1;
print "Content-type: text/html";
print "POP3";
print "";

my ($a,$name,$aliases,$proto,$type,$len,$thataddr,$thisaddr,$i);
my $AF_INET = 2;
my $SOCK_STREAM = 1;
my $sockaddr = "S n a4 x8";

($name,$aliases,$proto) = getprotobyname("tcp");
($name,$aliases,$port) = getservbyname($port,"tcp")
                         unless $port =~ /^d+$/;;
($name,$aliases,$type,$len,$thataddr) = gethostbyname($pop3server);

my $this = pack($sockaddr, $AF_INET, 12345, $thisaddr);
my $that = pack($sockaddr, $AF_INET, $port, $thataddr);

my $mysocket = socket(S, $AF_INET, $SOCK_STREAM, $proto);
if ($mysocket)
{
}
else
{
    print "不能打开socket: $!";
    exit(0);
}

my $mybind = bind(S, $this);
if ($mybind)
{
}
else
{
    print "无法绑定！: $!";
    exit(0);
}

my $myconnect = connect(S,$that);
if ($myconnect)
{
}
else
{
    print "连接错误: $!";
    exit(0);
}
print "connect ok.\n";

my $BUF = "";
my $SenderIP = recv(S, $BUF, 596,0);
if ($SenderIP)
{
}
else
{
    print "接收错误: $!";
    exit(0);
}

if (substr($BUF,0,3) eq "+OK")
{
}
else
{
    print "POP3服务器出错!

    ";
    exit(0);
}

my $BUFFER = "USER wqf363";
$BUFFER .= chr(13);
$BUFFER .= chr(10);

my $SENVAL = send(S, $BUFFER,0);
if ($SENVAL)
{
}
else
{
    print "发送错误: $!";
    exit(0);
}

my $BUF = "";
my $SenderIP = recv(S, $BUF, 4096,0);
if ($SenderIP)
{
}
else
{
    print "接收错误: $!";
    exit(0);
}

if (substr($BUF,0,3) eq "+OK")
{
}
else
{
    print "无此帐号!

    ";
    exit(0);
}

$BUFFER = "PASS wqf49wd";
$BUFFER .= chr(13);
$BUFFER .= chr(10);


my $SENVAL = send(S, $BUFFER,0);
if ($SENVAL)
{
}
else
{
    print "发送错误: $!";
    exit(0);
}

$BUF = "";
my $SenderIP = recv(S, $BUF, 196, 0);
if ($SenderIP)
{
}
else
{
    print "接收错误: $!";
    exit(0);
}

if (substr($BUF,0,3) eq "+OK")
{
}
else
{
    print "密码错误!";
    exit(0);
}

print "密码是正确的! "
