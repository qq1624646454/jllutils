#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.you-get.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2021-02-01 17:02:28
#   ModifiedTime: 2021-02-01 17:13:10

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bblue} Install you-get ${AC}
pip3 install you-get
pip3 install --upgrade you-get


${Bblue} How to use it ${AC}
you-get [-i] <URL>

your-get --format=mp4hd <URL>

note: --playlist can download full.


#Use the specified player rather than web browser in order to skip AD
you-get -p vlc 'https://www.youtube.com/watch?v=jNQXAC9IVRw'

EOF

