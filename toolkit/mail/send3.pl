#!/usr/bin/perl
# without attachment
# 接受者的邮件系统
my $email = "wuqifu\@ihandy.cn";
# 将要使用的邮件发送程序
my $mailprog = "/usr/sbin/sendmail"; 

# 记录发送时间
my $datestring=`date +%m\/%d\/%Y`;
chomp ($datestring);
#email 的主题
my $subject= "\"Subject: Test on AIX $datestring \"";
# 产生发送邮件命令
my  $cmd_sendmail = "echo $message |";
$cmd_sendmail .=  "$mailprog -s $subject $email";
# 执行发送命令
`$cmd_sendmail`;

