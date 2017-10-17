#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.jdk.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-10-17 09:36:32
#   ModifiedTime: 2017-10-17 09:36:32

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

${Bgreen}${Fyellow}                               ${AC}
${Bgreen}${Fyellow}  jdk is installed on Win7     ${AC}
${Bgreen}${Fyellow}                               ${AC}


EOF

