#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

JLLPATH=$(cd ${JLLPATH};pwd)


#
# Setup jllutils
#
function Fn_Setup_jllutils_In_PATH()
{
    if [ x"$(cd ${JLLPATH}/..;pwd)" = x"/" ]; then
        echo
        echo "Sorry, the parent path shouldn't be \"/\""
        echo
        exit 0
    fi
    if [ -e "${JLLPATH}/.___jllrepoconf" ]; then
        cp -rvf ${JLLPATH}/.___jllrepoconf ${JLLPATH}/../.jllrepoconf
        ${JLLPATH}/jll.repo.sh init
    fi

    GvTargetLines=""
    if [ -e "${HOME}/.bashrc" ]; then
        JLLP=$(echo "${JLLPATH}" | sed 's:\/:\\\/:g')
        GvTargetLines=$(sed -n "/^[ -t]*PATH\=${JLLP}/=" ~/.bashrc)
    fi

    if [ x"${GvTargetLines}" = x ]; then
        echo "PATH=${JLLPATH}:\${PATH}" >> ~/.bashrc
        if [ -e "${JLLPATH}/core_utils_autocomplete_parameters.sh" ]; then
            echo "source ${JLLPATH}/core_utils_autocomplete_parameters.sh" >> ~/.bashrc
        fi

        echo "Success to write \"${JLLPATH}\" to ~/.bashrc"
    fi

    crontab -l  > tsk.crontab  2>/dev/null
    if [ -e "${JLLPATH}/._______auto_sync_by_GIT__in_crontab.sh" ]; then
        __chk_if_exist=$(cat tsk.crontab \
                         | grep -E "${JLLPATH}/._______auto_sync_by_GIT__in_crontab.sh")
        if [ x"${__chk_if_exist}" = x ]; then
cat >>tsk.crontab<<EOF

# m  h    dom mon dow command
  *  */3  *   *   *   ${JLLPATH}/._______auto_sync_by_GIT__in_crontab.sh

EOF
            crontab tsk.crontab
        fi
        rm -rf tsk.crontab
        echo
        crontab -l 
        echo
    fi

    unset GvTargetLines
}

Fn_Setup_jllutils_In_PATH

