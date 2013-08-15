@echo off

echo 清空IE临时文件目录...
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"

echo 正在清除系统临时文件 *.tmp *._tmp *.log *.chk *.old ，请稍等...
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old

echo 清空垃圾箱，备份文件和预缓存脚本...
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp

rem cooke和最近历史还是保留吧...
rem del /f /q %userprofile%\COOKIES s\*.*
rem del /f /q %userprofile%\recent\*.*



echo 清理系统盘无用文件...
%windir%\system32\sfc.exe /purgecache

echo 优化预读信息...
%windir%\system32\defrag.exe %systemdrive% -b

echo 清除系统完成！

echo. & pause
