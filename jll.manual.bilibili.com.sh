#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.bilibili.com.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2021-02-01 11:56:27
#   ModifiedTime: 2021-02-01 13:01:30

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bblue}How to download the video by open-source ${AC}

pip3 install you-get
pip3 install --upgrade you-get

you-get https://www.bilibili.com/video/BV1MJ411h7Zy?from=search&seid=9339372455138228691

EOF
