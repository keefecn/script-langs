#! /usr/bin/perl
# Note: TEST is ok
# http://www.ibm.com/developerworks/cn/aix/library/0911_ximj_unixmail/index.html?ca=drs-cn-1126
# 将要使用 sendmail 来发送邮件
my $mailprog="/usr/sbin/sendmail";
# 发送者的邮件地址
my $senderemail = "wuqifu\@gmail.com";
# 发送者的名字
my  $sender = "sender";
# 发送时的时间
my $datestring=`date +%m.%d.%Y`;
# 接收者的 email 地址
my $email = "hanwei\@ihandy.cn";
# Send file to user in email
open (MAIL, "|$mailprog -f $sender -t $senderemail") or die;
# 创建发送邮件的头
print MAIL "From: $sender\n";
print MAIL "To: $email\n";
# 主题
print MAIL "Subject: Automation test on SELS $datestring\n";
#email 的信件内容
print MAIL "Hi All\nthis is the automation test result on $datestring. If U have receive this, give a reply, thanks.
Please check the  attached files.\n";

# 第一个附件
#$file = "/tmp/28279.txt";
#open(FILE, "uuencode $file $file |") or die;
#print MAIL  <FILE>;
#close(FILE);
# 第二个附件
#$file="/tmp/28280.txt";
#open(FILE, "uuencode $file $file |") or die;
#while(<FILE>) { print MAIL;};
#close(FILE);

# 完成邮件发送
close(MAIL);

