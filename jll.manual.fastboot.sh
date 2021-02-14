#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.fastboot.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-29 10:24:53
#   ModifiedTime: 2020-12-29 10:31:12

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Fyellow}fastboot getvar all${AC}
(bootloader) version:0.5
(bootloader) variant:MTP UFS
(bootloader) secure:no
(bootloader) version-baseband:
(bootloader) version-bootloader:
(bootloader) display-panel:
(bootloader) off-mode-charge:0
(bootloader) charger-screen-enabled:0
(bootloader) max-download-size: 0xd000000
(bootloader) serialno:MDM9607
(bootloader) kernel:lk
(bootloader) product:
all:
finished. total time: 0.026s

EOF

