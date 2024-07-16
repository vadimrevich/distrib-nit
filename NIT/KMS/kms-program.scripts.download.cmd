@echo on
rem *******************************************************
rem kms-program.scripts.download.cmd
rem This Script will Download an Archive
rem *******************************************************
@echo off

rem Set Variables
rem
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=KMS
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

rem Set a Variables
rem
set REGEXE=%SystemRoot%\System32\reg.exe

rem Check Integrity...
if not exist %REGEXE% echo %REGEXE% is not Found && exit /b 1
if not exist %COMSPEC% echo %COMSPEC% is not Found && exit /b 1

rem Set DownloadShellFolder Variable...
rem
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
rem if not defined DownloadShellFolder echo DownloadShellFolder is not Defined  && exit /b 1
rem if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && exit /b 1

rem Set My Documents Variable...
rem
for /f "tokens=2,*" %%i in ('%REGEXE% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v Personal  ^|findstr /i "REG_"') do set MyDocuments=%%j

rem if not defined MyDocuments (echo Variable My Documents Folder not Defined && exit /b 1)
rem if not exist %MyDocuments% echo %MyDocuments% is not Found && exit /b 1

rem Check UserProfile Variable...
rem
if not defined UserProfile (echo Variable UserProfile Folder not Defined && exit /b 1)
if not exist %UserProfile% echo %UserProfile% is not Found && exit /b 1

rem Set Working Directory
if not defined DownloadShellFolder echo Variable DownloadShellFolder is not defined && goto Lab_Profile
if not exist %DownloadShellFolder% echo %DownloadShellFolder% is not Found && goto Lab_Profile
set WorkingDir=%DownloadShellFolder%
goto Lab_EndWorkingdir

:Lab_Profile
set WorkingDir=%UserProfile%
goto Lab_EndWorkingdir

:Lab_EndWorkingdir
rem Set a Directory
rem set WorkingDir=%USERPROFILE%\Downloads
set anURLDir=http://distrib.netip6.ru/%PRODUCT_FOLDER_REMOTE%

set aFile=KMS-Settings.zip

rem Run payload
powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command ^
"((new-object System.Net.WebClient).DownloadFile('%anURLDir%%aFile%', '%WorkingDir%\%aFile%'))"
