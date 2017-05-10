#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
ADB_TRACE=adb adb devices
sleep 1
ADB_TRACE=adb adb root
adb shell input keyevent 11
adb shell input keyevent 12
adb shell input keyevent 13
adb shell input keyevent 14
adb shell input keyevent 15
adb shell input keyevent 16
adb shell input keyevent 82
sleep 2
ADB_TRACE=adb adb shell mv -vf /storage/1D3C-50C0/TPVisionDebug.cookie /storage/1D3C-50C0/TPVisionDebug.cookie.jll

read -t 5 -p "Stop to jll's CallStack if press [y]" -n 1 GvChoice
echo
echo
if [ x"${GvChoice}" = x"y" ]; then
    ADB_TRACE=adb adb shell setprop persist.jll.CallStack.C_CPP 0 
    ADB_TRACE=adb adb shell setprop persist.jll.CallStack.JAVA  0
fi
read -t 5 -p "Clean TPVisionDebug if press [y]" -n 1 GvChoice
echo
echo
if [ x"${GvChoice}" = x"y" ]; then
    ADB_TRACE=adb adb shell rm -rf /storage/1D3C-50C0/TPVisionDebug 
    ADB_TRACE=adb adb shell rm -rf /data/debugdump
fi

ADB_TRACE=adb adb shell reboot
