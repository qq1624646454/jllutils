#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.AndroidStudio.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-23 14:08:54
#   ModifiedTime: 2017-07-07 09:26:29

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF


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

