#!/usr/bin/perl 
 use strict; 

 # 打印此脚本使用信息和输出说明。
 ################################################################ 
 # Output the usage of this perl script 
 ################################################################ 
 sub usage()
 { 
    print "memmonitor: Monitor system memory usage\n"; 
    print "1. if used memory is more than 75% of total memory, memmonitor\n"; 
    print "will output one warning message per minites.\n"; 
    print "2. if used memory is more than 90% of total momory, memmonitor\n"; 
    print "will kill the processes that occupied the most memory untill\n"; 
    print "used memory is less than 75% of total memory.\n\n"; 

    return 0; 
 } 

 #usage(); 

 my $total_mem; 
 my $used_mem; 
 my $next_line = 0; 
 my @rc; 
 my $rate; 

 # $total_mem 和 $used_mem 变量分别代表了总计实际内存大小和已经使用的内存大小
 @rc=`vmstat`; 
 printf @rc;
 foreach ( @rc ) { 
    if ( $next_line ) { 
      my @value = split /\s+/, $_; 
         $used_mem = @value[3] * 4; 
         $next_line = 0; 
         last; 
     } elsif ( /^.*mem=(\d+)MB$/ ) { 
         $total_mem = $1 * 1024; 
     } elsif ( /^.*avm.*$/ ) { 
         $next_line = 1; 
     } 
 } 
 # 这段代码使用了 vmstat 命令得到系统内存状态信息，并对结果进行逐行解析，得到各个字段的数据。

 if ( $total_mem ) { 
    $rate = $used_mem / $total_mem; 
 } 

 # 计算得到了当前全局内存使用率
 # 如果内存使用率大于 0.75， 将打印出警告信息。
 if ( $rate > 0.75 ) { 
    print "Warning: Memory is not enough\n"; 
 } 

 # 如果内存使用率大于 0.9，脚本将调用 ps 命令并且找出内存使用率最高的进程，打印出将要杀掉进程的警告信息，
 #杀掉内存使用率最高的进程。 此过程将循环进行知道内存占用率低于 0.9 
 print $rate;
 if ( $rate > 0.9 ) { 
    my $line_count = 0; 
    my @output = `ps aux | head -1;ps aux | sort -rn +5`; 
    foreach ( @output ) { 
        if ( $line_count ) { 
            my @killed_process = split /\s+/,$_; 
            print "Warning: Out of memory. Kill process: @killed_process[1]\n"; 
            # 发送警告信息给 root 用户，保存程序运行记录。
		`echo "Process @killed_process[1] has been killed because of unlimited memory \
			allocation" | mail -s "Out of memory" root` 
         	# have bug here?, denny
		#`kill -1 1 @killed_process[1]`; 
          	#last; 
        } 
        $line_count = $line_count + 1; 
    }
 }  

#
# 此时 MemMonitor.per 将被每两分钟自动执行一次，并将输出结果保存在 /tmp/memmonitor.log 中
# */2 * * * *  /tmp/MemMonitor.perl 2>&1 >> /tmp/memmonitor.log 
# 
