#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
# DI - DebugInfo
# ADB_TRACE=adb adb shell cp -rvf xxx yyy

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ ! -e "${JLLPATH}/PhilipsTVUtils/PhilipsTVUtils.DebugInfo.prepare.sh" ]; then
    echo "JLL: Not exist ${JLLPATH}/PhilipsTVUtils/PhilipsTVUtils.DebugInfo.prepare.sh"
    exit 0
fi

adb devices
sleep 1
adb root
sleep 1
GvFlag=$(adb shell "which PhilipsTVUtils.DebugInfo.prepare.sh")
echo "Flag=${GvFlag}"
if [ x"${GvFlag}" = x ]; then
    adb push ${JLLPATH}/PhilipsTVUtils/PhilipsTVUtils.DebugInfo.prepare.sh /system/bin
    adb shell chmod +x /system/bin/PhilipsTVUtils.DebugInfo.prepare.sh 
fi

echo
adb shell "/system/bin/PhilipsTVUtils.DebugInfo.prepare.sh"
echo
