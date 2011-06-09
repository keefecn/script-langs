#dos下脚本示例
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2006 Denny
# ----------------------------------------------------------------------

1)巧妙地删除某个目录下(包括子目录)的指定文件
命令：del d:\_desktop.ini /f/s/q/a
用途：删除所有d盘下文件名为_desktop.ini的文件
使用范围：用于删除蠕虫病毒，极妙。

2)将指定文件拷贝到某个目录下(包括子目录)
命令：FOR /R d:\test %i IN (.) DO copy c:\root.ini %i /Y 
用途：将boot.int文件拷贝在d: est的所有的子目录和本目录
使用范围： 开玩笑地蠕虫

3)扫描一个网段的全部端口
命令：for /l %a in (1,1,254) do for /l %b in (1,1,65535) do start /low /min telnet 192.168.0.%a %b 
用途：扫描192.168.0.x段的全部1到65535段口 
使用范围：端口扫描，不再需要工具

