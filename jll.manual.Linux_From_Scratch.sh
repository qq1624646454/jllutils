#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.Linux_From_Scratch.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-04-19 00:08:42
#   ModifiedTime: 2017-04-19 23:50:24

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1<<EOF

==============================================================================
 Setup the environment with only for "/repository/virtualization/qemu@linux"
============================================================================== 

  # mkdir -pv Ubuntu_As_LFS_Environment
  # cp -rvf /repository/virtualization/qemu@linux/Installer Ubuntu_As_LFS_Environment/
  # cd Ubuntu_As_LFS_Environment
  # vim Installer/Ubuntu_Installer.sh
  ...
  #
  # export DISPLAY=192.168.1.11:0.0
  # Installer/Ubuntu_Installer.sh



http://old-releases.ubuntu.com/releases/12.10/


EOF

