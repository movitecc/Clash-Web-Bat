@echo off &title 指定配置文件启动clash
::CODER BY pcysanji 2020-02-26
mode con cols=44 lines=24
color f1

::设置环境变量
SET PATH="%~dp0";"%~dp0App";%PATH%
CD /D %~DP0
taskkill /IM clash-win64.exe >NUL 2>NUL
:start
echo.&echo.
echo -------------------------------------
echo.
set /p CONFIG=请输入需要启动的配置文件名(不带后缀名)并回车:

::创建vbs隐藏clash启动
echo CreateObject("WScript.Shell").Run "clash-win64 -d .\Profile -f .\Profile\%CONFIG%.yaml",0 >.\App\startclash.vbs
wscript ".\App\startclash.vbs" 
start http://127.0.0.1:9090/ui/#/proxies &cls
msg %username% /time:10s clash启动成功，配置文件名为%CONFIG%.yaml。
call Clash-Web-Bat.CMD