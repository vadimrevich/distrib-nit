@echo off
rem *******************************************************
rem nit-TinyExeFiles-run.cmd
rem This Script will Download and Execute the TinyExeFiles 
rem Packet witn Command Line Utilities
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TinyExeFiles
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Working Directory (may be Changed)
rem
set WorkingDir=%TPDL%

rem Set Host
rem
set aPrefix=http
set aDomain=file.netip4.ru
set aPort=80
set aRemoteDir=/PROGS/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

rem Set files and Path
rem
set pathCMD=%SystemRoot%\System32
set POSHEXE=%pathCMD%\WindowsPowerShell\v1.0\powershell.exe

rem Check Integrity...
rem
if not exist %POSHEXE% echo %POSHEXE% is not found && exit /b 1

rem echo Download and Run Payload..
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
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Set a File Names
set aFile1=nit-download-TinyExeFiles.MSI.Silent.cmd
set aFile2=install-TinyExeFiles.MSI.Silent.cmd

rem Download Payloads
rem
%POSHEXE% -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
"$webClient = new-object System.Net.WebClient; $webClient.DownloadFile('%host%%aFile1%', '%WorkingDir%\%aFile1%')"

%POSHEXE% -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
"$webClient = new-object System.Net.WebClient; $webClient.DownloadFile('%host%%aFile2%', '%WorkingDir%\%aFile2%')"


rem Run Payloads
rem

call %WorkingDir%\%aFile1%
call %WorkingDir%\%aFile2%


rem echo The End of the Script %0
exit /b 0
