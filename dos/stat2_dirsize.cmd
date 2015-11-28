:: 
:: DESC: 统计次级目录下的文件个数和总大小
:: NOTE: 传入参数中若带有空格，则要加入扩展参数和去引号

@ECHO OFF

:: IF [%1]==[] GOTO USAGE
:: if NOT exist "%1" (
:: ECHO "dirfile" path not exist & GOTO END
:: )

SET dirfile="F:\movie\观影指南.Viewing_Guide\AV_Guide\playbill海报(AV)\日本"
IF NOT [%1]==[] (
	SET dirfile=%1
)
ECHO [1]START...
:DIR_PATH
:: CD /D %dirfile%
DIR /ad /b %1 > 1.txt

SETlocal enabledelayedexpansion
SET fa=
:: FOR参数扩展：usebackq，tokens=*，delims=带tokens参数的 FOR, %%i引用第二个符号，%%j引用第三个符号，%%k引用第三个符号后的所有剩余符号。
:: 全路径要去引号
	ECHO [2]START...
FOR /f "usebackq tokens=*" %%i IN (d:\project\1.txt) DO (
	REM ECHO [2-]DEBUG...
	REM SET fa=!dirfile:"=!\%%i
	REM ECHO [2-1]"!fa!"
	REM ECHO [2-2]"%~1\%%i"
	REM NOTE-BOTH OK~ "!dirfile!\%%i", "!fa!", "%~1\%%i"
	DIR /s  "!dirfile!\%%i" |findstr 个文件 > 2.txt || ECHO. > 2.txt
	REM FOR /f "eol=0 tokens=1,3 " %%j in (2.txt) DO SET ll=%%k 字节 %dirfile%\%%i  %%j 个文件 
	FOR /f "eol=0 tokens=1,3 " %%j in (2.txt) DO SET ll=%%k & SET ll=!ll:~0,-9! MB %%i  %%j 个文件 
	ECHO  !ll!  
)
ECHO [3]END
CD /D "D:\PROJECT"

Endlocal

:CLEAN
DEL 1.txt 
DEL 2.txt
GOTO END

:USAGE
ECHO Usage: %0 dir_path
GOTO   END 

:END
:: PAUSE
