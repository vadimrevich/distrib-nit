@echo off
rem *******************************************************
rem auxpayload.run.cmd
rem This Script will Run an Auxiliary payload
rem for Fishing at Local Windows Computer
rem *******************************************************
@echo off

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

rem Set Files and Directories
rem
set pathCMD=%SystemRoot%\System32
set WorkingDir=%TEMP%\mainexample.7

set NOTEPADEXE=%SystemRoot%\notepad.exe
set REGEXE=%pathCMD%\reg.exe
set aFishingPayloadFileName=Fishing.Payload.txt
set aFishingPayloadFilePath=%~dp0%aFishingPayloadFileName%

rem First Check Integrity...
rem
if not exist %NOTEPADEXE% echo %NOTEPADEXE% is not found && exit /b 1
if not exist %REGEXE% echo %REGEXE% is not found && exit /b 1
if not exist %aFishingPayloadFilePath% echo %aFishingPayloadFilePath% is not found && exit /b 1

rem Prepare a Files...
rem
set aFishingPayloadDownPath=%DownloadsPath%\%aFishingPayloadFileName%

if exist %aFishingPayloadDownPath% del /Q /F %aFishingPayloadDownPath%
copy /Y %aFishingPayloadFilePath% %aFishingPayloadDownPath%

rem Start a Payload
rem
START %NOTEPADEXE% %aFishingPayloadDownPath%

:End
exit /b 0
