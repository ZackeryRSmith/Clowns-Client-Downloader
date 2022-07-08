rem Project Made By Zackery Robert Smith
rem Github : https://github.com/WillsCHEATTT/Clowns-Client-Downloader
rem Gmail : ZackeryRobertSmith@gmail.com
rem Discord : Clown#8147


rem This project is protected by the GNL 3 Public Licence (Read Before Making Changes To This Program)
rem GNL Genral Public Licence : https://www.gnu.org/licenses/gpl-3.0.txt

rem I've tried my best to document my code so anyone can add or remove things
rem -------------------------------------------------------------------------------------------


rem Saves Data In The Config.txt File And Stores It In a Varable
@echo off
< .\"Config".txt (
set /p dir=
set /p link=
set /p ext=
set /p file_name=
set /p comp_file=
set /p warning=
)
goto top

rem a useless code block that is hidden (Really No Need For This)
rem ````````````````````````````````````````````````````
rem :test
rem echo Would You Like To Use AutoUpdate On %file_name%
rem echo 1 = Yes
rem echo 0 = No
rem set /p Input=: 
rem if "%Input%"=="1" goto top
rem if "%Input%"=="0" start .\%file_name%.%ext%
rem echo Not 1 or 0
rem timeout 1 >nul
rem exit
rem ````````````````````````````````````````````````````


:top
rem Pings The CloudFlare Servers To See If You Can Pig Them If Not It Means Your Internet Is Off Or CloudFlare's Servers
rem are down (Remove If It Causes Trobble)
for /f "tokens=1 delims=:" %%j in ('ping 1.1.1.1 -4 -n 1 ^| findstr Request') do (
    set online=%%j
)
if "%online%" == "Request timed out." goto no_wifi
if not "%online%" == "Request timed out." goto start

rem Self Explanitory It Sends You Here If You Fail To Ping 1.1.1.1
:no_wifi
mode con lines=20 cols=58
cls 
echo [38;2;11;25;222mSorry %USERNAME% you are curently not connected to the internet
echo Please contact Clown#8147 if you need help
pause
exit

:start
rem Mainly Gui And Looks Here
mode con lines=10 cols=43
echo [91m*******************************************
echo *   Welcome to [92mClowns Client Downloader   [91m*
echo *                                         *
echo *                                         *
echo *        Open-Sourced Tool Updater        *
echo *                                         *
echo *        Developed By : [92mClown#8147        [91m*
echo *******************************************
echo        Copyright (c) 2021 Zackery .R. Smith
timeout 5 >nul
echo [91m*******************************************
echo *   Welcome to [92mClowns Client Downloader   [91m*
echo *                                         *
echo *                                         *
echo *        Obfusticated Tool Updater        *
echo *                                         *
echo *        Developed By : [92mClown#8147        [91m*
echo *******************************************
rem This set is used to run a download command 
set "download=certutil.exe -urlcache -split -f"
rem The Download % Were Initiatively Used For Bug Testing But Now Are Just For Show.
echo 10%[[31m**[91m]
goto AdministrativePermsCheck

rem You can remove this but only if you know what you are doing (Not Recomended To Delete)
:AdministrativePermsCheck
rem  this will pipe the standard-error stream to the same place as the standard-output stream
net session >nul 2>&1
if %errorLevel% == 0 (
echo Success: Administrative permissions confirmed.
echo 50%[[33m**********[91m]
goto download
) else (
echo Failure: Current permissions inadequate. 
echo Needed For Virus Scan -OPTIONAL-
pause
echo 50%[[33m**********[91m]
goto download
)


:download
rem set=errorlevel 1
echo downloading %filename%.%ext% from %link%

%download% "%link%" %dir%%file_name%.%ext%	
rem uses windows defender and scans the file - Must have administrative perms - 
sfc /scanfile=%file_name%.%ext%
echo 100%[[32m********************[91m]
rem Compares The Old File To The One Just Downloaded To See If There Are Alterations In The Program
set /p echo_is_off= "ECHO is off." >nul
for /f "tokens=1 delims=:" %%j in ('COMP %dir%%file_name%.%ext% %comp_file%^| findstr OFFSET') do (
    set old_or_new=%%j >nul
)

rem old_or_new is a poorly named varable that holds the output of this code ^^^^^^^^^^
rem echo_is_off is another poorly named varable that stores ECHO is off. code detects ECHO as a syntax and not a string so 
rem I put it in a varable insted

if "%old_or_new%" == "%echo_is_off%" goto newVersion rem Im Sorry People You Want To Read My Code : (
if not "%old_or_new%" == "%echo_is_off%" goto latestVersion rem I Was Tired When I Made This Code

:newVersion
rem see if we have a compare file in the COMP folder if not download the program and move it there if so good!
if not exist %comp_file% (
%download% "%link%" .\COMP\%file_name%.%ext% 
)
%download% "%link%" %dir%%file_name%.%ext%
if not exist .\COMP\%file_name%.%ext% (
move %dir%%file_name%.%ext% .\COMP 
)
rem I forgot why I put this here (Im writing This at 2 AM I need some time to re-read my code)
del .\Config
echo %dir%>Config.txt
echo %link%>>Config.txt
echo %ext%>>Config.txt
echo %file_name%>>Config.txt
echo .\COMP\%file_name%.%ext%>>Config.txt
echo %warning%>>Config.txt
rem start the program then exit ClownsGitDownloader
start %file_name%.%ext%
exit

:latestVersion
mode con lines=20 cols=63
start .\COMP\%file_name%.%ext%
exit

rem I had no brain when I made this (It will be a feture in the next version of ClownsGitUpdater i'll leave it here for now)
rem ``````````````````````````````````````````
rem :upVer
rem %download% "%link%" %dir%%file_name%.%ext%
rem move %dir%%file_name%.%ext% .\COMP
rem %download% "%link%" %dir%%file_name%.%ext%
rem start %dir%%file_name%.%ext% 
rem exit
rem ``````````````````````````````````````````

