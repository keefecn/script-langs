#! /usr/bin/perl
# 清单 11. 带有附件的邮件自动化发送邮件脚本
# http://www.ibm.com/developerworks/cn/aix/library/0911_ximj_unixmail/index.html?ca=drs-cn-1126

# 接受者的邮件系统
my $email = "receiver\@cn.ibm.com";
# 将作为附件发送出去的两个文件
my $file1="/tmp/1.txt";
my $file2="/tmp/2.txt";
# 将要使用的邮件发送程序
my $mailprog = "/usr/sbin/sendmail";
# 记录发送时间
my $datestring=`date +%m\/%d\/%Y`;
chomp ($datestring);
#email 的主题
my $subject= "\"Subject: Test on AIX $datestring with attachment\"";
# 产生发送邮件命令
my $cmd_sendmail = "uuencode  $file1 \"1.txt\" $file2  \"2.txt\" |";
$cmd_sendmail .=  "$mailprog -s $subject $email ";
# 执行发送命令
system($cmd_sendmail);

