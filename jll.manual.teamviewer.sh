#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.teamviewer.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-03 20:11:44
#   ModifiedTime: 2018-08-08 17:53:55

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Run teamviewer on Ubuntu-14
============================================
teamviewer --daemon enable
teamviewer


Account: english name qq mail
Password: X[IL6][domain10_lowercase]


Install on Ubuntu-14 64bit
============================================

----------------------------
  Install teamviewer 64bit 
----------------------------

dpkg -i teamviewer_13.2.13582_amd64.deb

#If met errors during installation, please do it follows:
apt-get update
apt-get -f install #handling all dependence installing and re-install teamviewer

/opt/teamviewer/tv_bin/teamviewer-config #registe this computer to teamviewer 
/opt/teamviewer/tv_bin/teamviewerd


----------------------------
  Install teamviewer 32bit 
----------------------------
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

ERROR:
-------------------------------------------------------------------------
Selecting previously unselected package teamviewer.
(Reading database ... 172493 files and directories currently installed.)
Preparing to unpack teamviewer_i386.deb ...
Unpacking teamviewer (12.0.93330) ...
dpkg: dependency problems prevent configuration of teamviewer:
 teamviewer depends on libdbus-1-3.

dpkg: error processing package teamviewer (--install):
 dependency problems - leaving unconfigured
Processing triggers for gnome-menus (3.10.1-0ubuntu2) ...
Processing triggers for desktop-file-utils (0.22-1ubuntu1) ...
Processing triggers for bamfdaemon (0.5.1+14.04.20140409-0ubuntu1) ...
Rebuilding /usr/share/applications/bamf-2.index...
Processing triggers for mime-support (3.54ubuntu1.1) ...
Processing triggers for hicolor-icon-theme (0.13-1) ...
Errors were encountered while processing:
 teamviewer
-------------------------------------------------------------------------
dpkg --add-architecture i386
apt-get update
apt-get -f install
dpkg -i teamviewer_i386.deb


EOF

