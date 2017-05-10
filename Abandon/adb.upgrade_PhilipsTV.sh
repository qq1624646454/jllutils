#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

function usage()
{
    echo "$0 source destination"
    exit 1
}

function progressbar()
{
    bar="=================================================="
    barlength=${#bar}
    n=$(($1*barlength/100))
    printf "\r[%-${barlength}s] %d%%" "${bar:0:n}" "$1"
    # echo -ne "\b$1"
}

export -f progressbar

#[[ $# < 2 ]] && usage

SRC=/home/jielong.lin/aosp_6.0.1_r10_selinux/out/mediatek_linux/output/upgrade_loader.pkg
DST=/storage/1D3C-50C0/

[ ! -f $SRC ] && { \
    echo "source file not found"; \
    exit 2; \
}

which adb >/dev/null 2>&1 || { \
    echo "adb doesn't exist in your path"; \
    exit 3; \
}

SIZE=$(ls -l $SRC | awk '{print $5}')


adb devices

adb root
sleep 2

ADB_TRACE=adb adb shell mv /storage/1D3C-50C0/upgrade_loader.pkg /storage/1D3C-50C0/upgrade_loader.pkg.orig
ADB_TRACE=adb adb push $SRC $DST 2>&1
adb reboot
echo 

exit 0

adb shell mv /storage/1D3C-50C0/upgrade_loader.pkg /storage/1D3C-50C0/upgrade_loader.pkg.orig
adb push -p /home/jielong.lin/aosp_6.0.1_r10_selinux/out/mediatek_linux/output/upgrade_loader.pkg /storage/1D3C-50C0/

adb reboot
