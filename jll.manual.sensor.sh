#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.sensor.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2021-02-02 11:09:41
#   ModifiedTime: 2021-02-02 11:10:10

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

aptitude install -y sensors-applet lm-sensors
sensors  #console

apt-get install psensor
psensor  #graphics

EOF

