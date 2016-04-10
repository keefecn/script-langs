:: ----------------------------------------------------------------------
:: DOS脚本示例
:: @HELP：help [command]
:: @CMD: FOR IF SET ECHO GOTO PAUSE CALL START CHOICE REM @ & && || |
:: @NOTE: 批处理命令不区分大小写，但建议统一大写；变量名大小写敏感。
::  1）REM或::-注释；@-不显示命令; &或&&-串行组合命令，前者不管命令执行情况；
::  2）变量：可分为环境变量、自定义变量和循环变量。变量可有延迟扩展SETLocal和EndLocal
::  2.1)环境变量：环境变量分预定义环境变量和自定义环境变量（既自定义变量）。环境变量引用%variable%；自定义变量启用变量延迟后，可以用!variable!，
::  2.2)循环变量：FOR循环变量在批处理文件使用%%variable，命令行使用%variabl; 变量名为单个字母a-z或A-Z，共48个，
::  2.3)参数变量：命令行传入参数变量引用为%1~9
::	2.4)变量增强引用 自定义变量的增强扩展：可进行字符串替换%v:?=?%、字符串截取%v:?,?%、字符串合并。循环和参数变量的变量扩展使用%~
::  3) 常用命令
:: 	@@FOR: For {%variable|%%variable} in (set) do command [ CommandLineOptions] 
::	(set)指定一个或一组文件; 在参数/F时set可以是字符串、文件、命令返回数字
::	FOR /D 目录;  FOR /R 目录树;  FOR /L 数字序列; FOR /F 分析命令的输出
::  @@IF: IF "参数"=="字符串";  IF EXIST 文件名；IF ERRORLEVEL / if not errorlevel 数字
::  4) 路径是空格，使用引号圈起
:: @REFER: help FOR, http://www.jb51.net/article/52744.htm
::
:: This is a free shell script under GNU GPL version 2.0 or above
:: Copyright (C) 2006 Denny
:: ----------------------------------------------------------------------
@ECHO OFF
:: 变量扩展
SETlocal enabledelayedexpansion

1)巧妙地删除某个目录下(包括子目录)的指定文件
命令：del d:\_desktop.ini /f/s/q/a
用途：删除所有d盘下文件名为_desktop.ini的文件
使用范围：用于删除蠕虫病毒，极妙。

2)将指定文件拷贝到某个目录下(包括子目录) FOR /R
命令：FOR /R d:\test %i IN (.) DO copy c:\root.ini %i /Y 
用途：将boot.int文件拷贝在d: est的所有的子目录和本目录
使用范围： 开玩笑地蠕虫

3)扫描一个网段的全部端口: FOR /L
用途：扫描192.168.0.x段的全部1到65535段口 
使用范围：端口扫描，不再需要工具
命令：
FOR /L %a in (1,1,254) DO (
 FOR /L %b in (1,1,65535) DO start /low /min telnet 192.168.0.%a %b 
)

4)暴力网络连接主机
FOR /f %%i in (dict.txt) DO net use /ipipc$ "%%i" /u:"administrator" |find ":命令成功完成">>D:ok.txt

5)从文件中获取参数调用外部批处理程序
描述：表示按顺序将victim.txt中的内容传递给door.bat中的参数%i %j %k。
@for /f "tokens=1,2,3 delims= " %%i in (victim.txt) do start call door.bat %%i %%j %%k

6) 统计本目录下一级目录下文件数目 FOR /D
:: list file and num, the same to "find | wc -l"
:: add by Denny, 2015-2-16
SET filename=dirfiles.txt
cd. > %filename%
ECHO "filename	num" >> %filename%	

FOR /d %%a  in (*.*) DO (
SET n=0
FOR /f %%B in ('dir /a-d /b /s "%%a"') DO SET /a n+=1
ECHO %%a    !n! >> %filename%
)


