@echo off

:: 注释,使用::或rem，源文件UTF-8格式，在cmd下运行，中文会乱码，cmd终端缺省是ANSI编码，可修改终端编码为UTF-8。
:: echo 清空IE临时文件目录...
echo clean temp IE director...
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"

echo cleaning temp file *.tmp *._tmp *.log *.chk *.old...
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old

:: echo 清空垃圾箱，备份文件和预缓存脚本...
echo cllean rubbish, cache and *.bak
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp

rem cooke和最近历史还是保留吧...
rem del /f /q %userprofile%\COOKIES s\*.*
rem del /f /q %userprofile%\recent\*.*

:: echo 清理系统盘无用文件...
echo clean system rubbish
%windir%\system32\sfc.exe /purgecache

:: echo 优化预读信息...
%windir%\system32\defrag.exe %systemdrive% -b

:: echo 清除系统完成！
echo  clean ok

echo. & pause
