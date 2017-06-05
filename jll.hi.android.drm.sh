#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.hi.android.drm.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-01 19:43:06
#   ModifiedTime: 2017-06-05 21:09:59
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

#
# |---JLLCFG_Render_Range---|---JLLCFG_Render_Range---|
# |_________________________|_________________________|
# Start                     Target                    End
#
JLLCFG_Render_Range=6

JLLCFG_dbgEnable=0





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
        echo "JLL-Return: LvFssSymbol=${LvFssSymbol} or LvFssFile=${LvFssFile}"
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
        __OldIFS=${IFS}
        IFS=$'\n'
        for LvFssLine in \
        `eval find ${LvFssRootPath} ${LvFssIgnorePath} -type f -a -print`; do
            LvFssMatch=`grep ${LvFssFlags} -i "${LvFssSymbol}" "${LvFssLine}" --color=always`
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

                if [ ${__iRanges} -gt 3 ]; then
                    # Sorted order
                    for((is=0;is<__iRanges;is+=3)) {
                        for((js=is+3;js<__iRanges;js+=3)) {
                            if [ ${__lstRanges[is]} -gt ${__lstRanges[js]} ]; then
                            echo "<-$is:${__lstRanges[is]}-${__lstRanges[is+1]}-${__lstRanges[is+2]}"
                            echo "->$js:${__lstRanges[js]}-${__lstRanges[js+1]}-${__lstRanges[js+2]}"
                                __RenderStart=${__lstRanges[i]}
                                __RenderTarget=${__lstRanges[i+1]}
                                __RenderEnd=${__lstRanges[i+2]}
                                __lstRanges[i]=${__lstRanges[j]}
                                __lstRanges[i+1]=${__lstRanges[j+1]}
                                __lstRanges[i+2]=${__lstRanges[j+2]}
                                __lstRanges[j]=${__RenderStart}
                                __lstRanges[j+1]=${__RenderTarget}
                                __lstRanges[j+2]=${__RenderEnd}
                            fi
                        } 
                    }

echo "JLLing: ${__lstFindFiles[iFF]}; ${__lstFiles[iF]}"
echo "continue: iFF=${iFF} __iFindFiles=${__iFindFiles}  iF=${iF} __iFiles=${__iFiles}"
continue

                    [ x"${__lstSegment}" != x ] && unset __lstSegment
                    [ x"${__iSegment}" != x ] && unset __iSegment
                    declare -a __lstSegment
                    declare -i __iSegment=0
                    __SegSP=${__lstRanges[0]}
                    __SegEP=${__lstRanges[2]}
                    # Combine the override ranges
                    for((i=3;i<__iRanges;i+=3)){
                        __NextSegSP=${__lstRanges[i]}
                        __NextSegEP=${__lstRanges[i+2]}
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

                    for((i=0;i<__iRanges;i+=3)) {
                        echo "Raw-ITEM: ${__lstRanges[i]}===${__lstRanges[i+2]}"
                    }
                    echo "+++++++++++++++++++++++++++++"
                    for((i=0;i<__iSegment;i+=2)) {
                        echo "New-ITEM: ${__lstSegment[i]}===${__lstSegment[i+1]}"
                    }
                fi
            fi
        }
        IFS=${__OldIFS}
    } 
    if [ x"${JLLCFG_dbgEnable}" = x"1" ]; then
        echo
        __Lfn_Sys_ColorEcho ${__CvBgRed} ${__CvFgYellow} " Done"
        echo
    fi
}

###############################################################
#   Library - End 
###############################################################







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
    exit 0
fi

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
2k15_mtk_1446_1_devprod)
  for((i=0;i<CONF_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/${CONF_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/${CONF_lstFile[i]}"
          continue
      fi
      echo "JLL-Warning: not found \"${GvPrjRootPath}/${CONF_lstFile[i]}\""
  }
  ;;
aosp_6.0.1_r10_selinux)
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediadrm"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediacodec"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediaextractor"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediaresourcemanager"
  for((i=0;i<CONF_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/${CONF_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/${CONF_lstFile[i]}"
          continue
      fi
      echo "JLL-Warning: not found \"${GvPrjRootPath}/${CONF_lstFile[i]}\""
  }
  ;;
androidn_2k16_mtk_mainline)
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediadrm"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediacodec"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediaextractor"
  CONF_lstFile[CONF_lstFileSZ++]="frameworks/av/services/mediaresourcemanager"
  for((i=0;i<CONF_lstFileSZ;i++)) {
      if [ -e "${GvPrjRootPath}/android/n-base/${CONF_lstFile[i]}" ]; then
          __lstRes[__lstResSZ++]="${GvPrjRootPath}/android/n-base/${CONF_lstFile[i]}"
          continue
      fi
  }
  ;;
*)
  ;;
esac
echo "${__lstResSZ} -ne ${CONF_lstFileSZ}"
if [ ${__lstResSZ} -ne ${CONF_lstFileSZ} ]; then
exit 0
    unset __lstRes
    unset __lstResSZ
    declare -a __lstRes
    declare -i __lstResSZ=0

    __FIND_PATHS="-regex \".*/?${CONF_lstFile[0]}\""
    for ((i=1;i<CONF_lstFileSZ;i++)) {
        __FIND_PATHS="${__FIND_PATHS} -o -regex \".*/?${CONF_lstFile[i]}\""
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

[ x"${CONF_lstFile}" != x ] && unset CONF_lstFile
[ x"${CONF_lstFileSZ}" != x ] && unset CONF_lstFileSZ
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

declare -a CONF_lstFileType=(
    "*.cpp"
    "*.java"
    "*.h"
    "*.c"
    "*.aidl"
    "*.cc"
    "*.mk"
    "*.mak"
    "Makefile"
    "makefile"
)

__szConsiderFileType=""
__nLstConsiderFileType=${#CONF_lstFileType[@]}
for((i=0; i<__nLstConsiderFileType; i++)) {
    __szConsiderFileType="${__szConsiderFileType} --File=\"${CONF_lstFileType[i]}\""
}
[ x"${CONF_lstFileType}" != x ] && unset CONF_lstFileType
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
       ${__szIgnorePath}
}


