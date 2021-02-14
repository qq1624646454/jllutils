    @echo off
    echo.
    echo.
    echo.
    set regpath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
    echo.
    echo ������ java_home_path��·�� ,���� C:\Program Files\Java\jdk1.8.0_121
    set /P java_home_path=
    echo.
    echo ************************************************************  
    echo *                                                          *  
    echo *                   JDK ϵͳ������������                   *
    echo *                         <jielong.lin>                    *  
    echo *                                                          *  
    echo ************************************************************  
    echo.
    echo  ׼�����û�������: JAVA_HOME=%java_home_path%
    echo  ע��: ���JAVA_HOME����,�ᱻ����,�˲����������,����ϸ���ȷ��
    echo.
    echo  ׼�����û�������(��ǰ���и�.): 
    echo       CLASSPATH=.;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%\lib\dt.jar  
    echo  ע��: ���CLASSPATH����,�ᱻ����,�˲����������,����ϸ���ȷ��  
    echo.
    echo  ׼�����û�������: PATH=%%JAVA_HOME%%\bin  
    echo  ע��: Java����������׷����PATH����ǰ��
    echo.
    set /P EN=��ȷ�Ϻ� �س��� ��ʼ����!.........
    echo.
    echo.
    echo.
    echo.
    echo  ������������
    echo      JAVA_HOME=%java_home_path% 
    setx  JAVA_HOME "%java_home_path%" -m
    echo.  
    echo.  
    echo  ������������
    echo      CLASSPATH=.;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar
    setx  CLASSPATH ".;%%JAVA_HOME%%\lib\tools.jar;%%JAVA_HOME%%%\lib\dt.jar" -m  
    echo.  
    echo.  
    echo  ׷�ӻ�������(׷�ӵ���ǰ��) PATH=%%JAVA_HOME%%\bin  
    for /f "tokens=1,* delims=:" %%a in ('reg QUERY "%regpath%" /v "PATH"') do (
        set "L=%%a"
        set "P=%%b"
    )
    set "Y=%L:~-1%:%P%"
      
    setx PATH "%%JAVA_HOME%%\bin;%Y%" -m  
    echo.  
    echo.
    echo jdk��jre���������������
    echo.
    echo �����¿���
    echo.
    call java.exe -version
    echo.
    if %errorlevel% == 0 (
        echo.
        call javac.exe -version
        echo.
        if %errorlevel% == 0 (
            echo ף����...Java SE Development Kit...����һ������!!!
            echo.
            goto END
        )
    )
    echo �ܲ���...Java SE Development Kit...���Գ�������!!!
    echo.
    goto END
 
:END
    echo === �밴������˳�!   
    pause>nul