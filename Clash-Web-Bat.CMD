@echo off &title clash 管理
::CODER BY pcysanji 2020-02-24
mode con cols=44 lines=24
color f1
SET PATH="%~dp0";"%~dp0App";%PATH%
:menu
CD /D %~DP0
taskkill /IM subconverter.exe >NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >NUL
cls
echo.&echo.
echo -------------------------------------
echo.
echo  clash web 控制台
echo.
echo.  [1]   启动 clash
echo.
echo.  [2]   关闭 clash
echo.
echo.  [3]   下载配置文件
echo.
echo.  [4]   添加到开机启动
echo.
echo.  [5]   更新 GeoIP 数据库
echo.
echo.  [X]   退出
echo.
echo -------------------------------------
echo.
choice /C:12345X /N /M "请输入你的选项 ："

if errorlevel 6 exit
if errorlevel 5 goto :geoipupdate
if errorlevel 4 goto :startup
if errorlevel 3 goto :subconvert
if errorlevel 2 goto :stop-clash
if errorlevel 1 goto :start-clash

:start-clash
taskkill /IM clash-win64.exe >NUL 2>NUL
wscript ".\App\startclash.vbs" 
start http://127.0.0.1:9090/ui/#/proxies &cls
msg %username% /time:10s 启动成功，返回 clash web 控制台可进行系统代理的设置
echo.
echo -------------------------------------
echo 启动成功，是否设置系统代理
echo.
echo.&echo  [1]  是，请设置系统代理
echo.&echo  [2]  否并返回主菜单
echo.
echo.&echo  [X]  直接退出
echo.
echo ==============================
echo.
echo.
choice /C:12X /N /M "请输入你的选项 ："

if errorlevel 3 exit
if errorlevel 2 goto :menu
if errorlevel 1 goto :setproxy

:setproxy
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "127.0.0.1:7890" /f >NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f >NUL

echo 系统代理设置完成，按任意键返回菜单。&pause >NUL 2>NUL
goto menu

:stop-clash
taskkill /IM clash-win64.exe >NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >NUL
echo 成功关闭clash，按任意键返回菜单。&pause >NUL 2>NUL
goto menu

:subconvert
CLS
taskkill /IM clash-win64.exe >NUL 2>NUL
cd ".\App\subconverter"
wscript start-subconverter.vbs
CD /D %~DP0
echo.&echo.
echo -------------------------------------
echo.
set /p URL=请输入订阅地址并回车:
copy  /y ".\Profile\*.yaml"  ".\Profile\*.yaml-bak" >NUL 2>NUL
cls
echo.&echo.
echo -------------------------------------
echo.
echo 请输入不带后缀名,建议纯英文的配置文件名，直接回车配置文件名则为 config
echo.
set /p configname=请输入配置文件名并回车:
if "%configname%"=="" (wget -O ".\Profile\config.yaml" "%URL%") else (
wget -O ".\Profile\%configname%.yaml" "%URL%" )
cls
echo.&echo.
echo -------------------------------------
echo.
echo 下载完成，旧配置文件.yaml备份为.yaml-bak。是否启动 Clash？
echo.
echo.  [1]   启动 clash
echo.
echo.  [2]   返回菜单
echo.
echo.  [X]   退出
echo.
choice /C:12X /N /M "请输入你的选项 ："

if errorlevel 3 goto exit
if errorlevel 2 goto menu
if errorlevel 1 call selectprofile

:startup
call startup.bat
exit

:geoipupdate
cd "%~DP0Profile\" 
wget -O GeoLite2-Country.tar.gz "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=oeEqpP5QI21N&suffix=tar.gz"
7za.exe e GeoLite2-Country.tar.gz
7za e GeoLite2-Country.tar "GeoLite2-Country*\GeoLite2-Country.mmdb" -aoa
del "Country.mmdb" /f /q
del "GeoLite2-Country.tar*" /f /q
ren GeoLite2-Country.mmdb Country.mmdb
cls
echo.&echo.
echo -------------------------------------
echo.
echo 更新成功，按任意键返回菜单。&pause >NUL 2>NUL
goto menu

:exit
taskkill /IM subconverter.exe >NUL 2>NUL
taskkill /IM clash-win64.exe >NUL 2>NUL
exit
