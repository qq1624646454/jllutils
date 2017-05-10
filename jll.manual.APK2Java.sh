#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.APK2Java.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-01-18 10:27:51
#   ModifiedTime: 2017-01-18 10:36:12

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

Notice: This tool is only used on windows system (such as windows 7)

1.Please download the tool named "Jll.APK.to.JAVA" into the place on the windows system:
   Tool Link Address:   ${JLLPATH}/PhilipsTVUtils/Jll.APK.to.JAVA
2.Enter into Jll.APK.to.JAVA and copy your APK file to Jll.APK.to.JAVA
3.Double click to run jll.apk2java.bat and type  YOUR APK Name without its path.
4.Waiting for a while, and the source code will be generated on Java Decompiler Application.
5.Save this generated java code by Java Decompiler Application.

EOF

