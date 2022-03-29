#!/usr/bin/perl -w
########################################################
# Create: P.Linux
# Function: Run MutilThread Random SQL Test
# Usage: Run on any computer with Perl
# License: GPL v2
# Site: PengLiXun.COM
# Modify: 
# P.Linux 2010-03-10 
#    -Create 1.0 Beta
# P.Linux 2010-07-14 
#    -Create 1.0 Release
########################################################
use threads;
use threads::shared;
use DBI;
use DBD::mysql;
use Getopt::Std;
use vars qw($opt_h $opt_u $opt_p $opt_d $opt_t $opt_f $opt_m $opt_c);
#######################################################
# Catch Ctrl+C Quit
# 捕捉 Ctrl+C
$SIG{TERM}=$SIG{INT} = \&quit;

# Global Status Var
# 全局状态变量
my @sql;

# CmdLine Option Params
# 命令行参数变量
my($p_host, $p_user, $p_pwd, $p_db, $p_table, $p_file, $p_mod, $p_cnt, $p_num);

# Version
my $version='1.0 Release';

#######################################################
# Main Program
# 主程序
#######################################################

# Get CmdLine Options
# 获取命令行参数
&get_option();

# Read SQL From File
# 从文件中读取测试SQL
#&read_sql();

# Run Test
# 运行测试
&run_test();

#######################################################
# Print Usage
# 打印使用方法
#######################################################
sub print_usage () {
        printf <<EOF
 NAME:
        myrndtest

 SYNTAX:
        myrndtest -h host -u user -p password 
                  -d database -t tables 
                  -f file -m model -c count
                  -n number

 FUNCTION:
        Run MutilThread Random SQL Test

 PARAMETER:
      -h    Hostname
      -u    Username
      -p    Password
      -d    Database
      -t    Tables
      -f    SQL File
      -m    Test Model (0-Rnd Model 1-File Model)
      -c    Test Count
      -n    Test Thread Number     
EOF
}

#######################################################
# Get Options
# 获取命令行参数
#######################################################
sub get_option(){
    my $rtn = getopts('h:u:p:d:t:f:m:c:n:');
    unless ( "$rtn" eq "1" ) { print_usage(); exit 1;}

    $p_host  = $opt_h?$opt_h:'localhost';
    $p_user  = $opt_u?$opt_u:'root';
    $p_pwd   = $opt_p?$opt_p:'';
    $p_db    = $opt_d?$opt_d:'test';
    $p_table = $opt_t?$opt_t:'';
    $p_file  = $opt_f?$opt_f:'';
    $p_mod   = $opt_m?$opt_m:0;
    $p_cnt   = $opt_c?$opt_c:1;
    $p_num   = $opt_n?$opt_n:1;

    $p_host = lc($p_host);
    $p_user = lc($p_user);
    $p_db   = lc($p_db);
    $p_table= lc($p_table);
    $p_file = lc($p_file);
}

#######################################################
# Catch Ctrl+C
# 捕捉 Ctrl+C 以关闭程序和数据连接
#######################################################
sub quit {
    printf "\nExit...\n";
    #$dbconn->disconnect;
    exit 1;
}

#######################################################
# Read SQL From File
# 从文件中读取测试SQL
#######################################################
sub read_sql {
    my $i = 0;
    open(MYFILE,"C:\\tmp.txt");
    while (<MYFILE>) { 
        chomp;
        $sql[$i] = $_;
        $i++;
    }
    close(MYFILE);
}

#######################################################
# Run Test
# 运行测试
#######################################################
sub run_test {
    my @threads;

     printf "Start Multithread Test......\n";
     
    # 创建线程
    for(my $i=0; $i<$p_num; ++$i) {
        $threads[$i] = threads->create(\&test); 
    }
    for(my $i=0; $i<$p_num; ++$i) {
        $threads[$i]->join();
    }
}

#######################################################
# Test
# 测试函数
#######################################################
sub test {
    my $dbconn;
    my $id;
    my $sql;
    my $rows;

    my $tid = threads->tid();
    printf "Thread $tid Runing......\n";

    # 建立连接
    $dbconn = DBI->connect("DBI:mysql:database=$p_db:host=$p_host", $p_user, $p_pwd, {'RaiseError' => 1}) 
    or die "Connect to MySQL database error:". DBI->errstr;

    my ($max_id) = $dbconn->selectrow_array("SELECT MAX(ID) FROM $p_table");
    my ($min_id) = $dbconn->selectrow_array("SELECT MIN(ID) FROM $p_table");
    my $id_len = $max_id-$min_id;

    for (my $i=0; $i<$p_cnt; ++$i) {
        $id = $min_id+int(rand($id_len));
	$dbconn->do("SELECT * FROM $p_table WHERE ID=$id;");
    }
    $dbconn->disconnect;
    
    printf "Thread $tid End\n";
}

