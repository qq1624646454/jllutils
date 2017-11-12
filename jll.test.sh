#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.test.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-12 23:26:08
#   ModifiedTime: 2017-11-13 01:04:35

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


## Lfn_Progressbar_MonitorByte "~/.vicc" &
## GvBgPid=$!
## sleep 20
## echo ""
## kill -12 ${GvBgPid} 
##
function Lfn_Progressbar_MonitorByte()
{
    LvPbInterval=0.05
    LvPbTcount="0"

    if [ $# -ne 1 ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    Lfn_Sys_PathConvertToAbsolutePath LvPbPath "$1" 
    if [ -z "${LvPbPath}" -o ! -e "${LvPbPath}" ]; then
        echo "Sorry, Exit because of the invalid path\"${LvPbPath}\""
        exit 0
    fi

    export __jllutil_rotate_status=1

    # When SIGUSR2(=12) is received, run "export __jllutil_rotate_status=0" 
    trap "export __jllutil_rotate_status=0"  12

    echo ""
    Lfn_Cursor_Mov "3" "right"
    LvPbOffs=2
    while [ x"${__jllutil_rotate_status}" = x"1" ]; do
        LvPbData="$(du -sh ${LvPbPath} | awk -F ' ' '{print $1}')"
        LvPbTcount=`expr ${LvPbTcount} + 1`
        case  ${LvPbTcount}  in
        1)
            echo -ne "- ${LvPbData}"
            Lfn_Cursor_Mov "$[ ${LvPbOffs}+${#LvPbData} ]" "left"
            sleep  ${LvPbInterval}
        ;;
        2)
            echo -ne "\\ ${LvPbData}"
            Lfn_Cursor_Mov "$[ ${LvPbOffs}+${#LvPbData} ]" "left"
            sleep  ${LvPbInterval}
        ;;
        3)
            echo -ne "| ${LvPbData}"
            Lfn_Cursor_Mov "$[ ${LvPbOffs}+${#LvPbData} ]" "left"
            sleep  ${LvPbInterval}
        ;;
        4)
            echo -ne "/ ${LvPbData}"
            Lfn_Cursor_Mov "$[ ${LvPbOffs}+${#LvPbData} ]" "left"
            sleep  ${LvPbInterval}
        ;;
        *)
            LvPbTcount="0"
            sleep  ${LvPbInterval}
        ;;
        esac
        echo -ne "${CvAccOff}\033[K${CvAccOff}"
    done

    trap 12 # Restore signal SIGUSR2 to default action.
}


 Lfn_Progressbar_MonitorByte "~/.vicc" &
 GvBgPid=$!
 sleep 20
 echo
 kill -12 ${GvBgPid} 

