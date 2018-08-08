#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.virtualbox.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-08-08 14:47:08
#   ModifiedTime: 2018-08-08 14:50:17

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

apt-get -y install virtualbox virtualbox-guest-additions-iso 

EOF

