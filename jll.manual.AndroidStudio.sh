#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.AndroidStudio.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-23 14:08:54
#   ModifiedTime: 2017-07-19 00:43:05

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
8  ${Fgreen}# JLL.S20170718: bind to one X server for renderring${AC}
9  ${Fgreen}DISPLAY=192.168.1.11:0.0${AC}
10 ${Fgreen}# JLL.E20170718: bind to one X server for renderring${AC}
11
12 ${Fgreen}# JLL.S20170718: Customize to start AVD before AndroidStudio ${AC}
13 ${Fgreen}ls ~/.android/avd | awk -F'.ini' '{print \$1}' | awk -F'.avd' '{print \$1}' | uniq${AC}
14 ${Fgreen}read -p "Please Type above AVD_name=" _as_AVD_name${AC}
15 ${Fgreen}[ x"\${_as_AVD_name}" != x ] \\${AC}
16 ${Fgreen}    && ~/dl.google.com/android/repository/emulator/emulator \\${AC}
17 ${Fgreen}           -avd "\${_as_AVD_name}" -gpu swiftshader & ${AC}
18 ${Fgreen}# JLL.E20170718: Customize to start AVD before AndroidStudio${AC}

./bin/studio.sh

${Fyellow}第一次运行需要进行很多配置,包含下载和安装SDK等等，建议保证网络通畅，时间上会比较久.${AC}
${Fyellow}为了让AndroidStudio可以在任何路径下运行，建议将studio.sh所在路径写入到环境变量PATH中.${AC}
${Fyellow}下次运行studio.sh即可以启动AndroidStudio${AC}
${Fyellow}第一次编译工程时，AS可能还需要去下载gradle包进行安装${AC}

${Fgreen}cat >>~/.bashrc<<SEOF${AC}

${Fgreen}# JLL.S20170719: custom for android studio${AC}
${Fgreen}alias as_emulator=" \\${AC}
${Fgreen}ls ~/.android/avd |awk -F'.ini' '{print \\\$1}' |awk -F'.avd' '{print \\\$1}' |uniq;${AC}
${Fgreen}[ x\"\\\${DISPLAY}\" = x ] && DISPLAY=192.168.1.11:0.0
${Fgreen}read -p \"please type AVD=\" AVD_name;${AC}
${Fgreen}[ x\"\\\${AVD_name}\" != x ] \\${AC}
${Fgreen}&& ~/dl.google.com/android/repository/emulator/emulator \\${AC}
${Fgreen}   -avd \"\\\${AVD_name}\" -gpu swiftshader"${AC}

${Fgreen}PATH=~/dl.google.com/dl/android/studio/ide-zips/2.3.3.0/android-studio/bin/:\${PATH}${AC}
${Fgreen}# JLL.S20170719: custom for android studio${AC}

SEOF



${Bred}${Black}                                     ${AC}
${Bred}  ${AC} AndroidStudio运行时错误
${Bred}  ${AC} ${Fred}Looking in classpath from com.intellij.util.lang.UrlClassLoader@6d5380c2${AC}
${Bred}  ${AC} ${Fred}for libnotify.so.4${AC} After Install Android Studio 2.3.3 in Ubuntu 12.04 
${Bred}  ${AC} 64bit. 
${Bred}${Black}                                     ${AC}
sudo apt-get install libnotify-dev
























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

