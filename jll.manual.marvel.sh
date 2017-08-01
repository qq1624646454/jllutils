#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.marvel.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-01 15:16:23
#   ModifiedTime: 2017-08-01 15:18:02

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

Project Code is retrieved by the belows:
         mkdir  -pv  bg2qr1_ppr2_119
         cd bg2qr1_ppr2_119
         repo init -u ssh://gerrit/platform/manifest -b tpvision/bg2qr1_ppr2_119
         repo sync -d

Compile Commands as follows:
   cd  bg2qr1_ppr2_119
   set_mvl
   source build/envsetup.sh
   lunch philipstv-userdebug
   ./device/tpvision/common/sde/upg/build_philipstv_A1.sh
   ( don’t use option –t userdebug.  If you don’t use any option, by default it builds userdebug)  



EOF

