#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


#
# Location the which project associated with PhilipsTV
#
GvRootPath=$(realpath ~)
if [ ! -e "${GvRootPath}" ]; then
    Lfn_Sys_DbgEcho "Sorry, Exit due to dont exist user \"~\" path"
    exit 0
fi

# Find the same level path which contains .repo folder
Lfn_Sys_GetSameLevelPath  GvPrjRootPath ".repo"
if [ ! -e "${GvPrjRootPath}" ]; then
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Path=\"${GvPrjRootPath}\"" 
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

GvRepoPath="${GvRootPath##${GvPrjRootPath}}"




function Fn_PhilipsTV_VersionInfo()
{
    declare -a GvMenuUtilsContent
    declare -i GvMenuUtilsContentCnt=0
    #
    # Checking if the project is valid
    #
    LvpvVariable="${GvPrjRootPath}/android/l-mr1-tv-dev-archer/device/tpv"
    if [ -e "${LvpvVariable}" ]; then
        LvpvSubVariable="$(cd ${LvpvVariable};ls)"
        for LvpvSubV in ${LvpvSubVariable}; do
            LvpvFlags="${LvpvVariable}/${LvpvSubV}/system.prop"
            if [ -e "${LvpvFlags}" ]; then
               GvMenuUtilsContent[GvMenuUtilsContentCnt]="${LvpvSubV}"
               GvMenuUtilsContentCnt=$(( GvMenuUtilsContentCnt + 1 ))
            fi
            unset LvpvFlags
        done
        unset LvpvSubV
        unset LvpvSubVariable
        if [ ${GvMenuUtilsContentCnt} -lt 1 ]; then
            Lfn_Sys_DbgEcho "Checking @ ${LvpvVariable}"
            Lfn_Sys_DbgEcho "Checking Fail: Do not find any valid project"
            unset GvMenuUtilsContent
            unset GvMenuUtilsContentCnt
            unset LvpvVariable
            unset GvPrjRootPath
            unset GvRootPath
            exit 0
        fi
        echo "Checking OK: ${LvpvVariable}"
    else
        Lfn_Sys_DbgEcho "Checking Fail: ${LvpvVariable}"
        unset GvMenuUtilsContent
        unset GvMenuUtilsContentCnt
        unset LvpvVariable
        unset GvPrjRootPath
        unset GvRootPath
        exit 0
    fi

    Lfn_MenuUtils LvpvResult  "Select" 7 4 "***** PhilipsTV Project List (q: quit) *****"
    LvpvSym="ro.tpvision.product.swversion"
    LvpvSoftwareVersion=$(cat ${LvpvVariable}/${LvpvResult}/system.prop | grep -i "${LvpvSym}" | awk -F '=' '{print $2}')
    clear
    echo ""
    echo "++++++ ${LvpvResult} - PhilipsTV Software Version ++++++"
    echo "  ${LvpvSym}=${LvpvSoftwareVersion}"
    echo ""

    unset LvpvSym
    unset LvpvVariable
    unset GvMenuUtilsContent
    unset GvMenuUtilsContentCnt
}


##
##    Fn_PhilipsTV_Compilation
##
function Fn_PhilipsTV_Compilation()
{
    #
    # Checking if the project is valid
    #
    LvpcVariable="${GvPrjRootPath}/android/l-mr1-tv-dev-archer/device/tpv"
    LvpcExecShell="${LvpcVariable}/common/sde/upg/build_2k16_msaf.sh"
    if [ ! -e "${LvpcExecShell}" ]; then
        Lfn_Sys_DbgEcho "Checking Fail: dont exist \" ${LvpcExecShell}\""
        unset LvpcExecShell
        unset LvpcVariable
        exit 0 
    fi

    declare -a GvMenuUtilsContent
    declare -i GvMenuUtilsContentCnt=0
 
    if [ -e "${LvpcVariable}" ]; then
        LvpcSubVariable="$(cd ${LvpcVariable};ls)"
        for LvpcSubV in ${LvpcSubVariable}; do
            LvpcFlags="${LvpcVariable}/${LvpcSubV}/system.prop"
            if [ -e "${LvpcFlags}" ]; then
               GvMenuUtilsContent[GvMenuUtilsContentCnt]="${LvpcSubV}"
               GvMenuUtilsContentCnt=$(( GvMenuUtilsContentCnt + 1 ))
            fi
            unset LvpcFlags
        done
        unset LvpcSubV
        unset LvpcSubVariable
        if [ ${GvMenuUtilsContentCnt} -lt 1 ]; then
            Lfn_Sys_DbgEcho "Checking @ ${LvpcVariable}"
            Lfn_Sys_DbgEcho "Checking Fail: Do not find any valid project"
            unset GvMenuUtilsContent
            unset GvMenuUtilsContentCnt
            unset LvpcExecShell
            unset LvpcVariable
            unset GvPrjRootPath
            unset GvRootPath
            exit 0
        fi
        echo "Checking OK: ${LvpcVariable}"
    else
        Lfn_Sys_DbgEcho "Checking Fail: ${LvpcVariable}"
        unset GvMenuUtilsContent
        unset GvMenuUtilsContentCnt
        unset LvpcExecShell
        unset LvpcVariable
        unset GvPrjRootPath
        unset GvRootPath
        exit 0
    fi
    unset LvpcVariable

    while [ 1 -eq 1 ]; do
        Lfn_MenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Project List (q: quit) *****"
        LvpcOptionProduct=$(cat ${LvpcExecShell} | grep "THIS_BUILD=${LvpcResult}" | awk -F ')' '{print $1}')
        LvpcOptionProduct="$(echo ${LvpcOptionProduct})"
        if [ x"${LvpcOptionProduct}" = x ]; then
            continue
        fi
        break
    done
    unset GvMenuUtilsContent
    unset GvMenuUtilsContentCnt

    declare -a GvMenuUtilsContent=(
        "userdebug: It will enable the most debugging features for tracing the platform."
        "user:      It is offically release, and it only disable debugging features."
    )
    Lfn_MenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Product Type (q: quit) *****"
    if [ x"${LvpcResult}" = x"${GvMenuUtilsContent[0]}" ]; then
        LvpcOptionBuild=userdebug 
    fi
    if [ x"${LvpcResult}" = x"${GvMenuUtilsContent[1]}" ]; then
        LvpcOptionBuild=user 
    fi
    unset GvMenuUtilsContent

    echo ""
    echo "Platform: ${LvpcOptionProduct}"
    echo "Build:    ${LvpcOptionBuild}"

    LvpcCmdPath=$(dirname ${LvpcExecShell})
    LvpcCmdName=$(basename ${LvpcExecShell})
    read -p "Compilation this project if press [y]:  " -n 1  LvpcChoice
    if [ x"${LvpcChoice}" = x"y" ]; then
        cd ${LvpcCmdPath}
        ./${LvpcCmdName} -p ${LvpcOptionProduct} -b ${LvpcOptionBuild} -n 8
    fi 
    unset LvpcExecShell
}



declare -a GvMenuUtilsContent=(
    "Query Software Version"
    "Compilation"
)
Lfn_MenuUtils GvResult  "Select" 7 4 "***** MENU (q: quit no matter what) *****"

if [ x"${GvResult}" = x"${GvMenuUtilsContent[0]}" ]; then
    unset GvMenuUtilsContent
    unset GvMenuUtilsContentCnt
    clear
    echo
    Fn_PhilipsTV_VersionInfo
    echo
    exit 0
fi

if [ x"${GvResult}" = x"${GvMenuUtilsContent[1]}" ]; then
    unset GvMenuUtilsContent
    unset GvMenuUtilsContentCnt
    clear
    echo
    Fn_PhilipsTV_Compilation
    echo
    exit 0
fi

unset GvMenuUtilsContent
unset GvMenuUtilsContentCnt
exit 0
 
