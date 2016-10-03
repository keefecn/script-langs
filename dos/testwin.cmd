:: 
:: DESC: TEST
@ECHO OFF


:TEST1
REM TEST 环境变量的增强引用~字符串替换
SET a=hello world! 
ECHO 替换前的值: %a% 
ECHO 替换后的值：%a: =% 
ECHO 替换后的值：%a:llo= is her % 
ECHO 替换后的值：%a: =_% 
ECHO 替换后的值：%a:*lo=the% 
ECHO 替换后的值：%a:2,1% 
ECHO 替换后的值：%a:-2,1% 

:: GOTO END

 
:TEST2
REM TEST 参数变量的增强引用, 短名%s无效
REM test.cmd "C:\Program Files (x86)\Git\bin\sort.exe"   
ECHO 正在运行的这个批处理：
ECHO 原名称：%1
ECHO 完全路径：%~f1
ECHO 去掉引号：%~1
ECHO 所在分区：%~d1
ECHO 所处路径：%~p1
ECHO 文件名：%~n1
ECHO 扩展名：%~x1
ECHO 文件属性：%~a1
ECHO 修改时间：%~t1
ECHO 文件大小：%~z1
ECHO 短名：%~s1
ECHO 完全路径与短名：%~fs1
ECHO 输出类似DIR：%~ftza1

GOTO END

:TEST3
SETlocal enabledelayedexpansion
REM SET TMP=" 正在运行的这个批处理"
:: SET TMP=%1
SET dirfile="F:\movie\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\日本"
:: SET dirfile="F:\movie\观影指南.Viewing_Guide\AV_Guie"
	 SET fa=%dirfile%\%TMP%
	 SET fb=!fa:"=!
	 ECHO [2-1]%dirfile%\%TMP%
	 ECHO [2-2]!fa!
	 ECHO [2-3]!fb!
Endlocal

GOTO END


:TEST-END
"C:\Program Files (x86)\Git\bin\sort.exe" -n dir_tmp.txt  
GOTO END

:END
:: PAUSE
