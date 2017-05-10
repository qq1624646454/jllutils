

How to Retrieve the java code files from APK ?

JLL: Now it is so easy by run jll.apk2java.bat and drag the apk file to the dos windows.















============================================================================================
1. How to Get the all Resources from APK
apktool.bat  d  -f  [apkFile ]  [OutFolder]

eg.
  apktool.bat d -f  test.apk  test    


2. How to Get the source code from APK
2.1. Rename the .apk suffix to .zip or .rar to decompress for retrieving classes.dex
2.2. put classes.dex into dex2jar-x.x.x.x folder
2.3. enter dex2jar-x.x.x.x folder and then type the following command:
         dex2jar.bat  classes.dex
     after the above step, you will get the classes_dex2jar.jar
2.4. run jd-gui.exe to open classes_dex2jar
