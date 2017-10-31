#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ifconfig.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-31 15:08:23
#   ModifiedTime: 2017-10-31 15:08:23

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

ifconfig eth0 192.168.1.102 netmask 255.255.255.0

route add default gw 192.168.1.1

EOF

