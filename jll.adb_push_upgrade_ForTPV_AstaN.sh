#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.adb_push_upgrade_ForTPV_AstaN.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-02-10 11:10:45
#   ModifiedTime: 2017-02-10 16:51:30

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

## Lfn_Sys_Rotate_ForREMOTE [TargetFile] &
## PID_Lfn_Sys_Rotate_ForREMOTE=$!
## sleep 20
## kill -9 ${Lfn_Sys_Rotate_ForREMOTE} 
##
function Lfn_Sys_Rotate_ForREMOTE()
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
        LvSrFileSize=$(adb shell "du -sh $1 2>/dev/null")
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


### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

adb root
GvTargetPath=""
__List=$(adb shell "ls 'mnt/media_rw/'")
for __T in ${__List}; do
    echo ${__T}
    __Res=$(adb shell "ls mnt/media_rw/${__T}/upgrade_by_jll.cookie 2>/dev/null")
    if [ x"${__Res}" != x ]; then
        GvTargetPath="mnt/media_rw/${__T}"
        break; 
    fi
done

if [ x"${GvTargetPath}" = x ]; then
    echo
    echo "Sorry, not find U-Disk with the file upgrade_by_jll.cookie"
    echo
    exit 0
fi
echo "Found U-Disk \"${GvTargetPath}\" on the Remote Android Device"
if [ x"${__Res}" != x ]; then
    adb shell "rm -rf ${GvTargetPath}/upgrade_loader.pkg"
fi

__Res=$(adb shell "ls mnt/media_rw/${__T}/upgrade_loader.pkg 2>/dev/null")

GvSourcePath="/W/androidn_2k16_mainline/out/mediatek_linux/output/upgrade_loader.pkg"
if [ -e "${GvSourcePath}" ]; then
    echo "adb push ${GvSourcePath} ${GvTargetPath}"
    echo "# ${GvSourcePath}-->${GvTargetPath}"
    Lfn_Sys_Rotate "${GvTargetPath}/upgrade_loader.pkg"  &
    PID_for_Lfn_Sys_Rotate=$!
    adb push ${GvSourcePath} ${GvTargetPath}
    echo
    kill -9 ${PID_for_Lfn_Sys_Rotate} >/dev/null
    adb shell "cd ${GvTargetPath};ls -lh"
else
    if [ ! -e "${GvSourcePath}" ]; then
        echo "Not present \"${GvSourcePath}\""
    fi
fi




