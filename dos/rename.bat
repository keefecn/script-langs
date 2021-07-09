@echo off
setlocal enabledelayedexpansion
:: flower为要重命名的目录名, ren需要全路径
set dir=C:\Users\keefe\Pictures\f2
set n=1
:: 目录下所有文件都被命名成flower1.jpg、flower2.jpg、flower3.jpg…………
for /f %%i in ('dir /b !dir!') do (
    ren "!dir!\%%i" flower!n!.jpg
    set /a n+=1
)

echo 批量重命名完成！ 
pause