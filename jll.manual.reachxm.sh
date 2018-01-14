#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.reachxm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 08:48:41
#   ModifiedTime: 2017-12-11 15:30:44

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF

${Bgreen}${Fblack} Custom the /etc/init.d/reachservice.sh${AC}
/media/root/work/jllproject/trunk_xghd/apps_proc/poky/meta-qti-bsp-prop/recipes-bsp/reach-services/reach-services_0.0.bb
/media/root/work/jllproject/trunk_xghd/apps_proc/mcm-api/mcm_sample/reach-services/reachservices.sh


${Bgreen}${Fblack}[Ctrl]+[Alt]+[T] ${Fred}# Run Terminate in a separated windows${AC}
~# ${Fyellow}cd /media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky ${AC}
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky# ${Fyellow}source build/conf/set_bb_env_L170H.sh${AC}

# mbuild will first clean then compile
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky/build# ${Fyellow}mbuild linux-quic${AC}

# originial method to build all
buildclean
build-9607-image

# script method to build all
cd buildapp
./buildL170HSHIP app

#out: apps_proc/poky/build/tmp-glibc/deploy/images/mdm9607






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


Lk:      fastboot flash aboot  appsboot.mbn
Kernel:  fastboot flash boot   mdm9607-boot.img
System:  fastboot flash system mdm9607-sysfs.ubi

# fast compile kernel
# 可以在apps_proc\oe-core\build\tmp-glibc\work-shared\mdm9607\kernel-source修改代码
# 验证正确后，需要手动把代码同步到apps_proc/kernel目录
# 使用以下命令编译
bitbake linux-quic -c compile -f   //编译kernel
bitbake linux-quic -c deploy -f    // 更新镜像


  

EOF

