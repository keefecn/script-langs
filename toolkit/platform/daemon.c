
/**
@file: daemon.c
@author: keefe
@date: 2018/3/31
@brief: Daemon实现步骤简述
（1）在父进程中执行fork并exit推出； // 保证父进程是init进程
（2）在子进程中调用setsid函数创建新的会话； //
（3）在子进程中调用chdir函数，让根目录 ”/” 成为子进程的工作目录；
（4）在子进程中调用umask函数，设置进程的umask为0；
（5）在子进程中关闭任何不需要的文件描述符。
*/
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>

#define ERR_EXIT(m) \
do \
{ \
    perror(m);\
    exit(EXIT_FAILURE);\
} \
while (0);\
 
void create_daemon(void);

int main(void)
{
    time_t t;
    int fd;
    // method 1: self implement
    //creat_daemon();
    // method 2: man 2 daemon
    if (daemon(0, 0) == -1)
        ERR_EXIT("daemon error");
    while(1) {
        fd = open("daemon.log",O_WRONLY|O_CREAT|O_APPEND,0644);
        if(fd == -1)
            ERR_EXIT("open error");
        t = time(0);
        char *buf = asctime(localtime(&t));
        write(fd,buf,strlen(buf));
        close(fd);
        sleep(60);

    }
    return 0;
}

void create_daemon(void)
{
    pid_t pid;
    pid = fork();
    if( pid == -1)   // fork失败，退出
        ERR_EXIT("fork error");
    if(pid > 0 )  // 父进程退出
        exit(EXIT_SUCCESS);
    if(setsid() == -1)
        ERR_EXIT("SETSID ERROR");
    chdir("/");  // 缺省根目录，此目录用户需要有权限操作，否则需要root启动
    int i;
    for( i = 0; i < 3; ++i)
    {
        close(i);
        open("/dev/null", O_RDWR);
        dup(0);
        dup(0);
    }
    umask(0);
    return;
}

