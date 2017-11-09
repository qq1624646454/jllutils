#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.echo.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-09 14:46:34
#   ModifiedTime: 2017-11-09 14:47:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF

# Hex data
echo -n -e "\xFE\x01\x02"

EOF

