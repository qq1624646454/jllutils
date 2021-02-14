#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.coredump.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2021-01-20 14:37:07
#   ModifiedTime: 2021-01-20 14:39:59

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

#查看Linux是否的coredump文件路径
${Fgreen}adb shell${AC}
${Fgreen}cat /proc/sys/kernel/core_pattern${AC}
/var/tmp/core.%e.%p.%s.%t


#yaxon coredump about app
/var/volatile/tmp/core.gps_app.exe.706.6.1611152441

EOF

