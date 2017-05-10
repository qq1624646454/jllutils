#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

GvDebugInfo=DI__$(date +%Y.%m.%d_%H.%M.%S)
adb root
sleep 2
adb pull /storage/1D3C-50C0/TPVisionDebug  ./${GvDebugInfo}/TPVisionDebug
adb pull /data/debugdump  ./${GvDebugInfo}/debugdump

