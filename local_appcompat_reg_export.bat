
@echo off

rem detect Windows XP
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 goto xp_appcompat

rem For Windows 7

reg export "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache" %COMPUTERNAME%_appcompat_0.reg /y >nul 2>&1
reg export "HKLM\SYSTEM\ControlSet001\Control\Session Manager\AppCompatCache" %COMPUTERNAME%_appcompat_1.reg /y >nul 2>&1
reg export "HKLM\SYSTEM\ControlSet002\Control\Session Manager\AppCompatCache" %COMPUTERNAME%_appcompat_2.reg /y >nul 2>&1
reg export "HKLM\SYSTEM\ControlSet003\Control\Session Manager\AppCompatCache" %COMPUTERNAME%_appcompat_3.reg /y >nul 2>&1

goto end

:xp_appcompat
rem For Windows XP

regedit /e %COMPUTERNAME%_appcompat_0.reg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatibility" >nul 2>&1
regedit /e %COMPUTERNAME%_appcompat_1.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\AppCompatibility" >nul 2>&1
regedit /e %COMPUTERNAME%_appcompat_2.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager\AppCompatibility" >nul 2>&1
regedit /e %COMPUTERNAME%_appcompat_3.reg "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet003\Control\Session Manager\AppCompatibility" >nul 2>&1

rem Give regedit enough time to finish

ping -n 5 127.0.0.1 >nul

:end

rem Use some utility to compress .reg files into a single file for transit back to collecting host
