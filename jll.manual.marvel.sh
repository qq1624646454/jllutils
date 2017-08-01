#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.marvel.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-01 15:16:23
#   ModifiedTime: 2017-08-01 15:54:01

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Fgreen}~/.ssh/config${AC}
Host gerrit-xmmaster
       Hostname 172.20.30.2
        Port 29418
        User YourName
       IdentityFile ~/.ssh/id_rsa

Host gerrit
        Hostname 172.20.30.2
        Port 29419
        User YourName
       IdentityFile ~/.ssh/id_rsa


${Fgreen}Project Code is retrieved by the belows:${AC}
         mkdir  -pv  bg2qr1_ppr2_119
         cd bg2qr1_ppr2_119
         repo init -u ssh://gerrit/platform/manifest -b tpvision/bg2qr1_ppr2_119
         repo sync -d

${Fgreen}Compile Commands as follows:${AC}
   cd  bg2qr1_ppr2_119
   set_mvl
   source build/envsetup.sh
   lunch philipstv-userdebug
   ./device/tpvision/common/sde/upg/build_philipstv_A1.sh

${Fseablue}( don’t use option –t userdebug. ${AC}\
${Fseablue}If you don’t use any option, by default it builds userdebug )${AC}



EOF

