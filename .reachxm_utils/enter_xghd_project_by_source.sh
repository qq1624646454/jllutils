#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 21:11:31
#   ModifiedTime: 2017-11-09 09:56:01

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

jllRoot="/media/root/work/jllproject/trunk_xghd/apps_proc"

if [ -e "${jllRoot}/apps_proc" ]; then
    cd ${jllRoot}/apps_proc
else
    echo -e "Not found ${Fred}${jllRoot}/apps_proc${AC}"
fi

if [ -e "${jllRoot}/apps_proc/poky" ]; then
    cd ${jllRoot}/apps_proc/poky
else
    echo -e "Not found ${Fred}${jllRoot}/apps_proc/poky${AC}"
fi
 
if [ -e "${jllRoot}/apps_proc/kernel/msm-3.18" ]; then
    cd ${jllRoot}/apps_proc/kernel/msm-3.18
else
    echo -e "Not found ${Fred}${jllRoot}/apps_proc/kernel/msm-3.18${AC}"
fi

if [ -e "${jllRoot}/mcm-api" ]; then
    cd ${jllRoot}/mcm-api
else
    echo -e "Not found ${Fred}${jllRoot}/apps_proc/kernel/msm-3.18${AC}"
fi

