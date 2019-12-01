    @echo off
    echo.
    echo.
    echo.
    set regpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
    echo.
    echo 请输入 java_home_path的路径 ,比如 C:\Program Files\Java\jdk1.8.0_121
    set /P java_home_path=
    echo.
    echo ************************************************************  
    echo *                                                          *  
    echo *                   JDK 系统环境变量设置                   *
    echo *                         <jielong.lin>                    *  
    echo *                                                          *  
    echo ************************************************************  
    echo.
    echo  准备设置环境变量: JAVA_HOME=%java_home_path%
    echo  注意: 如果JAVA_HOME存在,会被覆盖,此操作不可逆的,请仔细检查确认
    echo.
    echo  准备设置环境变量(最前面有个.): 
    echo       CLASSPATH=.;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%\lib\dt.jar  
    echo  注意: 如果CLASSPATH存在,会被覆盖,此操作不可逆的,请仔细检查确认  
    echo.
    echo  准备设置环境变量: PATH=%%JAVA_HOME%%\bin  
    echo  注意: Java环境变量会追加在PATH的最前面
    echo.
    set /P EN=请确认后按 回车键 开始设置!.........
    echo.
    echo.
    echo.
    echo.
    echo  创建环境变量
    echo      JAVA_HOME=%java_home_path% 
    setx  JAVA_HOME "%java_home_path%" -m
    echo.  
    echo.  
    echo  创建环境变量
    echo      CLASSPATH=.;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar
    setx  CLASSPATH ".;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar" -m  
    echo.  
    echo.  
    echo  追加环境变量(追加到最前面) PATH=%%JAVA_HOME%%\bin  
    for /f "tokens=1,* delims=:" %%a in ('reg QUERY "%regpath%" /v "PATH"') do (
        set "L=%%a"
        set "P=%%b"
    )
    set "Y=%L:~-1%:%P%"
      
    setx PATH "%%JAVA_HOME%%\bin;%Y%" -m  
    echo.  
    echo.
    echo jdk和jre环境变量设置完成
    echo.
    echo 测试下看看
    echo.
    call java.exe -version
    echo.
    if %errorlevel% == 0 (
        echo.
        call javac.exe -version
        echo.
        if %errorlevel% == 0 (
            echo 祝贺您...Java SE Development Kit...测试一切正常!!!
            echo.
            goto END
        )
    )
    echo 很不幸...Java SE Development Kit...测试出现问题!!!
    echo.
    goto END
 
:END
    echo === 请按任意键退出!   
    pause>nul