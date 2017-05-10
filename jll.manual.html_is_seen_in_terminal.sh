#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.html_is_seen_in_terminal.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-01-21 17:15:05
#   ModifiedTime: 2017-01-21 17:15:22

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

w3m  xxx.html

EOF

