#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.reachxm.setup.mdm9607.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-08 19:11:03
#   ModifiedTime: 2017-11-09 11:16:54

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

${Byellow}${Fblack}                    ${AC}
${Byellow}${Fblack}                    ${AC}
${Byellow}${Fblack}                    ${AC}

EOF

#if [ -e "${JLLPATH}/.reachxm_utils/jllim_set_xghd_project_for_reachxm.sh" -a \
#    ! -e "/etc/profile.d/jllim_set_xghd_project_for_reachxm.sh" ]; then
if [ -e "${JLLPATH}/.reachxm_utils/jllim_set_xghd_project_for_reachxm.sh" ]; then 

    cp -rvf ${JLLPATH}/.reachxm_utils/jllim_set_xghd_project_for_reachxm.sh \
            /etc/profile.d

    echo -e \
        "JLLim: Installed to ${Fyellow}/etc/profile.d/jllim_set_xghd_project_for_reachxm.sh${AC}"
    echo -e "JLLim: Please ${Fyellow}reboot${AC} to ${Fyellow}active it${AC}..."
else
    echo -e \
        "JLLim: ${Fred}Failed to install...${AC}"
fi


