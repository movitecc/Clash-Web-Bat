@ECHO OFF & TITLE 添加 clash 开机启动
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)
mode con cols=44 lines=24
color f1
CD /D %~DP0\..\
SET PATH="%~dp0";"%~dp0App";%PATH%

:menu
cls
echo.&echo.
echo -------------------------------------
echo.
echo.
echo 请选择
echo.
echo.  [1] 开机启动
echo.
echo.  [2] 删除开机启动
echo.
echo.  [X] 退出
echo.
choice /C:12X /N /M  "清楚如您的选项："

if errorlevel 3 exit
if errorlevel 2 goto :delete
if errorlevel 1 goto :startup

:startup
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "clash-web" /t REG_SZ /d "\"%~dp0start-clash.vbs\"" /f

echo 添加成功按任意键返回主菜单 &pause >NUL
call Clash-Web-Bat.CMD

:delete
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "clash-web"  /f>NUL 2>NUL

echo 删除成功按任意键返回主菜单 &pause >NUL
call Clash-Web-Bat.CMD