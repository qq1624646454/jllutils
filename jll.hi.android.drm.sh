#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.hi.android.drm.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-01 19:43:06
#   ModifiedTime: 2017-06-07 08:57:56
#
# History:
#   2017-6-5| Created
#   2017-6-6| Intake File Type Selecting For Customization

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

#
# |---JLLCFG_Render_Range---|---JLLCFG_Render_Range---|
# |_________________________|_________________________|
# Start                     Target                    End
#
JLLCFG_Render_Range=6

# 0: disable
# 1: show the cmdline processing
# 2: only show ranges and segments
JLLCFG_dbgEnable=0


#
# Find the legal resources 
#
declare -a JLLCFG_lstFile=(
        "frameworks/av/drm"
        "frameworks/av/media"
        "frameworks/base/drm"
        "frameworks/base/media"
        "frameworks/native/include/media"
        "device/tpvision/common/plf/mediaplayer/av/comps"
        "device/tpvision/common/plf/mediaplayer/av/include"
)

# Intake FileType Selector from vicc project
# LanguageName  ExuberantCtags  Cscope  FileClasses
declare -a GvVimIDE_Settings=(
  "Asm"     "--Asm-kinds=+dlmt"                             " "   "*.s *.S *.inc"
  "C"       "--C-kinds=+cdefgmnpstuv"                       " "   "*.c *.C *.h"
  "C++"     "--C++-kinds=+cdefgmnpstuv"                     " "   "*.cpp *.cc *.CC *.h *.hpp"
  "Java"    "--Java-kinds=+cefgimp --langmap=java:+.aidl"   " "   "*.java *.aidl"
  "Make"    "--Make-kinds=+m"                               " "   "*.mak Makefile makefile *.mk"
  "Header"  "--C++-kinds=+cdefgmnpstuv"                     " "   "*.h *.hpp *.inc"
)








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
    CvPreciseFlags="-Ewn"
    CvComprehensiveFlags="-En"

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
            LvFssSymbol="`echo $1 | sed -e \"s/--Symbol=//g\"`"
        fi
        ;;
    --File=*)
        if [ x"${LvFssFileSwitch}" = x"1" ]; then
            LvFssTempFileString="`echo $1 | sed -e 's/--File=//g' -e 's/,/ /g'`"
            if [ x"${LvFssTempFileString}" = x"*" ]; then
                LvFssFile="*"
                LvFssFileSwitch=0
            else 
                if [ x"${LvFssTempFileString}" != x ]; then
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
        echo "JLL-Return: LvFssSymbol=\"${LvFssSymbol}\" or LvFssFile=${LvFssFile}"
        __Lfn_Sys_FuncComment
        exit 0;
    fi

    if [ x"${LvFssMode}" = x"1" ]; then
        LvFssFlags=${CvComprehensiveFlags}
    fi

    if [ x"${LvFssFile}" = x"*" ]; then
        echo
        echo
        echo "jll: maybe take more long time to find all files by *"
        if [ x"${JLLCFG_dbgEnable}" = x"1" ]; then
          __Lfn_Sys_ColorEcho ${__CvFgPink} ${__CvBgBlack} \
              "find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -print"
          __Lfn_Sys_ColorEcho ${__CvFgRed} ${__CvBgBlack} \
              "---> grep ${LvFssFlags} -i \"${LvFssSymbol}\""
        fi

        LvFssSymbol="${LvFssSymbol//\"/\\\"}"
        LvFssSymbol="${LvFssSymbol//\'/\\\'}"
 
        __OldIFS=${IFS}
        IFS=$'\n'
        for LvFssLine in \
        `eval find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -print`; do
            __CMDLINE="grep -C ${JLLCFG_Render_Range} ${LvFssFlags}"
            __CMDLINE="${__CMDLINE} -i \"${LvFssSymbol}\" \"${LvFssLine}\" --color=always"
            LvFssMatch=`eval ${__CMDLINE}`
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

    declare -a __lstFindFiles
    declare -i __iFindFiles=0
    for LvFssFl in ${LvFssFile}; do
        __lstFindFiles[__iFindFiles++]="${LvFssFl}"
    done
    [ x"${LvFssFile}" != x ] && unset LvFssFile
    if [ x"${JLLCFG_dbgEnable}" = x"1" ]; then
        echo "JLL-DBG| Total Finding Files is ${__iFindFiles}"
    fi

    for((iFF=0;iFF<__iFindFiles;iFF++)) {
        [ x"${__lstFiles}" != x ] && unset __lstFiles
        [ x"${__iFiles}" != x ] && unset __iFiles
        declare -a __lstFiles
        declare -i __iFiles=0

        # Collecting all relative files according to __iFindFiles[ ]
        __CMDLINE="find ${LvFssRootPath} ${LvFssIgnorePath} -type f "
        __CMDLINE="${__CMDLINE} -a -name \"${__lstFindFiles[iFF]}\" -print"
        [ x"${JLLCFG_dbgEnable}" = x"1" ] && echo "JLL-CMDLINE-1: ${__CMDLINE}"
        __AllFLs=`eval ${__CMDLINE}`
        __OldIFS="${IFS}"
        IFS=$'\n'
        for LvFssLine in ${__AllFLs}; do
            __lstFiles[__iFiles++]="${LvFssLine}"
        done
        IFS="${__OldIFS}"
        [ x"${__AllFLs}" != x ] && unset __AllFLs

        for((iF=0;iF<__iFiles;iF++)) {
            __CMDLINE="grep ${LvFssFlags} -i \"${LvFssSymbol}\""
            __CMDLINE="${__CMDLINE} \"${__lstFiles[iF]}\" --color=never"
            [ x"${JLLCFG_dbgEnable}" = x"1" ] && echo "JLL-CMDLINE-2: ${__CMDLINE}"
            LvFssMatch=`eval ${__CMDLINE} 2>/dev/null`
            if [ x"${LvFssMatch}" != x ]; then
                [ x"${__lstRanges}" != x ] && unset __lstRanges
                [ x"${__iRanges}" != x ] && unset __iRanges
                declare -a __lstRanges
                declare -i __iRanges=0
                __FileEnd=$(sed -n '$=' ${__lstFiles[iF]})
                echo
                echo
                echo
                #
                # Renderring the file details
                #
                __Lfn_Sys_ColorEcho ${__CvFgBlack}  ${__CvBgWhite}  \
                                    "${__lstFiles[iF]##${GvPrjRootPath}/}"

                __OldIFS="${IFS}"
                IFS=$'\n'
                #There maybe are the multise lines matched.
                for LvFssM in ${LvFssMatch}; do
                    __RenderTarget=$(echo ${LvFssM%%:*} | sed -n '/^[0-9][0-9]*$/p')
                    if [ x"${__RenderTarget}" != x ]; then
                        if [ ${__RenderTarget} -le ${JLLCFG_Render_Range} ]; then
                            __RenderStart=1
                        else
                            __RenderStart=$((__RenderTarget-JLLCFG_Render_Range))
                        fi
                        __RenderEnd=$((__RenderTarget+JLLCFG_Render_Range))
                        if [ ${__RenderEnd} -gt ${__FileEnd} ]; then
                            __RenderEnd=${__FileEnd}
                        fi
                        # Prevent from adding the same item
                        __bAdd=1
                        iR=$((__iRanges-3))
                        while [ ${iR} -ge 0 ]; do
                            if [ ${__lstRanges[iR+2]} -eq ${__RenderEnd} \
                              -a ${__lstRanges[iR+1]} -eq ${__RenderTarget} \
                              -a ${__lstRanges[iR]} -eq ${__RenderStart} \
                            ]; then
                                __bAdd=0
                                break
                            fi 
                            iR=$((iR-3))
                        done
                        if [ ${__bAdd} -eq 1 ]; then
                            __lstRanges[__iRanges++]="${__RenderStart}"
                            __lstRanges[__iRanges++]="${__RenderTarget}"
                            __lstRanges[__iRanges++]="${__RenderEnd}"
                        fi
                    else
                        echo
                        echo "JLL-Warning| Matched Line But not obtain the line number:"
                        echo "${LvFssM}"
                        [ x"${__lstRanges}" != x ] && unset __lstRanges
                        [ x"${__iRanges}" != x ] && unset __iRanges
                        [ x"${__iFiles}" != x ] && unset __iFiles
                        [ x"${__lstFiles}" != x ] && unset __lstFiles
                        [ x"${__iFindFiles}" != x ] && unset __iFindFiles
                        [ x"${__lstFindFiles}" != x ] && unset __lstFindFiles
                        IFS="${__OldIFS}"
                        exit 0
                    fi
                done
                IFS="${__OldIFS}"

                [ x"${__lstSegment}" != x ] && unset __lstSegment
                [ x"${__iSegment}" != x ] && unset __iSegment
                declare -a __lstSegment
                declare -i __iSegment=0

                if [ ${__iRanges} -gt 3 ]; then
                    # Sorted order
                    for((is=0;is<__iRanges;is+=3)) {
                        for((js=is+3;js<__iRanges;js+=3)) {
                            if [ ${__lstRanges[is]} -gt ${__lstRanges[js]} ]; then
                        #echo "<-$is:${__lstRanges[is]}-${__lstRanges[is+1]}-${__lstRanges[is+2]}"
                        #echo "->$js:${__lstRanges[js]}-${__lstRanges[js+1]}-${__lstRanges[js+2]}"
                                __RenderStart=${__lstRanges[is]}
                                __RenderTarget=${__lstRanges[is+1]}
                                __RenderEnd=${__lstRanges[is+2]}
                                __lstRanges[is]=${__lstRanges[js]}
                                __lstRanges[is+1]=${__lstRanges[js+1]}
                                __lstRanges[is+2]=${__lstRanges[js+2]}
                                __lstRanges[js]=${__RenderStart}
                                __lstRanges[js+1]=${__RenderTarget}
                                __lstRanges[js+2]=${__RenderEnd}
                            fi
                        }
                    }

                    __SegSP=${__lstRanges[0]}
                    __SegEP=${__lstRanges[2]}
                    # Combine the override ranges
                    for((iC=3;iC<__iRanges;iC+=3)){
                        __NextSegSP=${__lstRanges[iC]}
                        __NextSegEP=${__lstRanges[iC+2]}
                        if [ ${__NextSegSP} -ge ${__SegSP} -a ${__NextSegSP} -le ${__SegEP} ]; then
                            # Case-1 :
                            # Seg    : |--------------|
                            # NextSeg:   |-----------|
                            # Result : |--------------| <=> Seg.Start to Seg.End
                            if [ ${__NextSegEP} -le ${__SegEP} ]; then
                                continue
                            fi
                            # Case-2 :
                            # Seg    : |--------------|
                            # NextSeg:   |--------------|
                            # Result : |----------------| <=> Seg.Start to NextSeg.End
                            __SegEP=${__NextSegEP}
                            continue
                        fi
                        if [ ${__NextSegSP} -gt ${__SegSP} ]; then
                            # Case-3 :
                            # Seg    : |--------------|
                            # NextSeg:                   |-----------|
                            # Result : |--------------|  |-----------|
                            __lstSegment[__iSegment++]=${__SegSP}
                            __SegSP=${__NextSegSP}
                            __lstSegment[__iSegment++]=${__SegEP}
                            __SegEP=${__NextSegEP}
                            continue 
                        fi
                    }
                    __lstSegment[__iSegment++]=${__SegSP}
                    __lstSegment[__iSegment++]=${__SegEP}
                else ### else for if [ ${__iRanges} -gt 3 ]; then
                    __lstSegment[__iSegment++]=${__lstRanges[0]}
                    __lstSegment[__iSegment++]=${__lstRanges[2]}
                fi ### end for if [ ${__iRanges} -gt 3 ]; then

                # Sort order for keyword lines
                for((iKL=0;iKL<__iRanges;iKL+=3)) {
                    for((jKL=iKL+3;jKL<__iRanges;jKL+=3)) {
                        if [ ${__lstRanges[iKL+1]} -gt ${__lstRanges[jKL+1]} ]; then
                            __kwlTemp=${__lstRanges[iKL+1]}
                            __lstRanges[iKL+1]=${__lstRanges[jKL+1]}
                            __lstRanges[jKL+1]=${__kwlTemp}
                        fi
                    }
                }

                if [ x"${JLLCFG_dbgEnable}" == x"2" ]; then
                    echo "<<<<< Obtaining the below ranges:"
                    for((iT=0;iT<__iRanges;iT+=3)) {
                        echo "Raw-ITEM: ${__lstRanges[iT]}===${__lstRanges[iT+2]}"
                    }
                    echo ">>>>> Combine those ranges into legal segments:"
                    for((iTS=0;iTS<__iSegment;iTS+=2)) {
                        echo "New-ITEM: ${__lstSegment[iTS]}===${__lstSegment[iTS+1]}"
                    }
                    # Remark the high-light keywords
                    for((iK=0;iK<__iRanges;iK+=3)) {
                        iKK=$((iK+1))
                        echo "Key: ${__lstRanges[iKK]}"
                    }
                fi

                #
                # Renderring the result with keyword color
                #
                for((iSR=0;iSR<__iSegment;iSR+=2)) {
                    __iRSP=${__lstSegment[iSR]}
                    __iREP=${__lstSegment[iSR+1]}
                    __iKSP=0 # because the target keyword line is started from 1 in __lstRanges[ ]
                    __iKEP=0
                    for((iKW=0;iKW<__iRanges;iKW+=3)) {
                        if [ ${__lstRanges[iKW+1]} -ge ${__iRSP} \
                             -a ${__lstRanges[iKW+1]} -le ${__iREP} \
                        ]; then
                            [ ${__iKSP} -lt 1 ] && __iKSP=$((iKW+1))
                            [ ${__iKEP} -lt 1 ] && __iKEP=$((iKW+1))
                            [ ${__iKEP} -ge 1 -a ${__lstRanges[iKW+1]} \
                                -gt ${__lstRanges[__iKEP]} ] &&  __iKEP=$((iKW+1))
                        fi
                    }
                    if [ x"${JLLCFG_dbgEnable}" = x"2" ]; then
                        echo -n "Line-Range={${__iRSP}--->${__iREP}}  "
                        echo -n "Line-KW={"
                        for((iKCP=__iKSP;iKCP<=__iKEP;iKCP+=3)) {
                            echo -n " ${__lstRanges[iKCP]}"
                        }
                        echo " }"
                    fi
                    echo
                    LvFssSymbol="${LvFssSymbol//\"/\\\"}"
                    LvFssSymbol="${LvFssSymbol//\'/\\\'}"
                    while [ ${__iRSP} -le ${__iREP} ]; do
                        __IsNeedHighLight=0
                        for((__iKCP=__iKSP;__iKCP<=__iKEP;__iKCP+=3)) {
                            if [ ${__iRSP} -eq ${__lstRanges[__iKCP]} ]; then
                                __CMDLINE="sed -n \"${__iRSP}p\" ${__lstFiles[iF]} | grep -E"
                                __CMDLINE="${__CMDLINE} -i \"${LvFssSymbol}\""
                                __CMDLINE="${__CMDLINE} --color=always"
                                __Rendering=$(eval ${__CMDLINE})
                                __IsNeedHighLight=1
                                break
                            fi
                        }
                      #Renderring the results
                      if [ ${__IsNeedHighLight} -eq 1 ]; then
                        __Lfn_Sys_ColorEcho \
                        "${CvAccOff}${CvFgBlue}${CvBgYellow}${__iRSP}${CvAccOff}: ${__Rendering} "
                      else
                        __Rendering=$(sed -n "${__iRSP}p" ${__lstFiles[iF]})
                        echo "${__iRSP}: ${__Rendering}"
                      fi
                        __iRSP=$((__iRSP+=1))
                    done
                }
            fi
        }
    }
    if [ x"${JLLCFG_dbgEnable}" = x"1" ]; then
        echo
        __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgYellow} " Done"
        echo
    fi

    [ x"${__lstRanges}" != x ] && unset __lstRanges
    [ x"${__iRanges}" != x ] && unset __iRanges
    [ x"${__iFiles}" != x ] && unset __iFiles
    [ x"${__lstFiles}" != x ] && unset __lstFiles
    [ x"${__iFindFiles}" != x ] && unset __iFindFiles
    [ x"${__lstFindFiles}" != x ] && unset __lstFindFiles
}

###############################################################
#   Library - End 
###############################################################

function __FN_Help()
{
    _sn=${__CvScriptName}
more>&1<<EOF
${AC}${Fgreen}
JLL-Help:${Fyellow}
  ${_sn} [drm-scheme] [keyword-regular-expression]${Fgreen}
       @[drm-scheme]:  only support for two schemes as follows:
           wv|widevine - support for ignore case sensitive
           pr|playready - support for ignore case sensitive
       @[keyword-regular-expression]: support for regular expression ${Fred}
  Note: parameters order can be unordered${Fgreen}
${Fgreen}
  For exmaple:  Lookup the digit
    jl@S:~\$ ${Fseablue}${_sn} pr "[ )]{0,}0x8004c013"${Fgreen}
    jl@S:~\$ ${Fseablue}more report_from_jll.hi.android.drm.sh.read_by_more${Fgreen}
  
  For exmaple:  Lookup the Function API named with decrypt
    jl@S:~\$ ${Fseablue}${_sn} pr "[ )=->.]{1,}decrypt[,a-zA-Z0-9_]{0,}\(.*[)\t ]{0,}[{]{0,}"
    ${Fgreen}jl@S:~\$ ${Fseablue}more report_from_jll.hi.android.drm.sh.read_by_more
${Fgreen}
JLL-Help:${Fyellow}
  ${_sn} [--help] | [-h]${Fgreen}
       @--help or -h: to lookup the manual about this
${AC}${Fred}
Note: For Improvimg Performance, 
      Please use the below project name according to the configuration:${Fpink}
      .
      ├──${Byellow} 2k15_mtk_1446_1_devprod${AC}${Fpink}
      │   ├── .repo 
      │   ├── abi
      │   ├── ...
      │
      ├──${Byellow} aosp_6.0.1_r10_selinux${AC}${Fpink}
      │   ├── .repo 
      │   ├── abi
      │   ├── ... 
      │    
      ├──${Byellow} androidn_2k16_mtk_mainline${AC}${Fpink}
      │   ├── .repo 
      │   ├── android
      │   └── vm_linux 
${AC}
EOF

}





#
# Recognize DRM scheme, Key Texts and so on. 
#
__DRM_SCHEME=
__keyTexts=
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
      --[hH][eE][lL][pP]|[-][h])
          __FN_Help
          exit 0
          ;;
      *)
          ac_arg=${ac_arg/#0x/}  #trip the head of 0x
          ac_arg=${ac_arg/#0X/}  #trip the head of 0X
          __keyTexts="$ac_arg"
          ;;
    esac
done

if [ x"${__keyTexts}" = x ]; then
    echo
    echo "JLL-Exit: not found the Key TEXT, then exit"
    echo
    __FN_Help 
    exit 0
fi

if [ x"${__DRM_SCHEME}" = x ]; then
    echo
    echo "JLL-Exit: not found the legal DRM scheme, then exit"
    echo
    __FN_Help 
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

declare -i JLLCFG_lstFileSZ=${#JLLCFG_lstFile[@]}
 
case ${__DRM_SCHEME} in
playready)
    JLLCFG_lstFile[JLLCFG_lstFileSZ++]="vendor/playready"
    ;;
widevine)
    JLLCFG_lstFile[JLLCFG_lstFileSZ++]="vendor/widevine"
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
2k15_mtk_1446_1_devprod)
  for((i=0;i<JLLCFG_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/${JLLCFG_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/${JLLCFG_lstFile[i]}"
          continue
      fi
      echo "JLL-Warning: not found \"${GvPrjRootPath}/${JLLCFG_lstFile[i]}\""
  }
  ;;
aosp_6.0.1_r10_selinux)
  JLLCFG_lstFile[JLLCFG_lstFileSZ++]="frameworks/av/services/mediaresourcemanager"
  for((i=0;i<JLLCFG_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/${JLLCFG_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/${JLLCFG_lstFile[i]}"
          continue
      fi
      echo "JLL-Warning: not found \"${GvPrjRootPath}/${JLLCFG_lstFile[i]}\""
  }
  ;;
androidn_2k16_mtk_mainline)
  JLLCFG_lstFile[JLLCFG_lstFileSZ++]="frameworks/av/services/mediadrm"
  JLLCFG_lstFile[JLLCFG_lstFileSZ++]="frameworks/av/services/mediacodec"
  JLLCFG_lstFile[JLLCFG_lstFileSZ++]="frameworks/av/services/mediaextractor"
  JLLCFG_lstFile[JLLCFG_lstFileSZ++]="frameworks/av/services/mediaresourcemanager"
  for((i=0;i<JLLCFG_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/android/n-base/${JLLCFG_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/android/n-base/${JLLCFG_lstFile[i]}"
          continue
      fi
  }
  ;;
*)
  ;;
esac

##############################################################################################
#  BEGIN: the below selector component is from vicc project
##############################################################################################

declare -i GvVimIDE_SettingsCount=${#GvVimIDE_Settings[@]}/4

# Prevent "*" from matching all files such as xxx.java is retrieved from matching *.java
# in current path, hence convert "*" to "\*"
if [ ${GvVimIDE_SettingsCount} -lt 4 ]; then
    Lfn_Sys_DbgEcho "Sorry, Exit because VimIDE Settings is the invalid table"
    exit 0
fi
for (( GvVimIDE_idx=0 ; GvVimIDE_idx<GvVimIDE_SettingsCount ; GvVimIDE_idx++ )) do
    GvVimIDE_Settings[GvVimIDE_idx*4+3]="${GvVimIDE_Settings[GvVimIDE_idx*4+3]//\*./\\*.}"
done

## Usage:
##     Fn_vimide_SpecifyProgrammingLanguages <oConfigure> <iOffsetX> <iOffsetY> [<iLanguage>] 
##
## Example.1:
##     Fn_vimide_SpecifyProgrammingLanguages LvVisplChoices 4 5 "Java asm C++ C"
##     echo "YourChoiceProgrammingLanguages: ${LvVisplChoices}"
##   Result.1:
##     Java C++ C
##
## Example.2:
##     Fn_vimide_SpecifyProgrammingLanguages LvVisplChoices 4 5
##     echo "YourChoiceProgrammingLanguages: ${LvVisplChoices}"
function Fn_vimide_SpecifyProgrammingLanguages()
{
    if [ $# -lt 3 -o $# -gt 4 ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    if [ x"$1" = x ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    # Check if parameter is digit and Converse it to a valid parameter 
    echo "$2" | grep -E '[^0-9]' >/dev/null && LvVisplX="0" || LvVisplX="$2";
    echo "$3" | grep -E '[^0-9]' >/dev/null && LvVisplY="0" || LvVisplY="$3";

    LvVisplChoice=""
    if [ x"$4" = x ]; then
        LvVisplFlag=1
        Lfn_Cursor_Mov "${LvVisplY}" "down"
        while [ ${LvVisplFlag} -eq 1 ]; do
            #Lfn_Cursor_Move "1" "$3"
            Lfn_Cursor_Mov "${LvVisplX}" "right"
            echo "=====[ File Type (q: Quit) ]====="
            LvVisplFlag=0
            for (( LvVisplIdx=0 ; LvVisplIdx<GvVimIDE_SettingsCount ; LvVisplIdx++ )) do
                if [ ! -z "${LvVisplChoice}" ]; then
                    for LvVisplItem in ${LvVisplChoice}; do
                        if [ x"${LvVisplItem}" = x"${GvVimIDE_Settings[LvVisplIdx*4]}" ]; then
                            LvVisplItem="Hit.DontDisplay"
                            break
                        fi
                    done
                fi
                if [ x"${LvVisplItem}" = x"Hit.DontDisplay" ]; then
                    continue
                fi
                Lfn_Cursor_Mov "${LvVisplX}" "right" 
                echo "├── ${GvVimIDE_Settings[LvVisplIdx*4]}"
                LvVisplFlag=1
            done
            if [ ${LvVisplFlag} -ne 1 ]; then
                break;
            fi
            Lfn_Cursor_Mov "${LvVisplX}" "right" 
            echo "[Your Choice]   " 
            #read -p "[Your Choice]   "  LvVisplAnChoice
            Lfn_Cursor_Mov "${LvVisplX}" "right" 
            echo "================================="
            Lfn_Cursor_Mov "2" "up"
            Lfn_Cursor_Mov "$(( LvVisplX + 20 ))" "right" 
            read LvVisplAnChoice
            if [ -z "${LvVisplAnChoice}" ]; then
                continue;
            fi
            if [ x"${LvVisplAnChoice}" = x"q" ]; then
                break;
            fi
            for (( LvVisplIdx=0 ; LvVisplIdx<GvVimIDE_SettingsCount ; LvVisplIdx++ )) do
                if [ x"${LvVisplAnChoice}" = x"${GvVimIDE_Settings[LvVisplIdx*4]}" ]; then
                    if [ x"${LvVisplChoice}" != x ]; then
                        # Need to filter repeat the valid choices
                        for LvVisplChoiceEntry in ${LvVisplChoice}; do
                            if [ x"${LvVisplAnChoice}" = x"${LvVisplChoiceEntry}" ]; then
                                break
                            fi
                        done
                        if [ x"${LvVisplAnChoice}" != x"${LvVisplChoiceEntry}" ]; then
                            LvVisplChoice="${LvVisplChoice} ${LvVisplAnChoice}"
                        fi
                        unset LvVisplChoiceEntry
                    else
                        LvVisplChoice="${LvVisplAnChoice}"
                    fi
                fi
            done
        done
    else
        for LvVisplAnChoice in $4; do
            for (( LvVisplIdx=0 ; LvVisplIdx<GvVimIDE_SettingsCount ; LvVisplIdx++ )) do
                if [ x"${LvVisplAnChoice}" = x"${GvVimIDE_Settings[LvVisplIdx*4]}" ]; then
                    LvVisplChoice="${LvVisplChoice} ${LvVisplAnChoice}"
                    break;
                fi
            done
        done
    fi
    
    if [ x"${LvVisplChoice}" = x ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit because Dont retrieve any Programming languages"
        exit 0
    fi

    Lfn_Cursor_Mov "${LvVisplX}" "right"
    echo ""
    eval $1=$(echo -e "${LvVisplChoice}" | sed "s:\ :\\\\ :g")
    return
}
clear
echo
Fn_vimide_SpecifyProgrammingLanguages LvVisplChoices 2 1 
echo
echo "Your_Choices_For_File_Type: ${LvVisplChoices}"
echo
# collecting the required File Type
LvVicsfFileTypeIdx=0
for (( LvVicsfIdx=0 ; LvVicsfIdx<GvVimIDE_SettingsCount ; LvVicsfIdx++ )) do
    for LvVicsfLanguage in ${LvVisplChoices}; do
        if [ x"${GvVimIDE_Settings[LvVicsfIdx*4]}" = x"${LvVicsfLanguage}" ]; then
            for LvVicsfFT in ${GvVimIDE_Settings[LvVicsfIdx*4+3]}; do
                __isAddFT=1
                for((___iFT=0;___iFT<LvVicsfFileTypeIdx;___iFT++)) {
                    if [ x"${JLLCFG_lstFileType[___iFT]}" = x"${LvVicsfFT}" ]; then
                        __isAddFT=0
                        break;
                    fi
                }
                if [ ${__isAddFT} -eq 1 ]; then
                    JLLCFG_lstFileType[LvVicsfFileTypeIdx++]="${LvVicsfFT}"
                fi
            done
        fi
    done
done
[ x"${LvVisplChoices}" != x ] && unset LvVisplChoices 

if [ ${LvVicsfFileTypeIdx} -lt 1 ]; then
    JLLCFG_lstFileType=(
        "*.cpp"
        "*.java"
        "*.c"
        "*.h"
        "*.c"
        "*.aidl"
        "*.cc"
        "*.hpp"
        "*.c"
        "*.mk"
        "*.mak"
        "Makefile"
        "makefile"
    )
fi

[ x"${GvVimIDE_Settings}" != x ] && unset GvVimIDE_Settings 
[ x"${GvVimIDE_SettingsCount}" != x ] && unset GvVimIDE_SettingsCount 
[ x"${LvVicsfFileTypeIdx}" != x ] && unset LvVicsfFileTypeIdx 


if [ x"${JLLCFG_dbgEnable}" = x"1" ]; then
    ______i=${#JLLCFG_lstFileType[@]}
    for((___i=0;___i<______i; ___i++)) {
        echo "${JLLCFG_lstFileType[___i]}"
    }
fi

##############################################################################################
#  END: the below selector component is from vicc project
##############################################################################################






if [ ${__lstResSZ} -ne ${JLLCFG_lstFileSZ} ]; then
    unset __lstRes
    unset __lstResSZ
    declare -a __lstRes
    declare -i __lstResSZ=0

    __FIND_PATHS="-regex \".*/?${JLLCFG_lstFile[0]}\""
    for ((i=1;i<JLLCFG_lstFileSZ;i++)) {
        __FIND_PATHS="${__FIND_PATHS} -o -regex \".*/?${JLLCFG_lstFile[i]}\""
    }

    __lstCmd="find ${GvPrjRootPath} \\( -regex \".*/?out\" -o -regex \".*/\..*\" \\) -prune"
    __lstCmd="${__lstCmd} -o -type d -a \\( ${__FIND_PATHS} \\) -print"
    echo
    echo ${__lstCmd}
    echo
    echo -ne "    Progressing For Collecting the legal resources...  "
    Lfn_Sys_Rotate &
    __RotateBgPID=$!
    __lstTargets=$(eval ${__lstCmd})
    kill -9 ${__RotateBgPID}

    for __lstT in ${__lstTargets}; do
        __lstRes[__lstResSZ++]="${__lstT}"
    done
    [ x"${__FIND_PATHS}" != x ] && unset __FIND_PATHS
    [ x"${__lstCmd}" != x ] && unset __lstCmd
    [ x"${__RotateBgPID}" != x ] && unset __RotateBgPID 
    [ x"${__lstTargets}" != x ] && unset __lstTargets 
fi

[ x"${JLLCFG_lstFile}" != x ] && unset JLLCFG_lstFile
[ x"${JLLCFG_lstFileSZ}" != x ] && unset JLLCFG_lstFileSZ
#[ x"${GvPrjRootPath}" != x ] && unset GvPrjRootPath
if [ ${__lstResSZ} -lt 1 ]; then
    __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgBlack} \
        "JLL-Exit: Not found any legal Resources then exit"
    exit 0
fi

clear
__Lfn_Sys_ColorEcho ${__CvBgSeaBule} ${__CvFgBlack} \
    "============================ The Legal Resources As Follows =============================="
for((i=0;i<__lstResSZ;i++)) {
    echo " ${__lstRes[i]}"
}
 
clear
echo

__szConsiderFileType=""
__nLstConsiderFileType=${#JLLCFG_lstFileType[@]}
for((i=0; i<__nLstConsiderFileType; i++)) {
    __szConsiderFileType="${__szConsiderFileType} --File=\"${JLLCFG_lstFileType[i]}\""
}
[ x"${JLLCFG_lstFileType}" != x ] && unset JLLCFG_lstFileType
if [ x"${__szConsiderFileType}" = x ]; then
    __szConsiderFileType="*"
fi

echo -ne "${__CvAccOff}${__CvFgPink}${__CvBgBlack}JLL-FileTypes:${__CvAccOff}" 
echo -e "${__szConsiderFileType// --File=/\\n}" | sed "s/\"//g"
echo

echo
echo -e "${__CvAccOff}${__CvFgPink}${__CvBgBlack}JLL-Search-PATHs:${__CvAccOff}" 
for((i=0;i<__lstResSZ;i++)) {
    echo " ${__lstRes[i]}"
}
echo

__szIgnorePath=""


for((i=0;i<__lstResSZ;i++)) {
   Lfn_File_SearchSymbol_EX \
       ${__szConsiderFileType} \
       --Symbol="${__keyTexts}" \
       --Mode=1 \
       --Path="${__lstRes[i]}" \
       ${__szIgnorePath}  | tee -a report_from_${__CvScriptName}.read_by_more
}


