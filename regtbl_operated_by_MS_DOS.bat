@ECHO OFF

REM Ensure run as Administrator
REM >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM IF '%errorlevel%' NEQ '0' (GOTO UACPrompt) ELSE ( GOTO gotAdmin )

REM :UACPrompt
REM    IF NOT EXIST "%temp%\getadmin.vbs" (
REM        ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
REM        ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
REM    )
REM    "%temp%\getadmin.vbs"
REM EXIT /B
REM :gotAdmin
REM IF EXIST "%temp%\getadmin.vbs" ( DEL "%temp%\getadmin.vbs" )

IF "x%1" == "xsilence" (GOTO __WORKING)

ECHO.
ECHO.***************************************************************************
ECHO.  Initializing the Environment Variables For cmake,mingw32-make,toolchain
ECHO.***************************************************************************

SET __RTE=%~dp0EnvForRD\GCC\WindowsOS\CMake\bin
REM ;%~dp0EnvForRD\GCC\WindowsOS\MinGW\bin

SET __REGTBL_ITEM="HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment"

REM retrieve the value of registe table item
FOR,/F,"skip=2 tokens=1,2,* delims= ",%%a,IN,('REG QUERY %__REGTBL_ITEM% /v Path'),DO,(
    IF "x%%a" == "xPath" (
        IF "x%%b" == "xREG_EXPAND_SZ" (
            IF "x%__SEV%" == "x" (
                SET __SEV=%%c
            ) ELSE (
                SET __SEV=%%c;%__SEV%
            )
        )
    )
)

ECHO.
ECHO.**1[Retrieve] SystemEnvironmentVaribles (SEV)
ECHO.%__SEV%
ECHO.
ECHO.***[Retrieve] RunTimeEnvironment (RTE)
ECHO.%__RTE%
ECHO.

PAUSE

SET /a i=1
:__For_Loop_1
FOR /F "tokens=%i%,* delims=;" %%a IN ("%__SEV%") DO (
    IF x"%__RTE%" == x"%%a" (
        ECHO.**@[Traveral Item In SEV] %%a
        ECHO.***[Nothing To DO] RTE have been already existed!!!
        ECHO.
        GOTO __For_Loop_1_END
    )
    ECHO.***[Traveral Item In SEV] %%a
    SET /a i+=1
    GOTO __For_Loop_1
)
ECHO.
:__SET_RTE_IN_SEV

    IF "%cd%" == "C:\Windows\system32" (
        ECHO.***[Fortunately] Running this as Administrator
    ) ELSE (
        ECHO.***[Sorry] Please run it as Administrator
	    PAUSE >nul
	    EXIT 0
    )

    ECHO.***[Try My Best]RTE is being installed to SEV
    ECHO.
    REG ADD %__REGTBL_ITEM% /v Path /t REG_EXPAND_SZ /d "%__RTE%;%__SEV%%__RTE%;%__SEV%" /f
REM SETX "Path" "%__RTE%;%__SEV%" /m 

    FOR,/F,"skip=2 tokens=1,2,* delims= ",%%a,IN,('REG QUERY %__REGTBL_ITEM% /v Path'),DO,(
        IF "x%%a" == "xPath" (
            IF "x%%b" == "xREG_EXPAND_SZ" (
                IF "x%__SEV_%" == "x" (
                    SET __SEV_=%%c
                ) else (
                    SET __SEV_=%%c;%__SEV_%
                )
            )
        )
    )
    ECHO.**2[Retrieve] SystemEnvironmentVaribles (SEV)
    ECHO.%__SEV_%
    ECHO.
    IF "x%__SEV_%" == "x%__SEV%" (
        ECHO.***[Sorry] RunTimeEnvironment is not installed succussfully.
		ECHO.
		PAUSE >nul
        EXIT 0
    )
    SET PATH=%__RTE%;%__SEV%
    START %~f0 silence
    PAUSE >nul
	EXIT 0
:__For_Loop_1_END
ECHO.

:__WORKING
ECHO PATH=%PATH%
cmake

PAUSE

:__UNSET_RTE_IN_SEV
    REM REG ADD %__REGTBL_ITEM% /v Path /t REG_EXPAND_SZ /d "%__SEV%" /f

EXIT 0

SET CMAKE="cmake.exe"
SET TOOLCHAIN_PREFIX="%cd%\EnvForRD\GCC\WindowsOS\7 2017-q4-major" 
SET MAKE="%cd%\EnvForRD\GCC\WindowsOS\MinGW\bin\mingw32-make"


ECHO.
ECHO. ==========================================================================
ECHO.   COPYRIGHT(C) 2018-2100.  jielong.lin@qq.com.       All Rights Reserved. 
ECHO.   COPYRIGHT(C) 2018-2100.  linjielong@reachxm.com.   All Rights Reserved. 
ECHO.      Revision:  2018-05-03-18
ECHO.   PATH=%PATH% 
ECHO.   cd=%cd%
ECHO.   ~f0=%~f0%
ECHO.   ~dp0=%~dp0%
ECHO. ==========================================================================
ECHO.
REM ECHO     Modify the "cmake/toolchain-arm-none-eabi.cmake"
REM ECHO.
REM ECHO -------------------------------------------------------------------------
REM ECHO.
REM ECHO     elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Windows)
REM ECHO         #message(STATUS "Please specify the TOOLCHAIN_PREFIX !\n For example: -DTOOLCHAIN_PREFIX=\"C:/Program Files/GNU Tools ARM Embedded\" ")
REM ECHO        set(TOOLCHAIN_PREFIX "C:/Program Files (x86)/GNU Tools ARM Embedded/7 2017-q4-major")"
REM ECHO.
REM ECHO -------------------------------------------------------------------------

IF EXIST %cd%\OUT (rmdir /S /Q OUT)

IF "%1" == "" ( pause ) 

ECHO.
ECHO.
ECHO.
ECHO.

mkdir OUT
cd OUT

%CMAKE% -DCMAKE_TOOLCHAIN_FILE="cmake/toolchain-arm-none-eabi.cmake" ^
      -DTOOLCHAIN_PREFIX="%TOOLCHAIN_PREFIX%" ^
      -DAPPLICATION="LoRaMac"  ^
      -DCLASS="classA" ^
      -DACTIVE_REGION="LORAMAC_REGION_EU433" ^
      -DBOARD="LND433C" ^
      -G"MinGW Makefiles" ^
      -DCMAKE_BUILD_TYPE=debug ^
      ..

%MAKE% -j4 2> build_log.txt 

REM "C:\Program Files (x86)\GNU Tools ARM Embedded\7 2017-q4-major\bin\arm-none-eabi-objcopy.exe"  debug\hello_world.elf  debug\hello_world.hex -Oihex

IF "%1" == "" ( pause )

 
