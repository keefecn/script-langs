#!/usr/bin/perl -w
# webget
# usage: webget http://www.baidu.com /index.html
# http://perldoc.perl.org/perlipc.html#Internet-TCP-Clients-and-Servers
#
use strict;
use IO::Socket;
my($host, $port, $remote);


unless (@ARGV == 2) { die "usage: $0 host port" }
($host, $port)=@ARGV;


# create a tcp connection to the special host and port
$remote = IO::Socket::INET->new( 
	Proto => "tcp",
	PeerAddr => $host,
	PeerPort => $port
)
or die "cannot connect to http daemon on $host";

print $remote "GET document HTTP/1.0";
$remote->autoflush(1);

print $remote "GET document HTTP/1.0";
while ( <$remote> ) { print }
close $remote;

