:: 
:: DESC: 测试文件是否存在

@ECHO OFF
:: 变量扩展
SETlocal enabledelayedexpansion

SET dirname="F:\movie\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\日本\CA - (原北都.Hokuto)\MOODYZ（2000~）\(MIDD｜MIDE) MOODYZ DIVA\(MIDE)"
set i=1
set j=280
set prefix=MIDE-
set postfix=.jpg
set num=0
set lostnum=0
DEL tmp.txt

	ECHO [1]START...
FOR /L %%a in (%i%,1,%j%) DO (
	SET num=%%a
    IF /I %%a LSS 100 (
		SET num=0%%a
	)
    IF /I %%a LSS 10 (
		SET num=00%%a
	)
	set filename=%prefix%!num!
	SET fullfilename=%dirname%\!filename!%postfix%

	REM ECHO [2]!fullfilename!
	REM ECHO [2-1]!filename!
	IF NOT EXIST  !fullfilename! (
		SET /A lostnum+=1
		ECHO !num! isn't exist
		ECHO [!filename!] >> tmp.txt
	)
)
		ECHO [!lostnum!] files LOST

Endlocal

:END
:: PAUSE
