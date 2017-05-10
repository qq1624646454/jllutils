#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.viccdiff.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2016-12-26 09:07:18
#   ModifiedTime: 2016-12-26 09:07:30

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

diff -rq aosp_6.0.1_r10_selinux/external/boringssl  AndrN_Orig_PDK/n-pdk/external/boringssl | tee -a Compact_M_N



