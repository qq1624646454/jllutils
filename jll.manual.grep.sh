#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.grep.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-04-04 12:57:36
#   ModifiedTime: 2019-04-04 12:57:36

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

#### How to lookup syscall started from current path
grep 'SYSCALL_DEFINE[1,2,3,4,5,6]\\{1,\\}(read,.*)$' -nr


EOF

