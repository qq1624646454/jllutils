#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

adb devices

adb root
sleep 2
adb shell mv /system/lib/libstagefright.so  /system/lib/libstagefright.so.orig
adb push /home/jielong.lin/aosp_6.0.1_r10_selinux/out/target/product/QM16XE_U/system/lib/libstagefright.so  /system/lib/

adb reboot
