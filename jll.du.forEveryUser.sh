#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

Lfn_Sys_CheckRoot

Lfn_Sys_GetAllUsers GvUserList

echo
echo
echo
echo
echo
echo "------------------------------------------------------"
echo "User's Used Space Statistic @ $(date +%Y-%m-%d\ %H:%M:%S) "
echo "------------------------------------------------------"
echo
for GvUser in ${GvUserList}; do
    if [ -e "/home/${GvUser}" ]; then
        echo ">>>${GvUser}"
        du -sh /home/${GvUser}
    else
        if [ -e "/${GvUser}" ]; then
            echo ">>>${GvUser}"
            du -sh /${GvUser}
        fi
    fi
    echo
done
echo
echo

