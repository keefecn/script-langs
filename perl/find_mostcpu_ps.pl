#/usr/bin/perl
# 获得各处理器的利用率和耗用处理器时间最多的进程代码
# http://www.ibm.com/developerworks/cn/aix/library/0909_unixcpu_wangwh/

# 两次读取 /proc/stat 文件的内容
# have bug here? denny
my $file = "/proc/stat"; 
open FILE, "$file |" or die "Failed to open file $file.\n";
my @fir_contents = <FILE>;
close FILE; 

sleep 60; 
open FILE, "<$file" or die "Failed to open file $file.\n"; 
my @sec_contents = <FILE>; 
close FILE; 

# 把 /proc/stat 文件的内容存入一个散列
my (%cpuinfo); 
my $cpu_num = 0; 
my $line_num = 0; 
foreach my $line (@fir_contents, @sec_contents){ 
   $line_num ++; 
   if ($line =~ m/^cpu/)    { 
       # 判断当前数据来自第一次读取还是第二次读取
       my $info_time; 
       if ($line_num <= scalar(@fir_contents))        { 
           $info_time = "first"; 
       }else        { 
           $info_time = "second"; 
       } 

       # 向散列写入数据
       chomp $line; 
       my ($cpu, $user, $nice, $sys, $idle, $io, $irq, $softirq, $steal, $guest) = 
           split /\s+/, $line; 
       $cpuinfo{$info_time}{$cpu}{'user'} = $user; 
       $cpuinfo{$info_time}{$cpu}{'nice'} = $nice; 
       $cpuinfo{$info_time}{$cpu}{'sys'} = $sys; 
       $cpuinfo{$info_time}{$cpu}{'idle'} = $idle; 
       $cpuinfo{$info_time}{$cpu}{'io'} = $io;  
       $cpuinfo{$info_time}{$cpu}{'irq'} = $irq; 
       $cpuinfo{$info_time}{$cpu}{'softirq'} = $softirq; 
       $cpuinfo{$info_time}{$cpu}{'$steal'} = $steal; 
       $cpuinfo{$info_time}{$cpu}{'guest'} = $guest; 

       $cpu_num ++; 
   } 
} 

# 读取散列中的数据以计算 CPU 利用率
my (%cpu_data, %cpu_usage); 
foreach my $info_time (keys %cpuinfo) 
{ 
   foreach my $cpu (keys %{$cpuinfo{$info_time}})    { 
       $cpu_data{$cpu}{$info_time}{'total'} = 0; 
       $cpu_data{$cpu}{$info_time}{'idle'} = $cpuinfo{$info_time}{$cpu}{'idle'}; 
       foreach my $key (keys %{$cpuinfo{$info_time}{$cpu}})        { 
           $cpu_data{$cpu}{$info_time}{'total'} += $cpuinfo{$info_time}{$cpu}{$key}; 
       } 
   } 
} 
my $check_proc; 
foreach my $cpu (keys %cpu_data){ 
   my $idle_interval =  $cpu_data{$cpu}{'second'}{'idle'} -  
      $cpu_data{$cpu}{'fisrt'}{'idle'}; 
   my $total_interval = $cpu_data{$cpu}{'second'}{'total'} - 
      $cpu_data{$cpu}{'fisrt'}{'total'}; 
   $cpu_usage{$cpu} = (1 - $idle_interval/$total_interval); 
   if ($cpu_usage{$cpu} > 0.5) {$check_proc = 1;} 
} 

# 从 /proc/loadavg 读取处理器上的进程负载
$file = '/proc/loadavg'; 
open FILE, "<$file" or die "Failed to open file $file.\n"; 
my @contents = <FILE>; 
close FILE; 
my ($load1, $load5, $load15, $proc_num, $pid); 
foreach my $line (@contents) {($load1, $load5, $load15, $proc_num, $pid) = \n
   split /\s+/, $line;} 
if ($load1 > 5) {$check_proc = 1;} 

# 如果处理器空闲，退出
if (!$check_proc){ 
   print "CPU load on this machine is normal.\n"; 
   exit 0; 
} 

# 如果处理器繁忙，找出占用 CPU 时间的进程
my @output = `ps -e -o pcpu,pid,user,sgi_p,cmd |grep -v PID| sort -k 1| tail -10`; 
foreach my $line (@output){ 
   $line =~ s/^\s+//g; 
   my ($cpu, $pid, $user, $proc, $cmd) = split /\s+/, $line; 
if ($cpu < 5) {next;} 
# 输出进程号和进程占用的 CPU 百分比
   print "Process $pid of user $user takes $cpu% CPU time on processor $proc.\n"; 
} 
exit 0; 

