#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

## Lfn_Sys_Rotate &
## GvBgPid=$!
## sleep 20
## kill -9 ${GvBgPid} 
##
function Lfn_Sys_Rotate_ForLOCAL()
{
    LvSrInterval=0.05
    LvSrTcount="0"

    if [ x"$1" = x ]; then
        return;
    fi

    while true; do
        # Clear the current line
        echo -ne "\033[2K"

        LvSrTcount=`expr ${LvSrTcount} + 1`
        LvSrFileSize=$(du -sh $1 2>/dev/null)
        LvSrFileSize=$(echo ${LvSrFileSize} | awk -F' ' '{print $1}')
        case  ${LvSrTcount}  in
        1)
            echo -en '\033[10G ' && echo -ne "\b- ${LvSrFileSize}"
            sleep  ${LvSrInterval}
        ;;
        2)
            echo -en '\033[10G ' && echo -ne "\b\\ ${LvSrFileSize}"
            sleep  ${LvSrInterval}
        ;;
        3)
            echo -en '\033[10G ' && echo -ne "\b| ${LvSrFileSize}"
            sleep  ${LvSrInterval}
        ;;
        4)
            echo -en '\033[10G ' && echo -ne "\b/ ${LvSrFileSize}"
            sleep  ${LvSrInterval}
        ;;
        *)
            LvSrTcount="0"
            sleep  ${LvSrInterval}
        ;;
        esac
    done
}

__DI_Repository=Asta.DI.R$(date +%Y_%m_%d__%H_%M_%S)
if [ -e "${__DI_Repository}" ]; then
    rm -rf $(pwd)/${__DI_Repository}
fi
mkdir -pv $(pwd)/${__DI_Repository}

#
# Probe if U-Disk is valid with IDentifier_For_Asta_By_ADB.jllcookie
#
#ADB_TRACE=adb adb devices
adb devices
adb root
__ID="IDentifier_For_Asta_By_ADB.jllcookie"
__UDiskPath=""
__List=$(adb shell ls mnt/media_rw/)
for __T in ${__List}; do
    echo "JLL.Probing: mnt/media_rw/${__T}"
    __Ret=$(adb shell ls mnt/media_rw/${__T}/${__ID} 2>/dev/null)
    if [ x"${__Ret}" != x ]; then
        __UDiskPath="mnt/media_rw/${__T}"
        break; 
    fi
done

if [ x"${__UDiskPath}" = x ]; then
    echo
    echo "JLL: Sorry, not probe any valid U-Disk with ${__ID}"
    echo
    exit 0
else
    echo
    echo "JLL: Found U-Disk=\"${__UDiskPath}\" on the Remote Android Device"
    echo
    if [ -e "${__UDiskPath}/TPVisionDebug.cookie" ]; then
        if [ -e "${__UDiskPath}/TPVisionDebug" ]; then
            adb devices
            sleep 1
            adb root
            adb shell input keyevent 11
            adb shell input keyevent 12
            adb shell input keyevent 13
            adb shell input keyevent 14
            adb shell input keyevent 15
            adb shell input keyevent 16
            adb shell input keyevent 82
            sleep 2
            adb shell \
                mv -vf ${__UDiskPath}/TPVisionDebug.cookie \
                       ${__UDiskPath}/TPVisionDebug.cookie.jll

            Lfn_Sys_Rotate_ForLOCAL "$(pwd)/TPVisionDebug" &
            PID_Lfn_Sys_Rotate_ForLOCAL=$!
            adb pull ${__UDiskPath}/TPVisionDebug   $(pwd)/${__DI_Repository}
            kill -9 ${PID_Lfn_Sys_Rotate_ForLOCAL} >/dev/null
            echo
            Lfn_Sys_Rotate_ForLOCAL "$(pwd)/debugdump" &
            PID_Lfn_Sys_Rotate_ForLOCAL=$!
            adb pull data/debugdump   $(pwd)/${__DI_Repository}
            kill -9 ${PID_Lfn_Sys_Rotate_ForLOCAL} >/dev/null
            echo
            read -t 5 -p "JLL: Clean TPVisionDebug and debugdump if press [y]" -n 1 GvChoice
            echo
            if [ x"${GvChoice}" = x"y" ]; then
                #ADB_TRACE=adb adb shell rm -rf ${__UDiskPath}/TPVisionDebug 
                #ADB_TRACE=adb adb shell rm -rf /data/debugdump
                adb shell rm -rf ${__UDiskPath}/TPVisionDebug 
                adb shell rm -rf /data/debugdump
            fi
            echo
            exit 0
        fi
    fi
    echo "JLL: Sorry, Not found \"TPVisionDebug\" on U-Disk=\"${__UDiskPath}\""
fi




