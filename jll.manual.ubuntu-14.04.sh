#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu-14.04.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-06-11 00:16:15
#   ModifiedTime: 2020-06-11 00:31:25

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1<<EOF

${Fred} How to download Ubuntu 14.04 ${AC}
Open link to https://www.ubuntu.com/download/alternative-downloads
Download BitTorrent and Open BitTorrent to Download Ubuntu image is very fast
I recommend that it is performed by firefox on ubuntu 14.04




${Fgreen} Which desktop subsystem ${AC}
    echo \$DESKTOP_SESSION


${Fwhite}${Bgreen}  update apt-source ${AC}
JLLim@S.#
JLLim@S.# mv /etc/apt/sources.list /etc/apt/sources.list.orig
JLLim@S.#
JLLim@S.# apt-get clean 
clean /var/cache/apt/archives/
 
JLLim@S.#
JLLim@S.# vi /etc/apt/sources.list 
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

JLLim@S.#
JLLim@S.# apt-get update
JLLim@S.#
JLLim@S.# apt-get install -y aptitude
JLLim@S.#



${Fwhite}${Bgreen} Install development for mdm9x07 ${AC}
apt-get update

apt-get install -y openjdk-7-jdk \\
                   gnupg \\
                   flex \\
                   bison \\
                   gperf \\
                   build-essential \\
                   zip \\
                   curl \\
                   zlib1g-dev \\
                   gcc-multilib \\
                   g++-multilib \\
                   libc6-dev-i386 \\
                   lib32ncurses5-dev \\
                   x11proto-core-dev \\
                   libx11-dev \\
                   lib32z1-dev \\
                   ccache \\
                   libgl1-mesa-dev \\
                   libxml2-utils \\
                   xsltproc \\
                   chrpath \\
                   coreutils \\
                   cvs \\
                   diffstat \\
                   docbook-utils \\
                   fakeroot \\
                   g++ \\
                   gawk \\
                   gcc \\
                   git \\
                   git-core \\
                   help2man \\
                   libgmp3-dev \\
                   libmpfr-dev \\
                   libreadline6-dev \\
                   libtool \\
                   libxml2-dev \\
                   make \\
                   python-pip \\
                   python-pysqlite2 \\
                   quilt \\
                   sed \\
                   subversion \\
                   texi2html \\
                   texinfo \\
                   unzip \\
                   wget \\
                   openssh-client \\
                   openssh-server

 git config --global push.default matching 
 git config --global push.default simple 
 git config --global user.name "Jielong Lin"




${Fwhite}${Bgreen} Install ssh tools ${AC} 
 apt-get install openssh-client openssh-server

${Fred} Can't signing in by root ${AC}
Please change "PermitRootLogin without-password" to "PermitRootLogin yes"
in /etc/ssh/sshd_config or /etc/ssh/ssh_config





EOF



