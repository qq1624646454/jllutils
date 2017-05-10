#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1 << EOF

@@@@@ gnome-terminal @@@@@
# open /dev/ttyUSB0
screen /dev/ttyUSB0 115200
# close /dev/ttyUSB0
Ctrl_a_z
# switch to another window session
Ctrl_a_c

EOF

