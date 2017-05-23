#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.AndroidStudio.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-23 14:08:54
#   ModifiedTime: 2017-05-23 14:11:48

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${AC}${Fpink}
1、Windows平台 
 在windows命令行窗口下执行： 
 1.查看所有的端口占用情况
${Fyellow} 
C:\\>netstat -ano
 
  协议    本地地址                     外部地址               状态                   PID
 
  TCP    127.0.0.1:8700         0.0.0.0:0              LISTENING       3236${Fpink}
 2.查看指定端口的占用情况
${Fyellow} 
C:\\>netstat -aon|findstr "8700"
 
  协议    本地地址                     外部地址               状态                   PID
 
  TCP    127.0.0.1:8700         0.0.0.0:0              LISTENING       2014
${Fpink} 
 3.查看PID对应的进程
${Fyellow} 
C:\\>tasklist|findstr "2014"
 
 映像名称                       PID 会话名              会话#       内存使用
  ========================= ======== ================
   tadb.exe                     2014 Console                 0     16,064 K${Fpink} 
 4.结束该进程
${Fyellow} 
C:\\>taskkill /f /t /im tadb.exe
${AC}


EOF

