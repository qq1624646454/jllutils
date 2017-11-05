#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-30 15:59:57
#   ModifiedTime: 2017-11-05 14:42:06

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Fseablue}Ctrl + Alt + T ${AC}: populate a new terminate console window
${Fseablue}Ctrl + Shift + T ${AC}: create a new terminate console table in current window

${Fseablue}Volume is too small ${AC}
Run the command:
    pulseaudio --start --log-target=syslog
Suggestion:
    append this command into /etc/rc.local


${Fseablue}Waiting for network configuration…${AC}
The eth0 is not linked on startup stage, so system will run /etc/init/failsafe.conf
${Fred}Solved${AC}
Solution-1: remove the unused eth0
Solution-2: change the sleep time in /etc/init/failsafe.conf

Note: wifi is started so slower is because eth0 is bad to delay checking.
Hence please remove the unused eth0


EOF


