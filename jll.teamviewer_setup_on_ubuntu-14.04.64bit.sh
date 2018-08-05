#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-12-25 14:15:05
#   ModifiedTime: 2018-08-02 23:00:28

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ -e "${JLLPATH}/teamviewer/teamviewer_13.1.8286_amd64.deb" ]; then
    aptitude install -f libqt5x11extras5-dev
    dpkg -i ${JLLPATH}/teamviewer/teamviewer_13.1.8286_amd64.deb
    if [ x"$(aptitude search teamviewer | grep -E '^i')" = x ]; then
        apt-get update
        apt-get -f install
        if [ x"$(aptitude search teamviewer | grep -E '^i')" != x ]; then
            exit 0 
        fi
    fi
else
    echo -e "${Fred}JLLim| Sorry, not found ${JLLPATH}/teamviewer/teamviewer_13.1.8286_amd64.deb${AC}"
    echo -e "${Fred}JLLim| Try to install ${JLLPATH}/teamviewer/teamviewer_i386.deb${AC}"
fi

if [ -e "${JLLPATH}/teamviewer/teamviewer_i386.deb" ]; then
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
    dpkg -i ${JLLPATH}/teamviewer/teamviewer_i386.deb
else
    echo -e "${Fred}JLLim| Sorry, not found ${JLLPATH}/teamviewer/teamviewer_i386.deb${AC}"
fi

