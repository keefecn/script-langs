# -*- coding=utf-8 -*-
"""
远程代理 
示例：./start_proxy.py xx.xx.xx.xx:8008
"""
import sys
import os
import socket
import time


def net_is_used(port, ip='127.0.0.1'):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        s.connect((ip, port))
        s.shutdown(2)
        return True
    except Exception as e:
        # print(e)
        return False


def startProxy(hostPortInfo):
    hostInfoArr = hostPortInfo.split(':')
    if(len(hostInfoArr) != 2):
        print('Error: 参数格式必须是[host:port]形式')
        sys.exit(-1)

    host = hostInfoArr[0]
    port = (int)(hostInfoArr[1])

    # 初始化新端口号
    new_port = port
    while(True):
        if(net_is_used(new_port)):
            print('Info: 端口号[%d]已经被占用了,使用新端口号[%d]' % (new_port, new_port + 1))
            new_port += 1
            # 暂停1秒钟
            time.sleep(1)
        else:
            print('Info: 端口号[%d]未被占用,可以继续使用' % (new_port))
            break

    # 拼接对应的命令
    start_command = 'nohup ssh -C -N -g -L ' + \
        str(new_port) + ':127.0.0.1:' + str(port) + \
        ' ' + str(host) + ' >/dev/null 2>&1 &'
    print('执行命令:' + start_command)
    os.system(start_command)

    # 查看对应的端口号是否正常启动
    status_command = 'ps -ef | grep ssh | grep 127.0.0.1'
    print('执行命令:' + status_command)
    os.system(status_command)


if __name__ == "__main__":
    if(len(sys.argv) < 2):
        print('Error:必须带有一个参数[host:port]')
        sys.exit(-1)
    # 获取对应的主机和端口号信息
    hostPortInfo = sys.argv[1]
    # 开始启动代理
    startProxy(hostPortInfo)

