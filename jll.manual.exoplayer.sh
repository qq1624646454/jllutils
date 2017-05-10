#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.exoplayer.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-11 15:50:00
#   ModifiedTime: 2016-11-12 10:58:26

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

# Compile by 
  --> jll.PhilipsTV.msaf.mtk.sh
      --> Compilation: make or make clean
          --> ExoPlayerWrapper-ContentExplorer:     compile exoplayerwrapper and contentexplorer

# Mapping server samba path into W: on windows
\\\\172.20.30.6\\localhome
# Run ConEmu and run the below commands:
cd /w/2k17_mtk_archer_m_refdev/android/m-base/out/target/product/PH7M_EU_5596/system/app/contentexplorer
adb install -r contentexplorer.apk 

# Or install by U-Disk
pm install -r /storage/5663-FC0E/contentexplorer.apk


# Enable logcat 
setprop open.exowrapper.log.flag v




EOF

