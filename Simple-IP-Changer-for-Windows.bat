@echo off
rem 特権判定
net.exe session 1>NUL 2>NUL && (
    goto gotAdmin
) || (
    goto UACPrompt
)

rem 特権取得
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" 
    "%temp%\getadmin.vbs" 
    exit /B  
   
:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )  
 
:begin
Title IPアドレス設定
set NAME="イーサネット"

echo 【管理者権限で実行中】次のIPアドレスを設定する：
echo 1 :動的IPアドレス（DHCP）
echo 2 :192.168.0.2
echo 選んだ後にEnterキーを押してください。
set /p operate=
if %operate%==1 goto 1
if %operate%==2 goto 2

:1
echo 動的IPアドレスを設定中…
netsh interface ip set address name=%NAME% source=dhcp
netsh interface ip set dns name=%NAME% source=dhcp
echo 設定完了。
exit

:2
echo 192.168.0.2を設定中…
netsh interface ip set address name=%NAME% source=static addr=192.168.0.2 mask=255.255.255.0 gateway=192.168.0.1 gwmetric=0
echo 設定完了。
exit