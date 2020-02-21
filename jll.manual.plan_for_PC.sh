#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.plan_for_PC.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-02-15 01:47:31
#   ModifiedTime: 2020-02-15 01:58:22

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

For win7:
Run# shutdown -f -s -t 7200 # system is shutdowned after 7200s

For unbuntu:
Run# shutdown -h 4:00
Shutdown scheduled for Sat 2020-02-15 04:00:00 CST, use 'shutdown -c' to cancel.

EOF


