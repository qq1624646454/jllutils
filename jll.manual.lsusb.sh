#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.lsusb.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-09-03 19:28:07
#   ModifiedTime: 2018-09-03 19:45:40

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

declare -a lst
idx=0
OIFS=${IFS}
IFS=$'\n'
for ln in `cat /sys/kernel/debug/usb/devices | grep "S:  Manufacturer="`; do
    tmp=$(echo $ln | awk -F'=' '{print $2}')
    for((i=0;i<idx;i++)) {
        if [ x"${lst[i]}" = x"${tmp}" ]; then
            tmp=
            break
        fi
    }
    if [ x"${tmp}" != x ]; then
        lst[idx++]="${tmp}"
    fi
done
IFS=${OIFS}

for((i=0;i<idx;i++)) {
    if [ $((i%2)) -eq 0 ]; then
        echo -e "[32mJLLim-$i:	${lst[i]}[0m"
    else
        echo -e "[38mJLLim-$i:	${lst[i]}[0m"
    fi
}

