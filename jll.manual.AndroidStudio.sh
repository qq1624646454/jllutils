#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.AndroidStudio.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-23 14:08:54
#   ModifiedTime: 2017-09-28 15:11:12

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bred}${Black}                                     ${AC}
${Bred}  ${AC} Install Android Studio 2.3.3 in Ubuntu 12.04 64bit. 
${Bred}${Black}                                     ${AC}
wget \\
  https://dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio-ide-162.4069837-linux.zip
unzip android-studio-ide-162.4069837-linux.zip -d ./
cd android-studio/

#vim Install-Linux-tar.txt

vim ./bin/studio.sh
# insert the follows from line 8 to 18
${Fgreen}# JLL.S20170718: bind to one X server for renderring${AC}
${Fgreen}DISPLAY=192.168.1.11:0.0${AC}
${Fgreen}# JLL.E20170718: bind to one X server for renderring${AC}

${Fgreen}# JLL.S20170718: Customize to start AVD before AndroidStudio ${AC}
${Fgreen}ls ~/.android/avd | awk -F'.ini' '{print \$1}' | awk -F'.avd' '{print \$1}' | uniq${AC}
${Fgreen}read -p "Please Type above AVD_name=" _as_AVD_name${AC}
${Fgreen}[ x"\${_as_AVD_name}" != x ] \\${AC}
${Fgreen}&& ~/dl.google.com/android_sdk/emulator/emulator \\${AC}
${Fgreen}   -avd "\${_as_AVD_name}" -gpu swiftshader & ${AC}
${Fgreen}# JLL.E20170718: Customize to start AVD before AndroidStudio${AC}

# insert the follows from line 200 to 206
${Fgreen}# JLL.S20170718: Customize to start AVD before AS${AC}
${Fgreen}__is_Alive=\$(ps -e | awk -F' ' '{print \$1}' | grep "\${__AVD_PID}" 2>/dev/null)${AC}
${Fgreen}if [ x"\${__is_Alive}" != x ]; then${AC}
${Fgreen}   echo "JLL: AVD should be killed. AVD_PID=\${__AVD_PID}"${AC}
${Fgreen}   kill -9 \${__AVD_PID}${AC}
${Fgreen}fi${AC}
${Fgreen}# JLL.E20170718: Customize to start AVD before AS${AC}


studio_hw.sh
===============================
  8 # JLL.S20170718: Customize to start AVD before AS
  9 ls ~/.android/avd | awk -F'.ini' '{print \$1}' | awk -F'.avd' '{print \$1}' | uniq
 10 #read -p "Please Type above AVD_name=" _as_AVD_name
 11 _as_AVD_name="Android_TV_720p_API_23"
 12 [ x"\${_as_AVD_name}" != x ] && ~/dl.google.com/android/repository/emulator/emulator \
 13 -avd "\${_as_AVD_name}" -gpu host &
 14 __AVD_PID=\$!
 15 # JLL.E20170718: Customize to start AVD before AS
...
201 # JLL.S20170718: Customize to start AVD before AS
202 __is_Alive=\$(ps -e | awk -F' ' '{print \$1}' | grep "\${__AVD_PID}" 2>/dev/null)
203 if [ x"\${__is_Alive}" != x ]; then
204     echo "JLL: AVD should be killed. AVD_PID=\${__AVD_PID}"
205     kill -9 \${__AVD_PID}
206 fi
207 # JLL.E20170718: Customize to start AVD before AS






./bin/studio.sh

${Fyellow}第一次运行需要进行很多配置,包含下载和安装SDK等等，建议保证网络通畅，时间上会比较久.${AC}
${Fyellow}为了让AndroidStudio可以在任何路径下运行，建议将studio.sh所在路径写入到环境变量PATH中.${AC}
${Fyellow}下次运行studio.sh即可以启动AndroidStudio${AC}
${Fyellow}第一次编译工程时，AS可能还需要去下载gradle包进行安装${AC}

# append the follows into the tail of ~/.bashrc
vim ~/.bashrc

${Fgreen}# JLL.S20170719: custom for android studio${AC}
${Fgreen}alias as_emulator=" \\${AC}
${Fgreen}ls ~/.android/avd |awk -F'.ini' '{print \\\$1}' |awk -F'.avd' '{print \\\$1}' |uniq;${AC}
${Fgreen}[ x\"\\\${DISPLAY}\" = x ] && export DISPLAY=192.168.1.11:0.0 ${AC}
${Fgreen}read -p \"AVD will be renderred by \\\${DISPLAY}; Please Type AVD=\" AVD_name;${AC}
${Fgreen}[ x\"\\\${AVD_name}\" != x ] \\${AC}
${Fgreen}&& ~/dl.google.com/android_sdk/emulator/emulator \\${AC}
${Fgreen}   -avd \"\\\${AVD_name}\" -gpu swiftshader"${AC}

${Fgreen}PATH=\\${AC}
${Fgreen}~/dl.google.com/android/repository/platform-tools:\\${AC} 
${Fgreen}~/dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio/bin/:\${PATH}${AC}
${Fgreen}# JLL.S20170719: custom for android studio${AC}



${Bred}${Black}                                     ${AC}
${Bred}  ${AC} AndroidStudio运行时错误
${Bred}  ${AC} ${Fred}Looking in classpath from com.intellij.util.lang.UrlClassLoader@6d5380c2${AC}
${Bred}  ${AC} ${Fred}for libnotify.so.4${AC} After Install Android Studio 2.3.3 in Ubuntu 12.04 
${Bred}  ${AC} 64bit. 
${Bred}${Black}                                     ${AC}
sudo apt-get install libnotify-dev





${Bred}${Black}                                     ${AC}
${Bred}  ${AC} AndroidStudio 2.3 使用Android-26时出现没有源代码的情况
${Bred}  ${AC} ${Fred}Source for 'Android API 26 Platform' not found.${AC}
${Bred}${Black}                                     ${AC}
At present the Android-26 SDK don't provide the source code for Android Studio,
So using Android-25 SDK source code to solve this issue, the details as follows:
(1).copy a android-25 as android-26:
jll@S:~$ ${Fgreen}cd ~/dl.google.com/android/repository/sources${AC}
jll@S:~/dl.google.com/android/repository/sources$ ${Fgreen}cp -rvf android-25 android-26 ${AC}
(2).modify the version to 26:
jll@S:~/dl.google.com/android/repository/sources$ ${Fgreen}cd android-26 ${AC}
jll@S:~/dl.google.com/android/repository/sources/android-26$ ${Fgreen}vim package.xml${AC}
...
<localPackage path="sources;android-${Fgreen}26${AC}" ... <api-level>${Fgreen}26${AC}</api-level>
...<display-name>Sources for Android ${Fgreen}26${AC}</display-name>
...
jll@S:~/dl.google.com/android/repository/sources/android-26$ ${Fgreen}vim source.properties${AC}
...
AndroidVersion.ApiLevel=${Fgreen}26${AC}
...
(3).reboot the Android Studio 2.3


${Bred}${Black}                                     ${AC}
${Bred}  ${AC} 定制任意路径下的Android模拟器运行环境
${Bred}  ${AC} 注意:在Vcxsrv环境中，似乎还无法支持硬件加速的GLE，因此，请设置-gpu swiftshader
${Bred}${Black}                                     ${AC}
${Fyellow}将以下脚本写入~/.bashrc，并重新登录即可${AC}
${Fgreen}alias as_emulator=" \\${AC}
${Fgreen}ls ~/.android/avd |awk -F'.ini' '{print \\\$1}' |awk -F'.avd' '{print \\\$1}' |uniq;${AC}
${Fgreen}read -p \"please type AVD=\" AVD_name;${AC}
${Fgreen}[ x\"\\\${AVD_name}\" != x ] \\${AC}
${Fgreen}&& ~/dl.google.com/android/repository/emulator/emulator \\${AC}
${Fgreen}-avd \"\\\${AVD_name}\" -gpu swiftshader"${AC}


${Bred}${Black}                                     ${AC}
${Bred}  ${AC} AVD(Android Virtual Device) in Ubuntu 12.04 64bit. 
${Bred}  ${AC} 模拟器界面弹出后，又立刻闪退. 
${Bred}${Black}                                     ${AC}
${Fyellow}使用命令行(启动命令在Android SDK目录下)启动AVD，可以看到详细的错误信息${AC}
jielong.lin@TpvServer:~$ \
${Fseablue}~/dl.google.com/android/repository/emulator/emulator -avd Android_TV_720p_API_23${AC}
emulator: WARNING: encryption is off
android/android-emugl/host/libs/Translator/GLES_V2/GLESv2Imp.cpp:glShaderSource:2452 error 0x501
...
android/android-emugl/host/libs/Translator/GLES_V2/GLESv2Imp.cpp:glGetProgramiv:1747 error 0x501
X Error of failed request:  GLXBadContextTag
  Major opcode of failed request:  150 (GLX)
  Minor opcode of failed request:  1 (X_GLXRender)
  Serial number of failed request:  244
  Current serial number in output stream:  246
QObject::~QObject: Timers cannot be stopped from another thread
Segmentation fault (core dumped)
...
${Fyellow}ANALYZE: 这是因为AVD默认使用GLES访问硬件加速的本地显卡,以此实现更快的图形渲染.${AC}
${Fyellow}         但是，基于Xserver的VcXsrv环境下，似乎并不支持。${AC}
${Fyellow}         所以需要改成软件模拟显卡的模式: -gpu swiftshader${AC}
${Fgreen}SOLUTION: ${AC}
jielong.lin@TpvServer:~$ \
${Fseablue}~/dl.google.com/android/repository/emulator/emulator -avd Android_TV_720p_API_23${AC} \
${Fseablue}-gpu swiftshader${AC}
注：-gpu <mode>，mode可以有auto host mesa angle swiftshader off，具体详见：
    https://developer.android.com/studio/run/emulator-acceleration.html
${Bgreen}${Fblack}建议：${AC}
${Bgreen}${Fblack} \
将-gpu <mode> 定制到alias as_emulator当中，每次启动AS之前，先启动它.                ${AC}
${Bgreen}${Fblack} \
vim ~/dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio/bin/studio.sh ${AC}
 3 # ---------------------------------------------------------------------
 4 # Android Studio startup script.
 5 # ---------------------------------------------------------------------
 6 #
 7
${Fgreen}# JLL.S20170718: Customize to start AVD before AS ${AC}
${Fgreen}ls ~/.android/avd | awk -F'.ini' '{print \$1}' | awk -F'.avd' '{print \$1}' | uniq${AC}
${Fgreen}read -p "Please Type above AVD_name=" _as_AVD_name${AC}
${Fgreen}[ x"\${_as_AVD_name}" != x ] ${AC}\
${Fgreen}&& ~/dl.google.com/android/repository/emulator/emulator \\${AC}
${Fgreen}-avd "\${_as_AVD_name}" -gpu swiftshader & ${AC}
${Fgreen}# JLL.E20170718: Customize to start AVD before AS${AC}
14
15 message()
16 {
17   TITLE="Cannot start Android Studio"


${Bred}${Black}                                     ${AC}
${Bred}  ${AC}  AVD运行时错误
${Bred}  ${AC} ${Fred}A solution for pulseaudio: pa_context_connect() failed with QEMU${AC}
${Bred}${Black}                                     ${AC}
sudo aptitude install pulseaudio






${Bred}${Black}                                     ${AC}
${Bred}  ${AC} AVD(Android Virtual Device) in Ubuntu 12.04 64bit. 
${Bred}  ${AC} /dev/kvm 未授权给普通用户访问
${Bred}${Black}                                     ${AC}
sudo chmod 0777 /dev/kvm
${Fyellow}每次开机后，都需要作一次这样的操作，所以建议将其定制到/etc/rc.local${AC}
sudo vim /etc/rc.local
/bin/chmod 0777 /dev/kvm








${Bred}${Black}                                     ${AC}
${Bred}  ${AC} Could not reserve enough space for object heap
${Bred}${Black}                                     ${AC}


${Bgreen}${Fwhite}Here is how to fix it:${AC}

Go to Start->Control Panel->System->Advanced(tab)->Environment Variables->System
Variables->New: Variable name: _JAVA_OPTIONS
Variable value: -Xmx512M
Variable name: Path
Variable value: %PATH%;C:\Program Files\Java\jre6\bin;F:\JDK\bin;
Change this to your appropriate path.






${Bred}${Black}                                     ${AC}
${Bred}  ${AC} How to kill the tadb.exe in Windows. 
${Bred}${Black}                                     ${AC}
在windows命令行窗口下执行： 
1.查看所有的端口占用情况
${Fyellow}C:\\>netstat -ano${AC}
  协议    本地地址        外部地址    状态         PID
  TCP    127.0.0.1:${Fyellow}8700${AC}   0.0.0.0:0   LISTENING    3236

2.查看指定端口的占用情况
${Fyellow}C:\\>netstat -aon|findstr "8700" ${AC}
  协议    本地地址        外部地址    状态         PID
  TCP    127.0.0.1:8700   0.0.0.0:0   LISTENING    ${Fyellow}2014${AC}

3.查看PID对应的进程
${Fyellow}C:\\>tasklist|findstr "2014" ${AC}
 映像名称                  PID      会话名           会话#  内存使用
 ========================= ======== ================
 tadb.exe                  2014     Console          0      16,064 K

4.结束该进程
${Fyellow}C:\\>taskkill /f /t /im tadb.exe ${AC}


EOF

