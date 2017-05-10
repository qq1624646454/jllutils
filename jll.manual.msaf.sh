#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.msaf.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-15 10:25:33
#   ModifiedTime: 2016-12-01 11:54:36

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
If some crashs occur on startup stage after upgraded uboot loader,
and it may cause that SW is not upgraded from upgrade_loader.pkg
in UDisk. 
------------------------------------------------------------------
SOLVE: 
1.Erase Boot loader via use FlashTool0.7.0.2 to flash "E" then flash "EF"
2.Use FlashTool0.7.0.2 to re-flash boot loader named
  PH7M_EU_5596-userdebug-TPM171E_R.0.1.176.0-secure_emmcboot.bin
3.Stick PH7M_EU_5596-userdebug-TPM171E_R.0.1.176.0-upgrade_loader.pkg in
  the root path of UDisk, then rename to upgrade_loader.pkg
4.Upgrade SW only by reboot.





>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
pkg release
------------------------------------------------
\\\\172.20.30.11\\Dailybuilds\\MTK\\MSAF_2K17




>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
adb via USB on 2k17 msaf
------------------------------------------------
mt5890 #
addboot androidboot.selinux=permissive
addboot ssusb_adb=1
addboot adb_enable=1
addboot adb_port=1
saveenv
reset




EOF

