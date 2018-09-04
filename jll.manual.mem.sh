#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.mem.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-08-26 22:20:54
#   ModifiedTime: 2018-08-26 22:20:54

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

#Free the cached buffer
echo 1 > /proc/sys/vm/drop_caches

EOF

