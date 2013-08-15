#! /usr/bin/perl
use Mail::Mailer; 

sub get_cpu_stat { 
 my @stats; 
 my $fh; 
 #Linux 系统，从 /proc/stat 来获取 CPU 信息
open($fh, "cat /proc/stat |") or die "$!"; 
while (<$fh>) { 
	 #get the cpu stat 
	 if (/^cpu .*/) { 
		 @stats = split; 
	 } 
 } 
 close $fh; 
 #then, we parse the cpu stat information; 

 #the information from "man proc", 
 #the format is for Linux 2.6.11 or higher 
 #cpu  user   nice  system idle     iowait irq  softirq steal 
 #cpu  628808 1642  61861  24978051 22640  349  3086    0     0 
# 数据格式如上所示，更详细的信息请参考 proc 的 manpage 
 my $total = $stats[1] + $stats[2] + $stats[3] + $stats[4]; 
 my $idle = $stats[4]; 
 # 返回当前 CPU 的 total 和 idle 时间片计数
 return ($total, $idle); 
} 

my $mailer = Mail::Mailer->new('sendmail'); 
my ($t1, $i1) = get_cpu_stat(); 
sleep 5; 
my ($t2, $i2) = get_cpu_stat(); 

my $total = $t2 - $t1; 
my $idle = $i2 - $i1; 
# 计算获取 5 秒钟之内的 CPU 利用率
my $per = 100 * ($total - $idle) / $total; 

if( $per > 5) { 
 # 如果 CPU 利用率大于 85% 
 my $datestring=`date +%m.%d.%Y`;
 my $msg = sprintf("!!!Attention\nThe CPU usage on your server is %.2f"
 . "% right now!\nPlease  check it right now!\n\nDenny $datestring", $per); 
print $msg,"\n";

 #send mail to the assigned user 
 # 发送邮件给指定的用户
 $mailer->open( 
	 { 
		 From => 'denny@localhost', 
		 To => 'wuqifu@gmail.com', 
		 Subject => 'Attention for your cluster', 
	 }) 
	 or die "Mail::Mailer failed!\n"; 
 print $mailer $msg; 

 $mailer->close(); 
} 

