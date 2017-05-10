::Copyright(c) 2016-2100.    jielong.lin    All rights reserved.
::

::
:::::::: How to Get the all Resources from APK :::::::
::apktool.bat  d  -f  [apkFile ]  [OutFolder]
::
::eg.
::  apktool.bat d -f  test.apk  test    
::
::
:::::::: How to Get the source code from APK  ::::::::
::1. Rename the .apk suffix to .zip or .rar to decompress for retrieving classes.dex
::2. put classes.dex into dex2jar-x.x.x.x folder
::3. enter dex2jar-x.x.x.x folder and then type the following command:
::         dex2jar.bat  classes.dex
::     after the above step, you will get the classes_dex2jar.jar
::4. run jd-gui.exe to open classes_dex2jar
::

@MODE CON COLS=104 LINES=38
@COLOR 0A
@ECHO OFF
@TITLE ==== jielong.lin: *.apk IS DECOMPILED TO *.java =====
@ECHO.
@ECHO *************** .apk is decompiled to .java *****************
@ECHO Copyright(c) 2016-2100.  jielong.lin    All rights reserved.
:FLAG_SelectAPK
@ECHO.
@SET /p GvAPK= JLL: Specify/Drag APK FILE = 
@ECHO.
@IF "%GvAPK:~-3%"=="apk" (
    @IF exist "%GvAPK%" (
        @ECHO JLL: Check Successfully for valid APK file
        @ECHO.
    ) ELSE (
        @GOTO FLAG_SelectAPK
	)
) ELSE (
    @ECHO JLL: Check Failure for invalid APK file
    @GOTO FLAG_SelectAPK
)

for /f %%a in ("%GvAPK%") do (
    set GvAPKPath=%%~dpa
	set GvAPKFile=%%~na
)
@ECHO\ PATH=%GvAPKPath%
@ECHO\ FILENAME=%GvAPKFile%
@ECHO.
::COPY <Source>  <Target>
@COPY  %GvAPK% %GvAPKPath%\%GvAPKFile%.zip /y
@ECHO.
@IF exist "C:\Program Files\7-Zip\7z.exe" (
    "C:\Program Files\7-Zip\7z.exe" e -y -tzip "%GvAPKPath%\%GvAPKFile%.zip" -o"%GvAPKPath%\template_%GvAPKFile%"
	@IF exist "%GvAPKPath%\template_%GvAPKFile%\classes.dex" (
        @ECHO  JLL: Retrieve classes.dex From "%GvAPKPath%\template_%GvAPKFile%"
	    @COPY  "%GvAPKPath%\template_%GvAPKFile%\classes.dex"  "%GvAPKPath%\classes.dex" /y
		@ECHO.
        @DEL /F /S /Q "%GvAPKPath%\%GvAPKFile%.zip"
        @GOTO FLAG_dex2jar_WithCleanup
    ) ELSE  (
        @ECHO  JLL: Sorry, Don't Retrieve classes.dex
    )
) ELSE (
    @ECHO\ Please decompress %GvAPKFile%.zip by yourself
)
@PAUSE
@EXIT 0

:FLAG_dex2jar
@IF exist "%CD%%\dex2jar-0.0.9.15\dex2jar.bat" (
    "%CD%\dex2jar-0.0.9.15\dex2jar.bat" "%GvAPKPath%\classes.dex"
    @DEL /F /S /Q  "%GvAPKPath%\classes.dex"
    @IF exist "%GvAPKPath%\classes_dex2jar.jar" (
        @ECHO  JLL: Success to retrieve %GvAPKPath%\classes_dex2jar.jar
        @IF exist "%CD%\jd-gui-0.3.5.windows\jd-gui.exe" (
            "%CD%\jd-gui-0.3.5.windows\jd-gui.exe" "%GvAPKPath%\classes_dex2jar.jar"
        )
        @DEL /F /S /Q  "%GvAPKPath%\classes_dex2jar.jar"
        @EXIT 0
    ) ELSE (
        @ECHO  JLL: Exit Due to Fail to retrieve %GvAPKPath%\classes_dex2jar.jar
    )
) ELSE (
    @ECHO  JLL: Sorry, Exit Due to lack of "%CD%\dex2jar-0.0.9.15\dex2jar.bat"
)
@PAUSE
@EXIT 0

:FLAG_dex2jar_WithCleanup
::@SET /p GvChoice=JLL: Cleanup "%GvAPKPath%\template_%GvAPKFile%" if press [y]
@SET GvChoice=y
@IF "%GvChoice%"=="y" (
    @RD /S /Q %GvAPKPath%\template_%GvAPKFile%
)
@GOTO FLAG_dex2jar