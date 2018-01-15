#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.bcompre_in_linux.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-27 01:15:57
#   ModifiedTime: 2017-11-27 01:15:57

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

#For ubuntu or debian
wget http://www.scootersoftware.com/bcompare-4.1.9.21719_amd64.deb
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.1.9.21719_amd64.deb



EOF

