@echo off
rem ��������
net.exe session 1>NUL 2>NUL && (
    goto gotAdmin
) || (
    goto UACPrompt
)

rem �����擾
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" 
    "%temp%\getadmin.vbs" 
    exit /B  
   
:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )  
 
:begin
Title IP�A�h���X�ݒ�
set NAME="�C�[�T�l�b�g"

echo �y�Ǘ��Ҍ����Ŏ��s���z����IP�A�h���X��ݒ肷��F
echo 1 :���IIP�A�h���X�iDHCP�j
echo 2 :192.168.0.2
echo �I�񂾌��Enter�L�[�������Ă��������B
set /p operate=
if %operate%==1 goto 1
if %operate%==2 goto 2

:1
echo ���IIP�A�h���X��ݒ蒆�c
netsh interface ip set address name=%NAME% source=dhcp
netsh interface ip set dns name=%NAME% source=dhcp
echo �ݒ芮���B
exit

:2
echo 192.168.0.2��ݒ蒆�c
netsh interface ip set address name=%NAME% source=static addr=192.168.0.2 mask=255.255.255.0 gateway=192.168.0.1 gwmetric=0
echo �ݒ芮���B
exit