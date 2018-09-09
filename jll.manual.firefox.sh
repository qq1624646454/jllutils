#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.firefox.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-09-10 00:00:45
#   ModifiedTime: 2018-09-10 00:01:31

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Howto Install:
  tar -zvxf flash_player_npapi_linux.x86_64.tar.gz -C /
  vim /readme.txt 
  mv  /libflashplayer.so /usr/lib/mozilla/plugins/
  rm -rvf /readme.txt

  re-launch firefox

EOF


