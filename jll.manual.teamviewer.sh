#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.teamviewer.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-03 20:11:44
#   ModifiedTime: 2018-01-29 11:21:58

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Run teamviewer on Ubuntu-14
============================================
teamviewer --daemon enable enable
teamviewer


Account: english name qq mail
Password: X[IL6][domain10_lowercase]


Install on Ubuntu-14
============================================
apt-get install libc6:i386 \\
                libgcc1:i386 \\
                libasound2:i386 \\
                libexpat1:i386 \\
                libfontconfig1:i386 \\
                libfreetype6:i386 \\
                libjpeg62:i386 \\
                libpng12-0:i386 \\
                libsm6:i386 \\
                libxdamage1:i386 \\
                libxext6:i386 \\
                libxfixes3:i386 \\
                libxinerama1:i386 \\
                libxrandr2:i386 \\
                libxrender1:i386 \\
                libxtst6:i386 \\
                zlib1g:i386

wget http://download.teamviewer.com/download/teamviewer_i386.deb

dpkg -i teamviewer_i386.deb



EOF

