#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.debug_kernel.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-21 19:42:13
#   ModifiedTime: 2017-11-22 09:16:39

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF

#ifdef pr_debug
#undef pr_debug
#define pr_debug(fmt, ...) \\
            printk(KERN_INFO "JLLim.D.%d-%s| " fmt, __LINE__, __FUNCTION__, ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...)
#endif

EOF

