#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.Open365.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-07 14:06:23
#   ModifiedTime: 2017-08-07 14:42:46

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}                                                     ${AC}
${Bgreen} ${AC} Installing Open365 For Online Web Office Platform on Ubuntu.12.04
${Bgreen}                                                     ${AC}

Sorry, docker run bad on Ubuntu 12.04

(1)
After restoring system from v8.img.FinalRelease.GUI_jllVPN_smb.20170802 by CloneZilla tools,
Please first install pip3 environment by reference to jll.manual.python.sh

(2)
aptitude install docker
${Fred} docker must run on linux kernel version 3.8 or more, or throws some exceptions${AC}
${Fred}     Segmentation Fault or Critical Error encountered. Dumping core and aborting.${AC}
${Fred}     Aborted (core dumped)${AC}
${Fpink} Obtain the current linux kernel version by uname -r ${AC}
${Fpink} Obtain the current Ubuntu kernel version by cat /etc/issue ${AC}

${Fpink} Upgrade linux kernel to 3.8 ${AC}
  ${Fpink}aptitude install linux-image-3.8.0-44-generic linux-headers-3.8.0-44-generic${AC}


(3)
aptitude install libmysqlclient-dev python3-dev

(4) Reference to the Requirements from https://github.com/Open365/Open365
pip3 install mysqlclient
pip3 install pymongo
pip3 install ldap3
pip3 install requests

(5)
mkdir -pv ~/github.com/Open365
cd ~/github.com/Open365
git clone https://github.com/Open365/Open365.git
cd Open365/

./open365 install




EOF

