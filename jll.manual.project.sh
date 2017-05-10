#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

echo -e "\033[0m\033[31m\033[44m Hello \033[0m"

more >&1 << EOF

全球有名的维修网
https://zh.ifixit.com/Guide
    U=jielong_lin
    P=常用六位数字
    Mail=493164984@qq.com













\033[0m\033[31m\033[44m Hello \033[0m

==============================================================================
CvAccOff="\033[0m"

CvFgBlack="\033[30m"
CvFgRed="\033[31m"
CvFgGreen="\033[32m"
CvFgYellow="\033[33m"
CvFgBlue="\033[34m"
CvFgPink="\033[35m"
CvFgSeaBule="\033[36m"
CvFgWhite="\033[37m"

CvBgBlack="\033[40m"
CvBgRed="\033[41m"
CvBgGreen="\033[42m"
CvBgYellow="\033[43m"
CvBgBlue="\033[44m"
CvBgPink="\033[45m"
CvBgSeaBule="\033[46m"
CvBgWhite="\033[47m"

 echo -e "${CvAccOff}${LvSdceFgColor}${LvSdceBgColor}" \\
         "\b[jll] ${LvSdceCallerFileLineNo},${LvSdceCallerFuncName}${CvAccOff}"


Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello World"


EOF

