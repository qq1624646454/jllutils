#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.bat_ping.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-08 16:01:43
#   ModifiedTime: 2019-12-23 13:33:41

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

FG=${Fgreen}

more >&1<<EOF

${FG}Run Microsoft DOS ${AC}

@ECHO OFF
@ECHO.
@ECHO Copyrights(C) 2019-2100.   jielong.lin@qq.com   All rights reserved.
@ECHO.

>nul 2>&1 "%SYSTEMROOT%\\system32\\cacls.exe" "%SYSTEMROOT%\\system32\\config\\system"

if '%errorlevel%' NEQ '0' (
    echo Request Administrator Privilege...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\\getadmin.vbs"
    "%temp%\\getadmin.vbs"
    exit /B
:gotAdmin

REM Disable sleep feature
powercfg -h off

set /a _i=0
set /a _j=1
set /a _intInterval=60
set /a _intTimeout=1

set /a _nr=0
set /a _intStatus=88

set _pathToLog=E:


@ECHO. > %_pathToLog%\\netchk_by_JLLim.log
@ECHO Copyrights(C) 2019-2100.   jielong.lin@qq.com   All rights reserved. >> %_pathToLog%\\netchk_by_JLLim.log

@ECHO. %data% %time% >> %_pathToLog%\\netchk_by_JLLim.log
@ECHO. >> %_pathToLog%\\netchk_by_JLLim.log

netsh interface set interface name="本地连接" admin=ENABLED

:__LOOP_FOREVER

REM    TIMEOUT /T 1 /NOBREAK >nul
    ECHO.
    TIMEOUT /T %_intTimeout% /NOBREAK
    ECHO.
    ping www.baidu.com -n 1 -w 1000
    ECHO.
    ECHO.*********************************************************************
    set /a _intResult=%errorlevel%
    if %_intResult% equ 0 (
        ECHO.  %_nr%[ONLINE] www.baidu.com, check frequence is %_intTimeout%
    ) else (
        ECHO.  %_nr%[OFFLINE] www.baidu.com, check frequence is %_intTimeout%
    )
    ECHO.*********************************************************************
    ECHO.
    set /a _nr=_nr+1
    
    IF %_intResult% neq %_intStatus% (
        ECHO. CHK: %_intStatus%  %_intResult%
        if %_intResult% equ 0 (
            REM ECHO. >> %_pathToLog%/netchk_by_JLLim.log
            ECHO."******** %_nr%( %date% %time% ) OnLine ********">> %_pathToLog%\\netchk_by_JLLim.log
            REM ipconfig >> %_pathToLog%\\netchk_by_JLLim.log
            REM ECHO. >> %_pathToLog%\\netchk_by_JLLim.log
        ) else (
            REM ECHO. >> %_pathToLog%/netchk_by_JLLim.log
            ECHO."******** %_nr%( %date% %time% ) OffLine ********">> %_pathToLog%\\netchk_by_JLLim.log
            REM ipconfig >> %_pathToLog%\\netchk_by_JLLim.log
            REM ECHO. >> %_pathToLog%\\netchk_by_JLLim.log    
        )
        set /a _intStatus = _intResult
    )

    set /a _i = _i + 1

    IF %_i% equ 60 (
        set /a _i = 0
        set /a _j = _j + 1
    )

    IF %_j% equ %_intInterval% (
        set /a _j = 0
        ECHO.###### 本地连接 will be disabled then enabled ######## >> %_pathToLog%\\netchk_by_JLLim.log
        echo.###### 本地连接 will be disabled ########
        netsh interface set interface name="本地连接" admin=DISABLED
        TIMEOUT /T 10 /NOBREAK
        echo.###### 本地连接 will be enabled ########
        netsh interface set interface name="本地连接" admin=ENABLED
    )

    IF %_i% equ 0 (
        set /a _intTimeout = _intTimeout + _j
    )
    GOTO __LOOP_FOREVER



------------------------------------------------------------
REM wait for 1s
TIMEOUT /T 1 /NOBREAK >nul

REM check ping result, success if 0 or failure
echo %errorlevel%




@echo off


EOF

