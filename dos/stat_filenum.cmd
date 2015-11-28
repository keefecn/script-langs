:: 
:: DESC: 统计次级目录下的文件个数
:: NOTE:
::  1.批处理命令不区分大小写，但建议统一大写；变量名大小写敏感。
::  2.注释,句首使用::，FOR循环/IF内部使用REM
::  3.带空格的路径，FOR内参数扩展delims或者token, 内部变量使用扩展参数获取全路径
::  4.文件为全路径，调用DIR时有可能长路径出错
:: 解决了两大疑难：1) FOR循环变量的路径带空格，使用"%VAR%"; 2) DIR的长路径，使用短路径

@ECHO OFF

SET tmpname="d:\project\dir_tmp.txt"
SET filename="d:\project\dir_sort.txt"
SET fulldirlist="d:\project\dir.txt"

:: 变量延迟
SETlocal enabledelayedexpansion

:: F:\Media\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\AV女优.Actress\日裔\人气女优2 人气女优1 混血女优 人気女優(2005年前出道)
:: F:\Media\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\日本\CA - (原北都.Hokuto) !  
SET mydir="F:\movie\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\日本\"
IF NOT [%1]==[] (
	REM if input argument is null, then reset mydir
	SET mydir=%1
)
SET yes=N
IF [%2]==[2] (
	SET yes=Y
)
ECHO [1]curdir=%mydir%
ECHO [1-0]2 dir: %2

CD /D %mydir%
CD > %tmpname%
ECHO filename	num >> %tmpname%	

:: get dir list: 2 level dirlist
:: ECHO. > %fulldirlist%
DEL %fulldirlist%
FOR /D %%a  IN (*.*) DO (
	ECHO [1.1]%%~fa
	ECHO %%~fa >> %fulldirlist%
	IF  [%yes%]==[Y] (
		CD %%~fa
		FOR /D %%b  IN (*.*) DO (
			ECHO [1.2]%%~fb
			ECHO %%~fb >> %fulldirlist%
		)
		CD ..
	)
)

:STAT
CD %mydir%
		ECHO	[2]start find dir
SET sum=0
SET dirnum=0
:: FOR参数扩展：带空格的路径 OK -"delims=" or "tokens=*"  && "usebackq"
:: COPY  %fulldirlist% .
:: FOR /F  "delims=" %%c  IN (dir.txt) DO (
FOR /F  "usebackq tokens=*" %%c  IN (%fulldirlist%) DO (
	SET n=0
	REM  %%~fc is necessay, else WRONG PATH
	REM ECHO	[3]%%c
	FOR /F "delims="  %%d IN ('DIR /a-d /b /s "%%~fc"') DO SET /A n+=1
	ECHO !n!	%%c 
	ECHO !n!	%%~nc >> %tmpname%
	SET /A sum+=n
	SET /A dirnum+=1
)
	ECHO !sum!	total 
	ECHO !sum!	total, [!dirnum!]dirs >> %tmpname%


:: list file and num, the same to "find | wc -l"
:: sort:  sort -n -k 2 -r 
:: OK 1: 
::  SET sum=0
::  FOR /D %%a  IN (*.*) DO (
::  	SET n=0
::  	FOR /F %%b IN ('DIR /a-d /b /s "%%a"') DO SET /A n+=1
::  	ECHO !n!	%%a
::  	ECHO !n!	%%a >> %tmpname%
::  	SET /A sum+=n
::  )
::  ECHO !sum!	 "total" >> %tmpname%

:: BAD 1: FOR /R too many directorys
::  FOR /R %mydir% %%c  IN (.) DO (
::  	REM ECHO %%c
::  	SET n=0
::  	FOR /F  %%d IN ('DIR /a-d /b /s "%%c"') DO SET /A n+=1
::  	ECHO !n!	%%c
::  	ECHO !n!	%%c >> %tmpname%
::  )

Endlocal

:SORT
ECHO [4]START SORT
:: SORT, 调用外部命令如果路径带空格，用引号圈起来。此外，注意变量延迟
:: use linux_sort instead of windows_sort
"C:\Program Files (x86)\Git\bin\sort.exe" -n %tmpname%  
:: "C:\Program Files (x86)"\Git\bin\sort.exe -g %tmpname%  > %filename% 

:CLEAN
:: mv file to dirctory: mv -f, copy
:: COPY /Y %filename% d:\project
:: COPY /Y %tmpname% d:\project
:: DEL %fulldirlist%
:: DEL %tmpname%
:: DEL %fulldirlist%
GOTO   END 

:USAGE
ECHO Usage: %0 dir_path  level
GOTO   END 

:END
:: PAUSE

