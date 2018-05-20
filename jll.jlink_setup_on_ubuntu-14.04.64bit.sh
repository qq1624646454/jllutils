#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-12-25 14:15:05
#   ModifiedTime: 2017-12-25 14:15:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ -e "${JLLPATH}/JLink/JLink_Linux_V630k_x86_64.deb" ]; then
    dpkg -i ${JLLPATH}/JLink/JLink_Linux_V630k_x86_64.deb
else
    echo -e "${Fred}JLLim| Sorry, not found ${JLLPATH}/JLink/JLink_Linux_V630k_x86_64.deb${AC}"
fi

