#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.dump_stack.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-31 19:48:46
#   ModifiedTime: 2017-10-31 19:48:46

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

需要包含的头文件：
#include <asm/ptrace.h>
在函数中调用：
dump_stack();

EOF

