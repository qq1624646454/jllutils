#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.find_nm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-07-26 09:10:52
#   ModifiedTime: 2018-07-26 09:11:52

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

cd ${Fyellow}./EnvForRD/GCC/LinuxOS/gcc-arm-none-eabi-7-2017-q4-major${AC}
find . -type f -a -name ${Fyellow}libgcc*${AC} | xargs nm -SA | grep -i ${Fyellow}__aeabi_dadd${AC}

EOF

