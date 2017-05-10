#!/bin/bash
# Copyright(c) 2016-2100.  jiesen.liu.  All rights reserved.
#
#   FileName:     jll.analyzer.msaf.exo.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-12-02 13:38:05
#   ModifiedTime: 2016-12-03 10:41:38

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

GvCONF_RootTags="2k17_mtk_archer_m_refdev"
GvCONF_MarkFile="JllDebug_ExoPlayer.cookie"
GvCONF_DemoFile="MPEG-4洋洲梨花\ AVC\(High\@L3.1\)\ AAC\(HE-AAC\ \ LC\).mp4"
GvCONF_DemoFile="MPEG-4洋洲梨花 AVC(High@L3.1) AAC(HE-AAC  LC).mp4"


####################### BEGIN: Probe External Storage Space with ${GvCONF_MarkFile} #############
_GvCONF_SourcePath=""

declare -a _GvCONF_SrcList=(
    "/"
    "/c"
    "/d"
    "/e"
    "/f"
    "/g"
    "/h"
    "/i"
)

declare -i GvPageUnit=10
declare -a GvPageMenuUtilsContent
i=0
cnt=${#_GvCONF_SrcList[@]}
for((k=0; k<${cnt}; k++)){
echo
echo "JLL-Probe: Checking @ ${_GvCONF_SrcList[k]}"
    if [ x"${_GvCONF_SrcList[k]}" == x"/" ]; then
        _GvCONF_SrcList[k]=""
    fi 
echo "JLL-Probe-1: Checking ${_GvCONF_SrcList[k]}/${GvCONF_MarkFile}"
    __GvFLS=$(ls ${_GvCONF_SrcList[k]}/${GvCONF_MarkFile} 2>/dev/null)
    if [ x"${__GvFLS}" = x ]; then
        continue
    fi

echo "JLL-Probe-2: Checking ${_GvCONF_SrcList[k]}/dump_dev_by_jll"
    __GvFLS=$(ls ${_GvCONF_SrcList[k]} 2>/dev/null | grep dump_dev_by_jll)
    if [ x"${__GvFLS}" = x ]; then
        continue
    fi

echo "JLL-Probe-3: Checking ${_GvCONF_SrcList[k]}/Logs_BY_JLLDebug"
    __GvFLS=$(ls ${_GvCONF_SrcList[k]}/Logs_BY_JLLDebug 2>/dev/null)
    if [ x"${__GvFLS}" = x ]; then
        continue
    fi

    GvPageMenuUtilsContent[i++]="${__GvFLS%/*}"
}
unset _GvCONF_SrcList

if [ $i -eq 1 ]; then
    _GvCONF_SourcePath=${GvPageMenuUtilsContent[0]}
    unset GvPageMenuUtilsContent
    unset GvPageUnit
fi
if [ $i -gt 1 ]; then
    Lfn_PageMenuUtils _GvCONF_SourcePath  "Select" 7 4 "***** Selector (q: quit) *****"
    unset GvPageMenuUtilsContent
    unset GvPageUnit
fi
unset GvPageMenuUtilsContent
unset GvPageUnit

if [ x"${_GvCONF_SourcePath}" = x ]; then
    echo
    echo "JLL-Probe: Not found external storage device with file named ${GvCONF_MarkFile}"
    echo
    exit 0
else
    echo
    echo
    echo "JLL-Probe: Obtain SourceRootPath=${_GvCONF_SourcePath}"
    echo
    if [ x"${_GvCONF_SourcePath}" = x"/" ]; then
        _GvCONF_SourcePath=""
    fi
fi
####################### END: Probe External Storage Space with ${GvCONF_MarkFile} ###############




_GvCONF_RootPath=""
__GvCurrentPath=${JLLPATH%/*}
while [ x"${__GvCurrentPath}" != x -a x"${_GvCONF_RootPath}" = x ]; do
    echo "JLL-Probe: ${__GvCurrentPath}"
    cd ${__GvCurrentPath}
    __GvFLS=$(find . -maxdepth 1 -type d)
    __OldIFS=${IFS}
    IFS=$'\n'
    for __GvFL in ${__GvFLS}; do
        if [ x"${__GvFL#*./}" = x"${GvCONF_RootTags}" ]; then
            echo "JLL-Probe: Hit RootPath=${__GvCurrentPath}"
            _GvCONF_RootPath=${__GvCurrentPath}
            break
        fi
    done
    IFS=${__OldIFS}
    cd - >/dev/null
done

echo
echo "Jll-Probe: Obtain RootPath=${_GvCONF_RootPath}"
echo
if [ x"${_GvCONF_RootPath}" = x ]; then
    exit 0
fi


if [ x"${_GvCONF_RootPath}" = x"/" ]; then
    _GvCONF_RootPath=""
fi

if [ -e "${_GvCONF_RootPath}/${GvCONF_DemoFile}" ]; then
    GvCONF_DemoFile="${_GvCONF_RootPath}/${GvCONF_DemoFile}"
else
    if [ -e "${_GvCONF_SourcePath}/${GvCONF_DemoFile}" ]; then
        GvCONF_DemoFile="${_GvCONF_SourcePath}/${GvCONF_DemoFile}"
    fi
fi

if [ ! -e "${GvCONF_DemoFile}" ]; then
    echo
    echo "JLL-Probe: Not found DemoFile=${GvCONF_DemoFile}"
    echo
    exit 0
fi
echo
echo "JLL-Probe: found DemoFile=${GvCONF_DemoFile}"
echo
_GvRootFolder=msaf.exo.R_$(date +%Y.%m.%d_%H.%M)
echo "JLL-Check: RootFolder=${_GvRootFolder}"

if [ ! -e "${_GvCONF_RootPath}/JllAnalyzer" ]; then
    mkdir -pv ${_GvCONF_RootPath}/JllAnalyzer
fi
_GvRootFolder=${_GvCONF_RootPath}/JllAnalyzer/msaf.exo.R_$(date +%Y.%m.%d_%H.%M)
if [ ! -e "${_GvRootFolder}" ]; then
    mkdir -pv ${_GvRootFolder}
fi

cp -rvf ${_GvCONF_SourcePath}/dump_dev_by_jll   ${_GvRootFolder}/
cp -rvf ${_GvCONF_SourcePath}/Logs_BY_JLLDebug  ${_GvRootFolder}/
cp -rvf "${GvCONF_DemoFile}"                    ${_GvRootFolder}/

#cd ${_GvRootFolder}
#jll.generate.SpliceHexFile.sh
#if [ -e "$(pwd)/do_cmp_dev_orig.sh" ]; then
#    ./do_cmp_dev_orig.sh
#else
#    echo
#    echo "JLL-Working:  Failure due to not generate do_cmp_dev_orig.sh"
#    echo
#    exit 0
#fi
#cd - >/dev/null
echo
echo "Workspace=${_GvRootFolder}"
echo
echo "Thanks a lot"
echo
echo

