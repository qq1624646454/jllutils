#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll_source_it_TO_BUILD_KERNEL_FROM_xghd.sh 
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 21:11:31
#   ModifiedTime: 2017-11-02 13:36:21

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ -e "/media/root/work/jllproject/trunk_xghd/apps_proc/poky" ]; then
        cd /media/root/work/jllproject/trunk_xghd/apps_proc/poky 
        source build/conf/set_bb_env_L170XGHD.sh 
        mbuild linux-quic
        echo
        echo "  mbuild linux-quic "
        echo
else
cat >&1<<EOF
    cd /media/root/work/jllproject/trunk_xghd/apps_proc/poky 
    source build/conf/set_bb_env_L170XGHD.sh 
    mbuild linux-quic
EOF

fi


