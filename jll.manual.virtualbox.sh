#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.virtualbox.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-08-25 17:46:14
#   ModifiedTime: 2018-11-25 12:49:47

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more>&1<<EOF

#Install Virtualbox: please first download the latest version image from official website
dpkg -i virtualbox-5.2_5.2.18-124319~Ubuntu~trusty_amd64.deb

#Support for usb 2.0, so please download the extension package, then double click it to install


#Abandon
 apt-get install -y virtualbox-dkms virtualbox-dbg virtualbox-guest-additions-iso

 # Observed owner for /usr if launch virtualbox met error:
 #   Failed to load VMMR0.r0 (VERR_SUPLIB_OWNER_NOT_ROOT)
 ls -l /usr/
 chown -R root:root /usr

 Right Ctrl + F      -- 切换到全屏模式
 Right Ctrl + L      -- 切换到无缝模式
 Right Ctrl + C      -- 切换到比例模式
 Right Ctrl + Home   -- 显示控制菜单

EOF

