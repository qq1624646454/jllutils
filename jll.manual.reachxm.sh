#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.reachxm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 08:48:41
#   ModifiedTime: 2017-11-01 09:14:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF

${Bgreen}${Fblack}[Ctrl]+[Alt]+[T] ${Fred}# Run Terminate in a separated windows${AC}
~# ${Fyellow}cd /media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky ${AC}
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky# ${Fyellow}source build/conf/set_bb_env_L170H.sh${AC}
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky/build# ${Fyellow}mbuild linux-quic${AC}

${Bgreen}${Fblack}[Ctrl]+[Shift]+[T] ${Fred}# Run Terminate in a separated table of the same windows${AC}
   adb reboot-bootloader
   fastboot devices
   fastboot flash boot mdm9607-boot.img
   fastboot reboot

${Fseablue} Suggestion: make a script to run the above commands ${AC}
  ${Fyellow}vim ./fl.sh${AC}
  ${Fyellow}#!/bin/sh${AC}
  ${Fyellow}adb reboot-bootloader${AC}
  ${Fyellow}fastboot devices${AC}
  ${Fyellow}fastboot flash boot mdm9607-boot.img${AC}
  ${Fyellow}fastboot reboot${AC}
  

EOF

