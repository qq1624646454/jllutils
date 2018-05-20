#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-12-25 14:15:05
#   ModifiedTime: 2017-12-25 14:15:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ -e "${JLLPATH}/JLink/JLink_Linux_V630k_x86_64.deb" ]; then
    dpkg --add-architecture i386
    apt-get update
    apt-get -f install
    apt-get -f install libc6:i386 \
                    libgcc1:i386 \
                    libasound2:i386 \
                    libexpat1:i386 \
                    libfontconfig1:i386 \
                    libfreetype6:i386 \
                    libjpeg62:i386 \
                    libpng12-0:i386 \
                    libsm6:i386 \
                    libxdamage1:i386 \
                    libxext6:i386 \
                    libxfixes3:i386 \
                    libxinerama1:i386 \
                    libxrandr2:i386 \
                    libxrender1:i386 \
                    libxtst6:i386 \
                    zlib1g:i386
    dpkg -i ${JLLPATH}/teamviewer_i386/teamviewer_i386.deb
else
    echo -e "${Fred}JLLim| Sorry, not found ${JLLPATH}/teamviewer_i386/teamviewer_i386.deb${AC}"
fi

