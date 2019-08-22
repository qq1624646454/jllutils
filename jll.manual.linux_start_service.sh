#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.linux_start_service.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-08-22 16:58:27
#   ModifiedTime: 2019-08-22 16:59:03

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

cp -rvf SimpleHttpServer_gerrit.reachxm.com_10080.sh /etc/init.d/

update-rc.d SimpleHttpServer_gerrit.reachxm.com_10080.sh defaults

init 6 #for reboot

EOF


