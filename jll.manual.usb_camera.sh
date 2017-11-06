#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.usb_camera.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-07 00:18:08
#   ModifiedTime: 2017-11-07 00:21:03

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

V4L2 - Video For Linux 2 Architect
==============================================================

    +------------------------+
    |  /dev/videoX           |             User Space
-------------------------+-------------------
    |  V4L2 DevNumber(81,x)  |
    +------------------------+
                 |
                 |       --------------------------
                 |       |  Platform V4L2 Driver  |
                 |       --------------------------
                 |         ^          |
                 |     call|   registe|
                 |         |          V 
                 |  +--------------------+
                 |  |  V2L2 Driver Core  |
                 |  +--------------------+
                 |         ^          |
                 |     call|   registe|
                 |         |          V 
     +---------------------------------------+ 
     |  Character Device Driver Core (cdev)  |
     +---------------------------------------+



 
EOF
