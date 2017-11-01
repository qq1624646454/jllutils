#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.debian_for_acer4745g.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-27 01:34:35
#   ModifiedTime: 2017-10-27 01:49:42

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

For the displayed card is bad, the ubuntu desktop 14.04 will work abnormal.
So only select debian 8.3 jessie with apt-source is to ubuntu 14.04.

${Fyellow}debian_for_acer4745g/etc/apt/sources.list.d/ubuntu14_in_aliyun.list${AC}
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse 

${Fyellow}debian_for_acer4745g/etc/apt/sources.list.d/virtualbox.list${AC}
deb http://download.virtualbox.org/virtualbox/debian jessie contrib
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt-key finger

apt-get update

apt-get install virtualbox-5.2 dkms virtualbox-dkms


apt-get install firefox
apt-get install git

#for install input method by fcitx, please reference to jll.manual.fcitx.sh

mkdir -pv github.com/qq1624646454
cd github.com/qq1624646454
git clone https://github.com/qq1624646454/jllutils.git
cd jllutils/
./____install_jllutils.sh;cd -
git clone https://github.com/qq1624646454/vicc_installer.git

EOF
