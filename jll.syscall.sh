#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.syscall.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-05-25 16:10:53
#   ModifiedTime: 2019-05-25 16:21:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

Usage()
{
    echo
    echo "JLLim| USAGE:"
    echo "JLLim|"
    echo "JLLim|     ${0##*/} <syscall-function-name>"
    echo "JLLim|"
    echo "JLLim| FOR EXAMPLE:"
    echo "JLLim|     sw/L170L_baseline/apps_proc/kernel# jll.syscall.sh socket"
    echo "JLLim|"
    echo "JLLim|"
    echo
}

if [ $# -ne 1 ]; then
    Usage
    exit 0
fi

find . -type f -a -name *.c | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} | grep "$1[ ]\{0,\}," --color

