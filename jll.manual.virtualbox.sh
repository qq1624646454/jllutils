#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.virtualbox.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-08-25 17:46:14
#   ModifiedTime: 2018-08-25 17:46:14

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more>&1<<EOF

 apt-get  install virtualbox-dkms virtualbox-dbg

 # Observed owner for /usr if launch virtualbox met error:
 #   Failed to load VMMR0.r0 (VERR_SUPLIB_OWNER_NOT_ROOT)
 ls -l /usr/
 chown -r root:root /usr
EOF

