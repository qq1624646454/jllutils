#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.shell_priority.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-07 18:14:14
#   ModifiedTime: 2017-11-07 18:14:57

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

通俗地讲，linux系统中，进程有-19到19这39个优先级。-19最优先，19最不优先。进程的默认优先级为0。

# 最低优先级
nice -19 tar zcf pack.tar.gz documents

# 最高优先级
nice --19 tar zcf pack.tar.gz documents


EOF


