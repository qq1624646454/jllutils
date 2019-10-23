#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jllim.git.backupForClean.sh 
#   Author:       JLLim 
#   Email:        jielong.lin@qq.com
#   DateTime:     2019-10-23 14:41:14
#   ModifiedTime: 2019-10-23 15:33:38

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

#lstFile=$(find . | grep -E '/\.git.*')
lstFile=$(find . | grep -E '/\.git[A-Za-z0-9]{0,}$')

for fl in ${lstFile}; do
    echo "HIT: $fl"
    fl_tgt=orig.git${fl##*/.git}
    p_tgt=${fl%/*}
    if [ x"${p_tgt}" = x ]; then
        p_tgt="."
    fi

    if [ x"${fl_tgt}" = x"orig.git" ]; then
        echo "CHANGE: orig ${fl} will be changed to ${p_tgt}/git.zip"
        zip -r9 ${p_tgt}/git.zip ${fl}
        rm -rf ${fl}
    else
        echo "CHANGE: orig ${fl} will be changed to ${p_tgt}/${fl_tgt}"
        mv -f ${fl} ${p_tgt}/${fl_tgt}
    fi
         
done

