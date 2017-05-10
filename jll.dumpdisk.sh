#!/bin/bash
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

Lfn_Sys_CheckRoot

function Fn_Help_Usage()
{
cat >&1 << EOF

[DESCRIPTION]
    Help user to learn about more usage of ${CvScriptName} 

[USAGE] 
    ${CvScriptName} [help]

[DETAILS] 
    help
        Offer user for that how to use this command.
EOF
}




function Fn_App_Handle()
{
  while [ $# -ne 0 ]; do
  case $1 in
    xx)
        echo "xx"
    ;;
    yy|zz)
        echo "yy|zz"
    ;;
    *)
        FnHelp | more
        exit 0 
    ;;
  esac
  shift
  done
}

function Fn_App_Handle2()
{
for ac_arg; do
    case $ac_arg in
        --hello=*)
            echo "ac_arg: $ac_arg"
            GvHello=`echo $ac_arg | sed -e "s/--hello=//g" -e "s/,/ /g"`
            echo "value: $GvHello"
            ;;
        *)
            ;;
    esac
done
}


declare -a  GvAllDeviceList
declare -a  GvAllDeviceBSizeList
declare -a  GvAllDeviceGBSizeList
declare -a  GvDeviceStatusList

function Fn_Device_Scan()
{
    LvDsAllDevices="$(fdisk -l -u | grep -E '^/dev/' | awk -F ' ' '{print $1}')"
    LvDsIdx=0
    for LvDsDev in ${LvDsAllDevices}; do
        GvAllDeviceList[${LvDsIdx}]="${LvDsDev}"
        GvDeviceStatusList[${LvDsIdx}]=0          # 0=umount  1=mount
        GvAllDeviceGBSizeList[${LvDsIdx}]=$(fdisk -l ${LvDsDev} 2>/dev/null | grep -E '^Disk /dev/' | awk -F ' ' '{print $3}')
        LvDsFlag=$(fdisk -l ${LvDsDev} 2>/dev/null | grep -E '^Disk /dev/' | awk -F ' ' '{print $4}')
        if [ x"${LvDsFlag}" = x"MB," ]; then
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
        fi
        if [ x"${LvDsFlag}" = x"KB," ]; then
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
        fi
        if [ x"${LvDsFlag}" = x"B," ]; then
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
            GvAllDeviceGBSizeList[${LvDsIdx}]=$(expr ${GvAllDeviceGBSizeList[${LvDsIdx}]} / 1024 )
        fi
 
        GvAllDeviceBSizeList[${LvDsIdx}]=$(fdisk -l ${LvDsDev} 2>/dev/null | grep -E '^Disk /dev/' | awk -F ' ' '{print $5}')
        LvDsIdx=$(expr ${LvDsIdx} + 1)
    done

    LvDsMountDevices="$(mount | grep -E '^/dev/' | awk -F ' ' '{print $1}')"
    for LvDsDev in ${LvDsMountDevices}; do
        LvDsFlag="$(ls -l ${LvDsDev} | awk -F ' ' '{print $1}' | grep -E '^l')"
        if [ ! -z "${LvDsFlag}" ]; then
            LvDsBasePath="$(dirname ${LvDsDev})"
            LvDsDev="$(ls -l ${LvDsDev} | awk -F ' ' '{print $11}')"
            LvDsBaseFile="$(basename ${LvDsDev})"
            LvDsBasePath="$(dirname ${LvDsBasePath}/${LvDsDev})" 
            LvDsBasePath=$(cd ${LvDsBasePath};pwd)
            LvDsDev="${LvDsBasePath}/${LvDsBaseFile}"
        fi
        LvDsIdx=0
        LvDsDevCount=${#GvAllDeviceList[@]}
        while [ ${LvDsIdx} -lt ${LvDsDevCount} ]; do
            if [ x"${GvAllDeviceList[${LvDsIdx}]}" = x"${LvDsDev}" ]; then
                GvDeviceStatusList[${LvDsIdx}]=1          # 0=umount  1=mount
                break;
            fi
            LvDsIdx=$(expr ${LvDsIdx} + 1)
        done
    done
}

## Fn_Device_GetMountPoint <iDev> <oMountPoint>
##
function Fn_Device_GetMountPoint()
{
    if [ $# -ne 2 ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to the bad parameter"
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvDgmpMountDevices="$(mount | grep -E '^/dev/' | awk -F ' ' '{print $1}')"
    for LvDgmpDev in ${LvDgmpMountDevices}; do
        LvDgmpMountPoint="$(mount | grep -E ${LvDgmpDev} | awk -F ' ' '{print $3}')"
        LvDgmpFlag="$(ls -l ${LvDgmpDev} | awk -F ' ' '{print $1}' | grep -E '^l')"
        if [ ! -z "${LvDgmpFlag}" ]; then
            LvDgmpBasePath="$(dirname ${LvDgmpDev})"
            LvDgmpDev="$(ls -l ${LvDgmpDev} | awk -F ' ' '{print $11}')"
            LvDgmpBaseFile="$(basename ${LvDgmpDev})"
            LvDgmpBasePath="$(dirname ${LvDgmpBasePath}/${LvDgmpDev})" 
            LvDgmpBasePath=$(cd ${LvDgmpBasePath};pwd)
            LvDgmpDev="${LvDgmpBasePath}/${LvDgmpBaseFile}"
        fi
        if [ x"$1" = x"${LvDgmpDev}" ]; then
            eval $2="${LvDgmpMountPoint}"
            return;
        fi
    done
    eval $2=""
    return; 
}


## Fn_Device_GetMountDiskUsedPercentage  <iDev> <oReport>
##
function Fn_Device_GetMountDiskUsedPercentage()
{
    if [ $# -ne 2 ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to the bad parameter"
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvDgmdupMountDevices="$(df -h | grep -E '^/dev/' | awk -F ' ' '{print $1}')"
    for LvDgmdupDev in ${LvDgmdupMountDevices}; do
        LvDgmdupUsedPercent="$(df -h | grep -E ${LvDgmdupDev} | awk -F ' ' '{print $5}')"
        LvDgmdupFlag="$(ls -l ${LvDgmdupDev} | awk -F ' ' '{print $1}' | grep -E '^l')"
        if [ ! -z "${LvDgmdupFlag}" ]; then
            LvDgmdupBasePath="$(dirname ${LvDgmdupDev})"
            LvDgmdupDev="$(ls -l ${LvDgmdupDev} | awk -F ' ' '{print $11}')"
            LvDgmdupBaseFile="$(basename ${LvDgmdupDev})"
            LvDgmdupBasePath="$(dirname ${LvDgmdupBasePath}/${LvDgmdupDev})" 
            LvDgmdupBasePath=$(cd ${LvDgmdupBasePath};pwd)
            LvDgmdupDev="${LvDgmdupBasePath}/${LvDgmdupBaseFile}"
        fi
        if [ x"$1" = x"${LvDgmdupDev}" ]; then
            eval $2="${LvDgmdupUsedPercent}"
            return;
        fi
    done
    eval $2=""
    return; 
}



function Fn_Device_List()
{
    LvDlDevIdx=0
    LvDlDevCount=${#GvAllDeviceList[@]}
    echo ""
    echo "Disk			 Used	 Status	 GB	 B		 Mount On"
    while [ ${LvDlDevIdx} -lt ${LvDlDevCount} ]; do
        [ ${GvDeviceStatusList[${LvDlDevIdx}]} -eq 0 ] && LvDlStatus="umount" || LvDlStatus="mount";
        LvDlMountPoint=""
        LvDlMountDiskUsedPercentage=""
        if [ x"${LvDlStatus}" = x"mount" ]; then
            Fn_Device_GetMountPoint "${GvAllDeviceList[${LvDlDevIdx}]}" LvDlMountPoint
            Fn_Device_GetMountDiskUsedPercentage "${GvAllDeviceList[${LvDlDevIdx}]}" LvDlMountDiskUsedPercentage
        fi
        echo "${GvAllDeviceList[${LvDlDevIdx}]}		"             \
             "${LvDlMountDiskUsedPercentage}	"                 \
             "${LvDlStatus}	"                                     \
             "${GvAllDeviceGBSizeList[${LvDlDevIdx}]}	"         \
             "${GvAllDeviceBSizeList[${LvDlDevIdx}]}	"         \
             "${LvDlMountPoint}"
        LvDlDevIdx=$(expr ${LvDlDevIdx} + 1)
    done
    echo ""
}


#-----------------------
# The Main Entry Point
#-----------------------

Fn_Device_Scan
Fn_Device_List

exit 0
####################################################################
#  Copyright (c) 2015.  lin_jie_long@126.com,  All rights reserved.
####################################################################


