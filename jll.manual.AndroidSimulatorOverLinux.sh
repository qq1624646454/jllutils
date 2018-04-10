#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.AndroidSimulatorOverLinux.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-04-10 20:49:36
#   ModifiedTime: 2018-04-10 20:49:36

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

    java -jar ${JLLPATH}/AndroidSimulatorOverLinux/yz_screenmoniter20150128.jar

EOF


