#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.reachxm.mdm9607.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-08 19:11:03
#   ModifiedTime: 2017-11-08 19:12:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

${Byellow}${Fblack}                    ${AC}
${Byellow}${Fblack}                    ${AC}
${Byellow}${Fblack}                    ${AC}

EOF

