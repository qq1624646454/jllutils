#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.nginx.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-03 18:01:48
#   ModifiedTime: 2018-12-03 18:02:17

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

#关于nginx源码的注解
https://github.com/its-tech/nginx-1.14.0-research

EOF

