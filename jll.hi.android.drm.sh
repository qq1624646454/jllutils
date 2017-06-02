#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.hi.android.drm.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-01 19:43:06
#   ModifiedTime: 2017-06-02 15:37:00
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

###############################################################
#   Library - Start
###############################################################

__CvPathFileForScript="`which $0`"

# ./xxx.sh
# ~/xxx.sh
# /home/xxx.sh
# xxx.sh
if [ x"${__CvPathFileForScript}" != x ]; then
    __CvScriptName=${__CvPathFileForScript##*/}
    __CvScriptPath=${__CvPathFileForScript%/*}
    if [ x"${__CvScriptPath}" = x ]; then
        __CvScriptPath="$(pwd)"
    else
        __CvScriptPath="$(cd ${__CvScriptPath};pwd)"
    fi
    if [ x"${__CvScriptName}" = x ]; then
        echo
        echo "JLL-Exit: Not recognize the command \"$0\", then exit - 0"
        echo
        exit 0
    fi 
else
    echo
    echo "JLL-Exit: Not recognize the command \"$0\", then exit - 1"
    echo
    exit 0
fi


function __Lfn_Sys_DbgEcho()
{
    LvSdeCallerFileLineNo=`caller 0 | awk '{print $1}'`
    LvSdeCallerFuncName="${FUNCNAME[1]}"
    if [ -z "$1" -o x"$1" = x"" ]; then
        echo "[jll] ${LvSdeCallerFileLineNo},${LvSdeCallerFuncName}"
    else
        echo "[jll] ${LvSdeCallerFileLineNo},${LvSdeCallerFuncName}: $1"
    fi
}

## Usage:
##     __Lfn_Sys_FuncComment 
function __Lfn_Sys_FuncComment()
{
    LvSfcCallerFunc="${FUNCNAME[1]}"
    LvSfcCallerFileLineNo=`caller 0 | awk '{print $1}'`
    LvSfcPattern="function ${LvSfcCallerFunc}"
    LvSfcLineNo=`grep -Enwr  "^${LvSfcPattern}" ${__CvScriptPath}/${__CvScriptName} \
                 | awk -F ':' '{print $1}'`
    if [ -z "${LvSfcLineNo}" ]; then
        __Lfn_Sys_DbgEcho "Sorry, Return due to the bad function format" 
        return;
    fi

    LvSfcCnt=0
    for LvSfcIdx in ${LvSfcLineNo}; do
        LvSfcCnt=`expr ${LvSfcCnt} + 1`
    done
    if [ ${LvSfcCnt} -ne 1 -o ${LvSfcLineNo} -lt 0 ]; then
        __Lfn_Sys_DbgEcho "Sorry, exit due to the invalid function comment format" 
        exit 0
    fi
    LvSfcContentLineNo=`expr ${LvSfcLineNo} - 1`
    if [ ${LvSfcContentLineNo} -lt 0 ]; then
        return;
    fi
    LvSfcContentStartLineNo=${LvSfcContentLineNo} 
    LvSfcContentEndLineNo=${LvSfcContentLineNo}

    while [ ${LvSfcContentStartLineNo} -ne 0 ]; do 
        LvTempContent=`sed -n "${LvSfcContentStartLineNo}p" ${__CvScriptPath}/${__CvScriptName} \
                       | grep -Ewn "^##"`
        if [ -z "${LvTempContent}" ]; then
            break;
        fi
        LvSfcContentStartLineNo=`expr ${LvSfcContentStartLineNo} - 1`
    done
 
    if [ ${LvSfcContentStartLineNo} -lt ${LvSfcContentEndLineNo} ]; then
        echo "Error LineNo : ${LvSfcCallerFileLineNo}"
        LvSfcContentStartLineNo=`expr ${LvSfcContentStartLineNo} + 1`
        sed -n "${LvSfcContentStartLineNo},${LvSfcContentEndLineNo}p" \
                ${__CvScriptPath}/${__CvScriptName} | sed 's/^#\{0,\}//'
    fi
    return;
}

  #----------------------------------
  # ANSI Control Code
  #----------------------------------
  #   \033[0m 关闭所有属性
  #   \033[01m 设置高亮度
  #   \033[04m 下划线
  #   \033[05m 闪烁
  #   \033[07m 反显
  #   \033[08m 消隐
  #   \033[30m -- \033[37m 设置前景色
  #   \033[40m -- \033[47m 设置背景色
  #   \033[nA 光标上移n行
  #   \033[nB 光标下移n行
  #   \033[nC 光标右移n行
  #   \033[nD 光标左移n行
  #   \033[y;xH 设置光标位置
  #   \033[2J 清屏
  #   \033[K  清除从光标到行尾的内容
  #   \033[s  保存光标位置
  #   \033[u  恢复光标位置
  #   \033[?25l 隐蔽光标
  #   \033[?25h 显示光标
  #-----------------------------------


  # 黑:Black
  # 红:Red
  # 绿:Green
  # 黄:Yellow
  # 蓝:Blue
  # 粉红:Pink
  # 海蓝:SeaBlue
  # 白:White

__CvAccOff="\033[0m"

__CvFgBlack="\033[30m"
__CvFgRed="\033[31m"
__CvFgGreen="\033[32m"
__CvFgYellow="\033[33m"
__CvFgBlue="\033[34m"
__CvFgPink="\033[35m"
__CvFgSeaBule="\033[36m"
__CvFgWhite="\033[37m"

__CvBgBlack="\033[40m"
__CvBgRed="\033[41m"
__CvBgGreen="\033[42m"
__CvBgYellow="\033[43m"
__CvBgBlue="\033[44m"
__CvBgPink="\033[45m"
__CvBgSeaBule="\033[46m"
__CvBgWhite="\033[47m"


## Usage:
##     __Lfn_Sys_DbgColorEcho [__CvFgXxx|__CvBgXxx] [__CvFgXxx|__CvBgXxx] [TEXT] 
## Details:
##     Print the format <TEXT> with fg-color named [__CvFgXxx] or bg-color named [__CvBgXxx]
## Parameter:
##     [__CvFgXxx]   - Foreground color
##     [__CvBgXxx]   - Background color 
##     [TEXT] - The text to display on the standard output device.
## Example:
##     __Lfn_Sys_DbgColorEcho ${__CvFgRed} ${__CvBgWhite} "hello World"
##
function __Lfn_Sys_DbgColorEcho()
{
    LvSdceCallerFileLineNo=`caller 0 | awk '{print $1}'`
    LvSdceCallerFuncName="${FUNCNAME[1]}"

    LvSdceFgColor=""
    LvSdceBgColor=""
    LvSdceText=""

    while [ $# -ne 0 ]; do
    case $1 in
    "\033[3"*)
        if [ -z "${LvSdceFgColor}" ]; then
            LvSdceFgColor=$1
        fi
        ;;
    "\033[4"*)
        if [ -z "${LvSdceBgColor}" ]; then
            LvSdceBgColor=$1
        fi
        ;;
    *)
        if [ -z "${LvSdceText}" ]; then
            LvSdceText=$1
        fi 
        ;;
    esac
    shift
    done

    if [ -z "${LvSdceText}" ]; then 
        echo -e "${__CvAccOff}${LvSdceFgColor}${LvSdceBgColor}"\
                "\b[jll] ${LvSdceCallerFileLineNo},${LvSdceCallerFuncName}${__CvAccOff}" 
    else
        echo -e "${__CvAccOff}${LvSdceFgColor}${LvSdceBgColor}"\
            "\b[jll] ${LvSdceCallerFileLineNo},${LvSdceCallerFuncName}: ${LvSdceText}${__CvAccOff}" 
    fi
}


## Usage:
##     __Lfn_Sys_ColorEcho [__CvFgXxx|__CvBgXxx] [__CvFgXxx|__CvBgXxx] [TEXT] 
## Details:
##     Print the format <TEXT> with fg-color named [__CvFgXxx] or bg-color named [__CvBgXxx]
## Parameter:
##     [__CvFgXxx]   - Foreground color
##     [__CvBgXxx]   - Background color 
##     [TEXT] - The text to display on the standard output device.
## Example:
##     __Lfn_Sys_ColorEcho ${__CvFgRed} ${__CvBgWhite} "hello World"
##
function __Lfn_Sys_ColorEcho()
{
    LvSceFgColor=""
    LvSceBgColor=""
    LvSceText=""

    while [ $# -ne 0 ]; do
    case $1 in
    "\033[3"*)
        if [ -z "${LvSceFgColor}" ]; then
            LvSceFgColor=$1
        fi
        ;;
    "\033[4"*)
        if [ -z "${LvSceBgColor}" ]; then
            LvSceBgColor=$1
        fi
        ;;
    *)
        if [ -z "${LvSceText}" ]; then
            LvSceText=$1
        fi 
        ;;
    esac
    shift
    done

    echo -e "${__CvAccOff}${LvSceFgColor}${LvSceBgColor}${LvSceText}${__CvAccOff}" 
}

## Usage:
##     Lfn_File_SearchSymbol_EX --Symbol=<SYMBOL>  \\
##         --File=<ScopeFiles...> \\
##         --Mode=<MatchMode> \\
##         --Path=<PathString>
##         --Ignore=<IgnorePath...> \\
## Details:
##     Search the <SYMBOL> from <ScopeFiles...> as <MatchMode>
##     output the matched information. 
## Parameter:
##     <SYMBOL> - specified symbol used for matching search file location.
##                Support for regular expression
##     <ScopeFile> - specified the files used to be searched.
##     <MatchMode> - specified the matching as precise or comprehensive.
##                   one of the values:
##                   0 - precise (default)
##                   1 - comprehensive
##     <PathString> - search path
##     <IgnorePath> - ignore path to match
## Notice:
##     IgnorePath is based on start with PathString, so PathString should be put before IgnorePath
##
## 
## Example:
##     Lfn_File_SearchSymbol_EX --Symbol="main"  --File=*.c \
##         --File=*.java --File=*.cpp --Mode=0 --Path=/home/jll --Ignore=test
##
function Lfn_File_SearchSymbol_EX()
{
    CvPreciseFlags="-Ewnr"
    CvComprehensiveFlags="-Enr"

    LvFssSymbol=""
    LvFssFile=""
    LvFssFileSwitch=1
    LvFssMode="0"
    LvFssIgnorePath=""
    LvFssIgnorePathCnt=0
    LvFssFlags="${CvPreciseFlags}"
    LvFssRootPath="$(pwd)"

    while [ $# -ne 0 ]; do
    case $1 in
    --Path=*)
        LvFssRootPath=`echo $1 | sed -e "s/--Path=//g" -e "s/,/ /g"`
        ;; 
    --Symbol=*)
        if [ -z "${LvFssSymbol}" ]; then
            LvFssSymbol=`echo $1 | sed -e "s/--Symbol=//g"`
        fi
        ;;
    --File=*)
        if [ x"${LvFssFileSwitch}" = x"1" ]; then
            LvFssTempFileString="`echo $1 | sed -e 's/--File=//g' -e 's/,/ /g'`"
            if [ x"${LvFssTempFileString}" = x"*" ]; then
                LvFssFile="*"
                LvFssFileSwitch=0
            else 
                if [ ! -z "${LvFssTempFileString}" ]; then
                    LvFssFile="${LvFssFile} ${LvFssTempFileString}"
                fi
            fi
        fi
        ;;
    --Mode=*)
        LvFssMode=`echo $1 | sed -e "s/--Mode=//g" -e "s/,/ /g"`
        ;;
    --Ignore=*)
        LvFssIgnores="`echo $1 | sed -e 's/--Ignore=//g' -e 's/,/ /g'`"
        if [ x"${LvFssIgnores}" != x ]; then
            LvFssIgnores="${LvFssIgnores//\"/}"
            if [ -e "${LvFssRootPath}/${LvFssIgnores}" ]; then
                #echo "jll: --Ignore=${LvFssIgnores}"
                if [ x"${LvFssIgnorePath}" = x ]; then
                  LvFssIgnorePath="-path \"${LvFssRootPath}/${LvFssIgnores}\""
                  LvFssIgnorePathCnt=1
                else
                  LvFssIgnorePath="${LvFssIgnorePath} -o -path \"${LvFssRootPath}/${LvFssIgnores}\""
                  LvFssIgnorePathCnt=$((LvFssIgnorePathCnt+1))
                fi
            else
                echo "jll: not present ignore path=${LvFssRootPath}/${LvFssIgnores}"
            fi
        fi
        ;;
    *)
        ;;
    esac
    shift
    done
    #echo "jll: --Ignore=${LvFssIgnorePath}"
    if [ x"${LvFssIgnorePath}" != x ]; then
        if [ ${LvFssIgnorePathCnt} -gt 1 ]; then
            LvFssIgnorePath="\\( ${LvFssIgnorePath} \\) -prune -o"
        else
            if [ ${LvFssIgnorePathCnt} -eq 1 ]; then
                LvFssIgnorePath="${LvFssIgnorePath} -prune -o"
            else
                LvFssIgnorePath=""
            fi
        fi
    fi

    if [ -z "${LvFssSymbol}" -o -z "${LvFssFile}" ]; then
        __Lfn_Sys_FuncComment
        return;
    fi

    if [ x"${LvFssMode}" = x"1" ]; then
        LvFssFlags=${CvComprehensiveFlags}
    fi

    if [ x"${LvFssFile}" = x"*" ]; then
        echo
        echo
        echo "jll: maybe take more long time to find all files by *"
      if [ x"${CONF_dbgEnable}" = x"1" ]; then
        __Lfn_Sys_ColorEcho ${__CvFgPink} ${__CvBgBlack} \
            "find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -print"
        __Lfn_Sys_ColorEcho ${__CvFgRed} ${__CvBgBlack} \
            "---> grep ${LvFssFlags} \"${LvFssSymbol}\""
      fi
        __OldIFS=${IFS}
        IFS=$'\n'
        for LvFssLine in \
        `eval find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -print`; do
            LvFssMatch=`grep ${LvFssFlags} "${LvFssSymbol}" "${LvFssLine}" --color=always`
            if [ x"$?" = x"0" ]; then
                __Lfn_Sys_ColorEcho  ${__CvFgBlack}  ${__CvBgWhite}    " ${LvFssLine} "
                __Lfn_Sys_ColorEcho  "${LvFssMatch}"
                echo
            fi
        done
        echo
        __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgYellow} " Done"
        echo
        exit 0
    fi


    for LvFssFl in ${LvFssFile}; do
      if [ x"${CONF_dbgEnable}" = x"1" ]; then
        echo
        echo
        __Lfn_Sys_ColorEcho ${__CvFgPink} ${__CvBgBlack} \
            "find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -name \"${LvFssFl}\" -print"
        __Lfn_Sys_ColorEcho ${__CvFgRed} ${__CvBgBlack} \
            "---> grep ${LvFssFlags} \"${LvFssSymbol}\""
      fi
        __OldIFS=${IFS}
        IFS=$'\n'
        for LvFssLine in \
        `eval find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -name "${LvFssFl}" -print`; do
            LvFssMatch=`grep ${LvFssFlags} "${LvFssSymbol}" "${LvFssLine}" --color=always`
           if [ x"$?" = x"0" ]; then
                __Lfn_Sys_ColorEcho  ${__CvFgBlack}  ${__CvBgWhite}    " ${LvFssLine} "
                __Lfn_Sys_ColorEcho  "${LvFssMatch}"
                echo
            fi
        done
        IFS=${__OldIFS}
    done
    if [ x"${CONF_dbgEnable}" = x"1" ]; then
        echo
        __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgYellow} " Done"
        echo
    fi
}

###############################################################
#   Library - End 
###############################################################







#
# Recognize DRM scheme  
#
__DRM_SCHEME=
for ac_arg; do
    case $ac_arg in
      [pP][lL][aA][yY][rR][eE][aA][dD][yY]|[pP][rR])
          echo "JLL-Found: maybe drm scheme is playready"
          __DRM_SCHEME=playready
          ;;
      [wW][iI][dD][eE][vV][iI][nN][eE]|[wW][vV])
          echo "JLL-Found: maybe drm scheme is widevine"
          __DRM_SCHEME=widevine
          ;;
      *)
          ;;
    esac
done

if [ x"${__DRM_SCHEME}" = x ]; then
    echo
    echo "JLL-Exit: not found the legal DRM scheme, then exit"
    echo 
    exit 0
fi

echo
echo "JLL-Probe: collecting the legal Android project under the current path with .repo "
pwd
# Find the same level path which contains .repo folder
Lfn_Sys_GetSameLevelPath  GvPrjRootPath ".repo"
if [ x"${GvPrjRootPath}" = x -o ! -e "${GvPrjRootPath}" ]; then
    echo "JLL-Probe: not obtain legal Android project from the current path..."
    echo "JLL-Probe: collecting all the legal Android projects under ${HOME} with .repo "
    echo

    declare -i GvPageUnit=10
    declare -i GvMenuID=0
    declare -a GvPageMenuUtilsContent
    __ListProjects=$(find ${HOME} -maxdepth 4 -type d -a -name .repo)
    for __ListProject in ${__ListProjects}; do
        __ListProject=${__ListProject%%/.repo}
        if [ x"${__ListProject}" != x -a -e "${__ListProject}" ]; then
            GvPageMenuUtilsContent[GvMenuID++]="${__ListProject}" 
        fi 
    done
    if [ ${GvMenuID} -gt 0 ]; then
        Lfn_PageMenuUtils GvPrjRootPath "Select" 7 4 "***** Using Android Project (q: quit) *****"
    fi
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
    [ x"${GvMenuID}" != x ] && unset GvMenuID
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
fi
if [ x"${GvPrjRootPath}" = x -o ! -e "${GvPrjRootPath}" ]; then
    __Lfn_Sys_DbgColorEcho ${__CvBgBlack} ${__CvFgRed}  "Path=\"${GvPrjRootPath}\"" 
    __Lfn_Sys_DbgColorEcho ${__CvBgBlack} ${__CvFgRed}  "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo
clear
echo
__Lfn_Sys_ColorEcho ${__CvBgSeaBule} ${__CvFgBlack} \
    "JLL-Probe: \"${GvPrjRootPath}\" is selected to use"
echo
echo
__Lfn_Sys_ColorEcho ${__CvBgSeaBule} ${__CvFgBlack} \
    "JLL-Probe: checking if \"${__DRM_SCHEME}\" is legal or not"
echo

#
# Find the legal resources 
#
declare -a CONF_lstFile=(
        "frameworks/av/drm"
        "frameworks/av/media"
        "frameworks/av/services/mediadrm"
        "frameworks/av/services/mediacodec"
        "frameworks/av/services/mediaresourcemanager"
        "frameworks/av/services/mediaextractor"
        "frameworks/base/drm"
        "frameworks/base/media"
        "frameworks/native/include/media"
        "device/tpvision/common/plf/mediaplayer/av/comps"
        "device/tpvision/common/plf/mediaplayer/av/include"
)
declare -i CONF_lstFileSZ=${#CONF_lstFile[@]}
 
case ${__DRM_SCHEME} in
playready)
    CONF_lstFile[CONF_lstFileSZ++]="vendor/playready"
    ;;
widevine)
    CONF_lstFile[CONF_lstFileSZ++]="vendor/widevine"
    ;;
*)
    echo
    echo "JLL-Exit: not support \"${__DRM_SCHEME}\", then exit"
    echo
    exit 0
    ;;
esac

declare -a __lstRes
declare -i __lstResSZ=0
#
# Improve the handle speed.
#
case ${GvPrjRootPath##*/} in
2k15_mtk_1446_1_devprod|aosp_6.0.1_r10_selinux)
  for((i=0;i<CONF_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/${CONF_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/${CONF_lstFile[i]}"
      fi
  }
  ;;
*)
  ;;
esac


__FIND_PATHS="-regex \".*/?${CONF_lstFile[0]}\""
for ((i=1;i<CONF_lstFileSZ;i++)) {
    __FIND_PATHS="${__FIND_PATHS} -o -regex \".*/?${CONF_lstFile[i]}\""
}

__lstCmd="find ${GvPrjRootPath} \\( -regex \".*/?out\" -o -regex \".*/\..*\" \\) -prune -o -type d -a \\( ${__FIND_PATHS} \\) -print"
echo
echo ${__lstCmd}
echo
echo -ne "    Progressing For Collecting the legal resources...  "
Lfn_Sys_Rotate &
__RotateBgPID=$!
__lstTargets=$(eval ${__lstCmd})
kill -9 ${__RotateBgPID}
sleep 1
clear

[ x"${__lstTargets}" != x ] && \
__Lfn_Sys_ColorEcho ${__CvBgSeaBule} ${__CvFgBlack} \
    "======== The Legal Resources As Follows ========"
for __lstT in ${__lstTargets}; do
    echo  "   ${__lstT}"
    __lstRes[__lstResSZ++]="${__lstT}"
done

[ x"${CONF_lstFile}" != x ] && unset CONF_lstFile
[ x"${CONF_lstFileSZ}" != x ] && unset CONF_lstFileSZ
[ x"${__FIND_PATHS}" != x ] && unset __FIND_PATHS
[ x"${__lstCmd}" != x ] && unset __lstCmd
[ x"${__RotateBgPID}" != x ] && unset __RotateBgPID 
[ x"${GvPrjRootPath}" != x ] && unset GvPrjRootPath
[ x"${__lstTargets}" != x ] && unset __lstTargets 
 
[ ${__lstResSZ} -lt 1 ] && __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgBlack} \
    "JLL-Exit: Not found any legal Resources then exit"; exit 0


__szConsiderFileType=""
__nLstConsiderFileType=${#CONF_lstFileType[@]}
for((i=0; i<__nLstConsiderFileType; i++)) {
    __szConsiderFileType="${__szConsiderFileType} --File=\"${CONF_lstFileType[i]}\""
}

echo
if [ x"${__szConsiderFileType}" = x ]; then
    __szConsiderFileType="*"
fi
echo -ne "${__CvAccOff}${__CvFgPink}${__CvBgBlack}JLL-FileType:${__CvAccOff}" 
echo -e "${__szConsiderFileType// --File=/\\n}" | sed "s/\"//g"
echo


echo
echo -e "${__CvAccOff}${__CvFgPink}${__CvBgBlack}JLL-Search-RootPath:${__CvAccOff}" 
echo -e "${CONF_szRootPath}"
echo

if [ x"${CONF_lstIgnorePath}" != x ]; then
    __nLstIgnorePath=${#CONF_lstIgnorePath[@]}
    for((i=0; i<__nLstIgnorePath; i++)) {
        __szIgnorePath="${__szIgnorePath} --Ignore=\"${CONF_lstIgnorePath[i]}\""
    }
    echo
    echo -ne "${__CvAccOff}${__CvFgPink}${__CvBgBlack}JLL-Ignore:${__CvAccOff}" 
    echo -e "${__szIgnorePath// --Ignore=/\\n}" | sed "s/\"//g"
    echo
else
    __szIgnorePath=""
fi


__nRelatedAPIs=${#CONF_lstRelatedAPIs[@]}
for((i=0; i<__nRelatedAPIs; i++)) {
   Lfn_File_SearchSymbol_EX \
       ${__szConsiderFileType} \
       --Symbol="${CONF_lstRelatedAPIs[i]}" \
       --Mode=1 \
       --Path="${CONF_szRootPath}" \
       ${__szIgnorePath}
}


