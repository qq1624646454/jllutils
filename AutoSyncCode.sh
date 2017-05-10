#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

GvProjectRoot=$(realpath ~)
exit 0
function Fn_Get_PhilipsTV_VersionInfo()
{
    declare -a GvMenuUtilsContent
    declare -i GvMenuUtilsContentCnt=0

    GvPrjRootPath=${GvProjectRoot}/workspace/aosp_6.0.1_r10_selinux
    #
    # Checking if the project is valid
    #
    LvpvVariable="${GvPrjRootPath}/device/tpvision"
    if [ ! -e "${LvpvVariable}" ]; then
        LvpvVariable="${GvPrjRootPath}/device/tpv"
    fi
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

#    Lfn_MenuUtils LvpvResult  "Select" 7 4 "***** PhilipsTV Project List (q: quit) *****"
    LvpvResult="QM16XE_U"
    LvpvSym="ro.tpvision.product.swversion"
    LvpvSoftwareVersion=$(cat ${LvpvVariable}/${LvpvResult}/system.prop | grep -i "${LvpvSym}" | awk -F '=' '{print $2}')
    clear
    echo ""
    echo "++++++ ${LvpvResult} - PhilipsTV Software Version ++++++"
    echo "  ${LvpvSym}=${LvpvSoftwareVersion}"
    echo ""
    eval $1=$(echo "${LvpvSoftwareVersion/QM163E\.0/${LvpvResult}_R0}")

    unset LvpvSym
    unset LvpvVariable
    unset GvMenuUtilsContent
    unset GvMenuUtilsContentCnt
}



### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

if [ -e "${GvProjectRoot}/workspace/aosp_6.0.1_r10_selinux" ]; then
    GvRevision=$(date +%Y%m%d%H%M%S)
    if [ -e "$(realpath ~/.sshconf/tpv_copyright@jielong.lin)" ]; then
        if [ -e "$(realpath ~/.ssh)" ]; then
            mv -vf ~/.ssh  ~/.ssh.R${GvRevision}
        fi
        cp -rvf ~/.sshconf/tpv_copyright@jielong.lin  ~/.ssh
    fi

    export PATH=~/.jllsystem/bin:$PATH
    cd ${GvProjectRoot}/workspace/aosp_6.0.1_r10_selinux
    rm -rf make.mtk_*.log
    rm -rf repo_sync_R*.log
    rm -rvf vicc_R*.log
    source build/envsetup.sh
    lunch QM16XE_U-userdebug
    sleep 1
    make -j8 mtk_clean 2>&1|tee make.mtk_clean_R${GvRevision}.log
    sleep 1
    /usr/local/bin/repo forall -c 'git clean -dfx; git reset --hard HEAD'
    sleep 1
    /usr/local/bin/repo sync 2>&1 | tee repo_sync_R${GvRevision}.log
    sleep 1
    if [ -e "$(realpath ~/.ssh.R${GvRevision})" ]; then
        if [ -e "$(realpath ~/.ssh)" ]; then
            rm -rvf ~/.ssh
        fi
        mv -vf ~/.ssh.R${GvRevision}  ~/.ssh
    fi
    sleep 1
    Fn_Get_PhilipsTV_VersionInfo GitVersion 
    if [ x"${GitVersion}" != x ]; then
        echo "Current Version is  ${GitVersion}" 2>&1 | tee -a repo_sync_R${GvRevision}.log
        GitVerID0="${GitVersion##*.}"
        GitVerID1="${GitVersion%.*}"
        GitVerID1="${GitVerID1##*.}"
        echo "ID0=$GitVerID0  ID1=$GitVerID1"
        GitVersion=${GitVersion/.${GitVerID1}.${GitVerID0}/}
        GitVerID1=$((GitVerID1-2))
        GitVersion=${GitVersion}.${GitVerID1}.${GitVerID0}
        echo "Previous Version is ${GitVersion}" 2>&1 | tee -a repo_sync_R${GvRevision}.log
        echo
        if [ x"${GitVersion}" = x ]; then
            echo
            echo "Error Due to Not Convert to the previous Git Version" | tee -a repo_sync_R${GvRevision}.log
            echo
            exit 0
        fi
        /usr/local/bin/repo forall -c "git checkout ${GitVersion}" | tee -a repo_sync_R${GvRevision}.log

    else
        echo
        echo "Error Due to Not Obtain Git Version" | tee -a repo_sync_R${GvRevision}.log
        echo
        exit 0
    fi
    sleep 1
    ~/.jllsystem/bin/vicc --auto  | tee vicc_R${GvRevision}.log
    sleep 1 
    make -j8 mtk_build 2>&1 | tee make.mtk_build_R${GvRevision}.log
fi

