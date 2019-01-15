#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.global_cmd_in_linux.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-28 13:39:52
#   ModifiedTime: 2018-12-28 13:42:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

JLLim@S:.# vim /etc/profile.d/ibbyte.sh
#!/bin/bash
#

function to_lora_workspace()
{
    cd /ibbyte512MB/projects/lpwan/lora 
}
export -f to_lora_workspace

function to_lora()
{
    cd /ibbyte1024MB/corporation/www.reachxm.com/LoRa 
}
export -f to_lora

:w

JLLim@S:.# init 6  #reboot system 
JLLim@S:.#
System is rebooting

JLLim@S:.#
JLLim@S:.# to_lora

EOF


