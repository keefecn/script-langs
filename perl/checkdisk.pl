#! /usr/bin/perl
# 将分析出的 hash table 以引用的形式传递给 checkDisk 函数，checkDisk 函数完成检查分区空间，并执行相应动作的任务。
 checkDisk(\%table); 
 sub checkDisk 
 { 
    my ($tab) = @_; 
    my @df_rs = `$DF`; # 执行 df 命令
    chomp @df_rs; 
    my ($mp, $used_size, $used_perc); 
    my ($minsize, $minperc); 
    my $comp_with_perc; # 此变量用于表明是使用百分比进行比较还是使用绝对空间大小值
    my %rs; 
    my $env_str; 
    # 分析 df 命令的每一行输出
    foreach my $line (@df_rs) { 
        $comp_with_perc = 0; 
        # 使用正则表达式，分析出 df 输出的每一行的挂载点、空间使用大小和空间使用百分比
        if ($line =~ /^\S+\s+\S+\s+(\S+)\s+\S+\s+(\d+)%\s+(\S+)\s*$/) { 
            $mp = $3; $used_size = $1; $used_perc = $2; 
        } else { 
            next; 
        } 
        # 如果某个分区的 Mount Point 在 table 中有一项和它对应，则继续进行，否则分析下一行
        if (!defined($$tab{$mp})) { 
            next; 
        } 

        # 将得到的信息，存储起来，作为环境变量传递给将要运行的响应脚本
        $env_str = "DISK_MOUNTP=$mp"; 
        $env_str .= " DISK_MIN=$$tab{$mp}[0]"; 
        $env_str .= $used_size =~ /^\d+\.?\d*$/ ? " DISK_USED=${used_size}M" : "
            DISK_USED=$used_size"; 
        $env_str .= " DISK_USED_PERC=$used_perc%"; 
        # 分析 hash table 中的阈值，如果阈值使用的是大小值，则现将其统一单位为 MB 
        if ($$tab{$mp}[0] =~ /^(\d+\.?\d*)G$/) { 
            $minsize = $1 * 1024; 
        }elsif ($$tab{$mp}[0] =~ /^(\d+\.?\d*)M$/) { 
            $minsize = $1; 
        }elsif ($$tab{$mp}[0] =~ /^(\d+\.?\d*)K$/) { 
            $minsize = $1 / 1024; 
        }elsif ($$tab{$mp}[0] =~ /^(\d+\.?\d*)%$/) { 
            $minperc = $1; 
            # 如果 hash table 中阈值存放的是一个百分比，则表明要进行占用百分比的比较
            $comp_with_perc = 1; 
        }else { 
            print "Format error: $$tab{$mp}[0]\n"; 
            next; 
        } 

        # 如果使用空间占用 size 进行比较，则也将 df 命令中得到的空间大小统一单位到 MB 
        if (!$comp_with_perc) { 
            if ($used_size =~ /^(\d+\.?\d*)G$/) { 
                $used_size = $1 * 1024; 
            }elsif ($used_size =~ /^(\d+\.?\d*)M$/ || $used_size =~ /^(\d+\.?\d*)$/) { 
                $used_size = $1; 
            }elsif ($used_size =~ /^(\d+\.?\d*)K$/) { 
                $used_size = $1 / 1024; 
            } 
        } 

        # 比较实际空间占用和 table 中记录的阈值
        if ((!$comp_with_perc && $minsize < $used_size) || 
            ($comp_with_perc && $minperc < $used_perc)) { 
            print "WARNING DISK SIZE for $mp\n"; 
            # 调用 table 中记录的响应脚本，$env_str 中存放的 DISK_MOUNTP，DISK_MIN，DISK_USED，
            # DISK_USED_PERC，作为环境变量传递给脚本
            my $cmd = "$env_str $$tab{$mp}[1] 2>&1"; 
            print "Running command: $cmd\n"; 
            my $output = `$cmd`; chomp $output; 
            print "Output:\n$output\nExit code = $?\n"; 
        } 
    } 
 } 

