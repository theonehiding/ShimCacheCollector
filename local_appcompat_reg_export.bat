
@echo off

echo.> %TEMP%\reg_0.reg
echo.> %TEMP%\reg_1.reg
echo.> %TEMP%\reg_2.reg
echo.> %TEMP%\reg_3.reg

rem detect Windows XP
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 goto xp_appcompat

rem For Windows 7

reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache" %TEMP%\reg_0.reg /y >nul 2>1
reg export "HKLM\SYSTEM\ControlSet001\Control\Session Manager\AppCompatCache" %TEMP%\reg_1.reg /y >nul 2>1
reg export "HKLM\SYSTEM\ControlSet002\Control\Session Manager\AppCompatCache" %TEMP%\reg_2.reg /y >nul 2>1
reg export "HKLM\SYSTEM\ControlSet003\Control\Session Manager\AppCompatCache" %TEMP%\reg_3.reg /y >nul 2>1

goto end

:xp_appcompat
rem For Windows XP

regedit /e %TEMP%\reg_0.reg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatibility" >nul 2>1
regedit /e %TEMP%\reg_1.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\AppCompatibility" >nul 2>1
regedit /e %TEMP%\reg_2.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager\AppCompatibility" >nul 2>1
regedit /e %TEMP%\reg_3.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager\AppCompatibility" >nul 2>1

rem Give regedit enough time to finish

ping -n 5 127.0.0.1 >nul

:end

echo Windows Registry Editor Version 5.00 > %COMPUTERNAME%_appcompat.reg
echo.>> %COMPUTERNAME%_appcompat.reg
type %TEMP%\reg_0.reg | find /v "Windows Registry Editor Version 5.00" >> %COMPUTERNAME%_appcompat.reg
type %TEMP%\reg_1.reg | find /v "Windows Registry Editor Version 5.00" >> %COMPUTERNAME%_appcompat.reg
type %TEMP%\reg_2.reg | find /v "Windows Registry Editor Version 5.00" >> %COMPUTERNAME%_appcompat.reg
type %TEMP%\reg_3.reg | find /v "Windows Registry Editor Version 5.00" >> %COMPUTERNAME%_appcompat.reg

del %TEMP%\reg_0.reg %TEMP%\reg_1.reg %TEMP%\reg_2.reg %TEMP%\reg_3.reg
