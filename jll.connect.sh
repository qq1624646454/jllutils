#!/bin/bash
#
function Lfn_Product_RevisionInformation()
{
cat >&1 << EOF
# LIBRARY_REVISION:
#         LR.2015.09.25.V000 - Created by jielong.lin 
#         LR.2015.10.03.V000 - Modified by jielong.lin
#             Re-built all function and all names accord with the specified standard. 
#         LR.2015.10.11.V000 - Modified by jielong.lin
#             Implement Lfn_Sys_Rotate for progress bar. 
# 
# APPLICATION_REVISION:
#         AR.`date +%Y.%M.%D`.V000 - Created by jielong.lin 
#         AR.2015.10.03.V000 - Modified by jielong.lin
#             Implement the three choice for Ui CheckBox, as follows:
#             [i]	install
#             [u]	uninstall
#             [ ]	skip/ignore
#         AR.2015.10.04.V001 - Modified by jielong.lin
#             Modified the hint about "un-install.sh" to "uninstall.sh" 
#         AR.2015.10.04.V002 - Modified by jielong.lin
#             Modified the Lfn_Sys_FuncComment for "Error LineNo"
#
# SPECIFICATION:
#         Lfn***       - Library Function Name
#         Fn***        - Function Name
#         Lv***        - Library Function Variable Name
#         Cv***        - Constant Variable Name
#         Lfn_Tpv_***  - TPV Library Function Name
#
EOF
}

#------------------------------
# Constant Variable Definition
#------------------------------
CvPathFileForScript="`which $0`"
CvScriptName="`basename  ${CvPathFileForScript}`"
CvScriptPath="`dirname   ${CvPathFileForScript}`"

if [ x"$CvScriptPath" = x"." ]; then
    CvScriptPath="`pwd`"
fi



#------------------------------
# Library Functions Definition
#------------------------------

function Lfn_Product_Copyright_C()
{
cat >&1 << EOF
--------------------------------------------------------------
# Copyright (c) `date +%Y`. jielong.lin,  All rights reserved.
# ScriptPATH:  ${CvScriptPath}
# ScriptName:  ${CvScriptName}

EOF
}
########Lfn_Product_Copyright_C

function Lfn_Sys_DbgEcho()
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
##     Lfn_Sys_FuncComment 
function Lfn_Sys_FuncComment()
{
    LvSfcCallerFunc="${FUNCNAME[1]}"
    LvSfcCallerFileLineNo=`caller 0 | awk '{print $1}'`
    LvSfcPattern="function ${LvSfcCallerFunc}"
    LvSfcLineNo=`grep -Enwr  "^${LvSfcPattern}" ${CvScriptPath}/${CvScriptName} | awk -F ':' '{print $1}'`
    if [ -z "${LvSfcLineNo}" ]; then
        Lfn_Sys_DbgEcho "Sorry, Return due to the bad function format" 
        return;
    fi

    LvSfcCnt=0
    for LvSfcIdx in ${LvSfcLineNo}; do
        LvSfcCnt=`expr ${LvSfcCnt} + 1`
    done
    if [ ${LvSfcCnt} -ne 1 -o ${LvSfcLineNo} -lt 0 ]; then
        Lfn_Sys_DbgEcho "Sorry, exit due to the invalid function comment format" 
        exit 0
    fi
    LvSfcContentLineNo=`expr ${LvSfcLineNo} - 1`
    if [ ${LvSfcContentLineNo} -lt 0 ]; then
        return;
    fi
    LvSfcContentStartLineNo=${LvSfcContentLineNo} 
    LvSfcContentEndLineNo=${LvSfcContentLineNo}

    while [ ${LvSfcContentStartLineNo} -ne 0 ]; do 
        LvTempContent=`sed -n "${LvSfcContentStartLineNo}p" ${CvScriptPath}/${CvScriptName} | grep -Ewn "^##"`
        if [ -z "${LvTempContent}" ]; then
            break;
        fi
        LvSfcContentStartLineNo=`expr ${LvSfcContentStartLineNo} - 1`
    done
 
    if [ ${LvSfcContentStartLineNo} -lt ${LvSfcContentEndLineNo} ]; then
        echo "Error LineNo : ${LvSfcCallerFileLineNo}"
        LvSfcContentStartLineNo=`expr ${LvSfcContentStartLineNo} + 1`
        sed -n "${LvSfcContentStartLineNo},${LvSfcContentEndLineNo}p" ${CvScriptPath}/${CvScriptName} | sed 's/^#\{0,\}//'
    fi
    return;
}



## Usage:
##     Lfn_Sys_CheckRoot
## Details:
##     If the current user isn't root, then exit directly.
function Lfn_Sys_CheckRoot()
{
    if [ x"`whoami`" != x"root" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to invalid root privilege"
        exit 0
    fi
    return;
}


## Usage:
##     Lfn_Sys_GetAllUsers <oResult> 
## Details:
##     Get all users and output the result to <oResult> 
## Example:
##     Lfn_Sys_GetAllUsers oUserList 
##     for oUser in ${oUserList}; do
##         echo "User:${oUser}"
##     done 
function Lfn_Sys_GetAllUsers()
{
    if [ $# -ne 1 ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to the fatal parameter error" 
        exit 0; 
    fi
    LvSgauResult="root"
    LvSgauUsers=`cd /home/;find . -maxdepth 1 -a \( -path "./xmic" -o -path "./.*" -o -path "./lost+found" \)  -prune -o -type d -a -print | sed "1d"`
    LvSgauRegUsers=`cat /etc/passwd | awk -F: '$3>=500' | cut -f 1 -d :`
    # Access every user in /home 
    for LvSgauUser in ${LvSgauUsers}; do
        for LvSgauRegUser in ${LvSgauRegUsers}; do
            if [ x"./${LvSgauRegUser}" = x"${LvSgauUser}" ]; then
                LvSgauResult="${LvSgauResult} ${LvSgauRegUser}" 
            fi
        done
    done
    LvSgauResult=`echo ${LvSgauResult} | sed 's:\ :\\\ :g'`
    eval $1="${LvSgauResult}"
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

CvAccOff="\033[0m"

CvFgBlack="\033[30m"
CvFgRed="\033[31m"
CvFgGreen="\033[32m"
CvFgYellow="\033[33m"
CvFgBlue="\033[34m"
CvFgPink="\033[35m"
CvFgSeaBule="\033[36m"
CvFgWhite="\033[37m"

CvBgBlack="\033[40m"
CvBgRed="\033[41m"
CvBgGreen="\033[42m"
CvBgYellow="\033[43m"
CvBgBlue="\033[44m"
CvBgPink="\033[45m"
CvBgSeaBule="\033[46m"
CvBgWhite="\033[47m"


## Usage:
##     Lfn_Sys_DbgColorEcho [CvFgXxx|CvBgXxx] [CvFgXxx|CvBgXxx] [TEXT] 
## Details:
##     Print the format <TEXT> with fg-color named [CvFgXxx] or bg-color named [CvBgXxx]
## Parameter:
##     [CvFgXxx]   - Foreground color
##     [CvBgXxx]   - Background color 
##     [TEXT] - The text to display on the standard output device.
## Example:
##     Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgWhite} "hello World"
##
function Lfn_Sys_DbgColorEcho()
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
        echo -e "${CvAccOff}${LvSdceFgColor}${LvSdceBgColor}"\
                "\b[jll] ${LvSdceCallerFileLineNo},${LvSdceCallerFuncName}${CvAccOff}" 
    else
        echo -e "${CvAccOff}${LvSdceFgColor}${LvSdceBgColor}"\
                "\b[jll] ${LvSdceCallerFileLineNo},${LvSdceCallerFuncName}: ${LvSdceText}${CvAccOff}" 
    fi
}

## Usage:
##     Lfn_Sys_ColorEcho [CvFgXxx|CvBgXxx] [CvFgXxx|CvBgXxx] [TEXT] 
## Details:
##     Print the format <TEXT> with fg-color named [CvFgXxx] or bg-color named [CvBgXxx]
## Parameter:
##     [CvFgXxx]   - Foreground color
##     [CvBgXxx]   - Background color 
##     [TEXT] - The text to display on the standard output device.
## Example:
##     Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello World"
##
function Lfn_Sys_ColorEcho()
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

    echo -e "${CvAccOff}${LvSceFgColor}${LvSceBgColor}${LvSceText}${CvAccOff}" 
}


## Usage:
##     Lfn_Sys_GetEachUpperLevelPath <oPaths>
## Details:
##     Get the each level path towards upper 
## Parameter:
##     oPaths - output each level paths 
## Example:
##     Lfn_Sys_GetEachUpperLevelPath oPaths 
##     OldIFS=$IFS
##     IFS=:
##     for My_Path in $My_Paths; do
##         echo "--> $My_Path"
##     done
##     IFS=$OldIFS
##
function Lfn_Sys_GetEachUpperLevelPath()
{
    if [ -z "$1" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvGadoulPaths=""
    LvGadoulPath=`pwd`
    while [ ! -z "${LvGadoulPath}" ]; do
        if [ -z "${LvGadoulPaths}" ]; then
            LvGadoulPaths="${LvGadoulPath}"
        else
            LvGadoulPaths="${LvGadoulPaths}:${LvGadoulPath}"
        fi

        LvGadoulBasename=`basename "${LvGadoulPath}"`
        LvGadoulPath=`echo "${LvGadoulPath}" | sed "s/\/${LvGadoulBasename}//"`
    done

    LvGadoulPaths=`echo "${LvGadoulPaths}" | sed "s/\ /\\\\\ /g"`
    if [ -z "${LvGadoulPaths}" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    eval $1="${LvGadoulPaths}"
}


## Usage:
##     Lfn_Sys_GetSameLevelPath <oPaths> <iKeywordString>
## Details:
##     Get the path on the same level path with <iKeywordString> from the parent path
##     based on the current path
## Parameter:
##     oPaths - output the specified path
## Example:
##     Lfn_Sys_GetSameLevelPath  oResult ".repo frameworks dalvik libnativehelper"
##     if [ ! -z "${oResult}" ]; then
##         echo "${oResult}"
##     fi
##
function Lfn_Sys_GetSameLevelPath()
{
    if [ $# -ne 2 -o -z "$2" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvSgslpKeywords="$2"
    eval $1=""

    # visit every location from the tails of the current path
    Lfn_Sys_GetEachUpperLevelPath LvSgslpPaths
    OldIFS=$IFS
    IFS=:
    for LvSgslpPath in ${LvSgslpPaths}; do
        IFS=$OldIFS
        for LvSgslpKey in ${LvSgslpKeywords}; do
            LvSgslpFlag=`ls -a ${LvSgslpPath} | grep -iw "${LvSgslpKey}"`
            if [ ! -z "${LvSgslpFlag}" ]; then
                continue
            fi
            break
        done

        if [ ! -z "${LvSgslpFlag}" ]; then
            LvSgslpPath=`echo "${LvSgslpPath}" | sed "s/\ /\\\\\ /g"`
            eval $1="${LvSgslpPath}"
            IFS=$OldIFS
            return 0
        fi
        IFS=:
    done
    IFS=$OldIFS

    return 0
}


## Lfn_Sys_Rotate &
## GvBgPid=$!
## sleep 20
## kill -9 ${GvBgPid} 
##
function Lfn_Sys_Rotate()
{
    LvSrInterval=0.05
    LvSrTcount="0"

    while true; do
        LvSrTcount=`expr ${LvSrTcount} + 1`
        case  ${LvSrTcount}  in
        1)
            echo -ne "\b-"
            sleep  ${LvSrInterval}
        ;;
        2)
            echo -ne "\b\\"
            sleep  ${LvSrInterval}
        ;;
        3)
            echo -ne "\b|"
            sleep  ${LvSrInterval}
        ;;
        4)
            echo -ne "\b/"
            sleep  ${LvSrInterval}
        ;;
        *)
            LvSrTcount="0"
            sleep  ${LvSrInterval}
        ;;
        esac
    done
}


## Usage: 
##     Lfn_Tpv_GetSoftwareVersion <oProjVer>
## Details:
##     Get the software version of the EU2k15 MTK project
## Parameter:
##     <oProjVer> - the output buffer of the project version. Failure if oProjVer is "NULL"
## Note:
##     TARGET_PRODUCT should be set before this function is called.
## Example:
##     Lfn_Tpv_GetSoftwareVersion  oProjVer
##     echo "FwVersion: $oProjVer"
##
function Lfn_Tpv_GetSoftwareVersion()
{
    if [ $# -ne 1 ]; then
        Lfn_Sys_FuncComment
        return 0
    fi

    eval $1="NULL"

    #Get the Android root
    Lfn_Sys_GetSameLevelPath LvTgsvRootPath ".repo frameworks dalvik libnativehelper"
    if [ -z "${LvTgsvRootPath}" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit because dont find the root path from current by towards upper"
        exit 0
    fi

    if [ -z "$TARGET_PRODUCT" ]; then

        LvTgsvTargetProduct="`ls ${LvTgsvRootPath}/device/tpvision | grep -Er 'philips_MT5593*'`"
        if [ -z "${LvTgsvTargetProduct}" ]; then
            Lfn_Sys_DbgEcho "Sorry, Return because dont find the philips_MT5593* in ${LvTgsvRootPath}/device/tpvision"
            return; 
        fi

        while [ ! -z "${LvTgsvTargetProduct}" ]; do
            echo "Please select the choice from the following menu:"
            echo ""
            echo " (Menu)      (Detail) "
            echo "    0         quit"
            LvTgsvIdx=1
            for LvTgsvTP in ${LvTgsvTargetProduct}; do
                echo "    ${LvTgsvIdx}         ${LvTgsvTP}"
                LvTgsvIdx=`expr ${LvTgsvIdx} + 1`
            done
            read -p "Your Choice: " LvTgsvChoice
            if [ ${LvTgsvChoice} -eq 0 ]; then
                return;
            fi
            if [ ${LvTgsvChoice} -gt ${LvTgsvIdx} -o ${LvTgsvChoice} -eq ${LvTgsvIdx} ]; then
                echo "Error, try it again"
                continue;
            fi
            LvTgsvIdx=1
            for LvTgsvTP in ${LvTgsvTargetProduct}; do
                if [ x"${LvTgsvIdx}" = x"${LvTgsvChoice}" ]; then  
                    TARGET_PRODUCT="${LvTgsvTP}"
                    break;
                fi
                LvTgsvIdx=`expr ${LvTgsvIdx} + 1`
            done
            if [ ! -z "${TARGET_PRODUCT}" ]; then
                break;
            fi
        done
    fi
 
    if [ ! -e "${LvTgsvRootPath}/device/tpvision/${TARGET_PRODUCT}/system.prop" ]; then
        Lfn_Sys_DbgEcho "Sorry, Return because dont exist \"${LvTgsvRootPath}/device/tpvision/${TARGET_PRODUCT}/system.prop\""
        return;
    fi

    LvTgsvSoftwareVersion="`cat ${LvTgsvRootPath}/device/tpvision/${TARGET_PRODUCT}/system.prop \
                             | grep -i product.swversion | awk -F '=' '{print $2}'`"
    if [ ! -z "${LvTgsvSoftwareVersion}" ]; then
        eval $1="${LvTgsvSoftwareVersion}"
    else
        Lfn_Sys_DbgEcho "Sorry, Dont find version" 
    fi
    return;
}



## Usage: 
##     Lfn_Tpv_GetGitTagVersion <oProjVer>
## Details:
##     Get the git tag version of the EU2k15 MTK project
## Parameter:
##     <oProjVer> - the output buffer of the project version. Failure if oProjVer is "NULL"
## Example:
##        Lfn_Tpv_GetGitTagVersion oProjVer 
##        echo "GitTagVersion: $oProjVer"
## 
function Lfn_Tpv_GetGitTagVersion() 
{
    if [ $# -ne 1 ]; then
        Lfn_Sys_FuncComment
        return 0
    fi

    eval $1="NULL"

    Lfn_Tpv_GetSoftwareVersion LvTggtvFwVer  
    if [ -z "${LvTggtvFwVer}" ]; then
        Lfn_Sys_DbgEcho "Sorry, Return because dont get the version"
        return 0 
    fi

    LvTggtvGitTagVersion=`echo ${LvTggtvFwVer} | sed "s/E\./E_R/"`
    if [ ! -z "${LvTggtvGitTagVersion}" ]; then
        eval $1="${LvTggtvGitTagVersion}" 
    fi
    return 0
}



CvCodeFileTable0="*"
CvCodeFileTable1="*.c *.java *.cpp *.cxx *.aidl *.h *.hpp *.hxx *.cc *.s *.S *.lds *.mak Makefile makefile"
CvCodeFileTable2="*.c *.java *.cpp *.cxx *.aidl *.h *.hpp *.hxx *.cc *.s *.S"
CvCodeFileTable3="*.c *.cpp *.cxx *.h *.hpp *.hxx *.cc"
CvCodeFileTable4="*.java *.aidl *.h "

## Usage:
##     Lfn_File_SearchSymbol -S <SYMBOL>  -F <ScopeFiles...> -M <MatchMode>
## Details:
##     Search the <SYMBOL> from <ScopeFiles...> as <MatchMode>
##     output the matched information. 
## Parameter:
##     <SYMBOL> - specified symbol used for matching search file location.
##     <ScopeFile> - specified the files used to be searched.
##     <MatchMode> - specified the matching as precise or comprehensive.
##                   one of the values:
##                   0 - precise (default)
##                   1 - comprehensive 
## Example:
##     Lfn_File_SearchSymbol --Symbol="main"  --File=*.c --File=*.java --File=*.cpp --Mode=0
##
function Lfn_File_SearchSymbol()
{
    CvPreciseFlags="-Fwnr"
    CvComprehensiveFlags="-Fnr"

    LvFssSymbol=""
    LvFssFile=""
    LvFssFileSwitch=1
    LvFssMode="0"
    LvFssFlags="${CvPreciseFlags}"

    while [ $# -ne 0 ]; do
    case $1 in
    --Symbol=*)
        if [ -z "${LvFssSymbol}" ]; then
            LvFssSymbol=`echo $1 | sed -e "s/--Symbol=//g" -e "s/,/ /g"`
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
    *)
        ;;
    esac
    shift
    done
    if [ -z "${LvFssSymbol}" -o -z "${LvFssFile}" ]; then
        Lfn_Sys_FuncComment
        return;
    fi

    if [ x"${LvFssMode}" = x"1" ]; then
        LvFssFlags=${CvComprehensiveFlags}
    fi

    for LvFssFl in ${LvFssFile}; do
        find `pwd` -type f -a -name "${LvFssFl}" -print | while read LvFssLine; do
            LvFssMatch=`grep ${LvFssFlags} "${LvFssSymbol}" "${LvFssLine}" --color=always`
            if [ x"$?" = x"0" ]; then
                Lfn_Sys_ColorEcho  ${CvFgBlack}  ${CvBgWhite}    " ${LvFssLine} "
                Lfn_Sys_ColorEcho  "${LvFssMatch}"
                echo
            fi
        done
    done
    echo
    Lfn_Sys_ColorEcho ${CvBgRed} ${CvFgYellow} " Done"
    echo
}



## Usage:
##     Lfn_File_DeleteMatchLine <iString>  <iFile>
## Details:
##     Delete the lines which are matched by the specified <iString> from file <iFile>
## Example:
##     Lfn_File_DeleteMatchLine "jielong.lin"  "./test"
##
function Lfn_File_DeleteMatchLine()
{
    if [ -z "$1" -o -z "$2" -o ! -e "$2" ]; then
        Lfn_Sys_FuncComment
        return 0
    fi
    LvFdmlString=$1
    LvFdmlFile=$2
    LvFdmlLines=`grep -Fwnr "${LvFdmlString}" "${LvFdmlFile}" | awk -F ':' '{print $1}'`
    LvFdmlIdx=0
    for LvFdmlLine in ${LvFdmlLines}; do
        LvFdmlLine=`expr ${LvFdmlLine} - ${LvFdmlIdx}`;
        sed "${LvFdmlLine}"d -i ${LvFdmlFile};
        echo "[GOOD] ${LvFdmlFile}:${LvFdmlLine} is delelted"
        LvFdmlIdx=`expr ${LvFdmlIdx} + 1`;
    done
} 



## Usage: 
##     Lfn_File_BatchModifyFileName <iOld> <iNew>
## Details:
##     The file names which contain the <iOld> to <iNew> under the current path. 
## Parameter:
##     <iOld> - the pattern string as be replaced 
##     <iNew> - the target string. 
## Example:
##        Lfn_File_BatchModifyFileName "aaa" "bbb"
## 
function Lfn_File_BatchModifyFileName() 
{
    if [ $# -ne 2 ]; then
        Lfn_Sys_FuncComment
        return 0
    fi

    LvFbmfnFiles=`find . -type f`

    for LvFbmfnFile in ${LvFbmfnFiles}; do
        if [ "${LvFbmfnFile}" = "$0" ]; then
            continue
        fi
        LvFbmfnTargetFile=`echo ${LvFbmfnFile} | sed "s/$1/$2/g"`
        if [ "${LvFbmfnFile}" = "${LvFbmfnTargetFile}" ]; then
            continue
        else
            mv ${LvFbmfnFile} ${LvFbmfnTargetFile}
        fi
    done
}


## Usage:
##     Lfn_File_CheckIfExistSymbol <oResult> <iFlag> <iFile>
## Details:
##     Check if the file <iFile> has already contained the flag <iFlag>
##     If Contained, <oResult> is 1.
##     If Not Contain, <oResult> is 0. 
## Example:
##     iFlag="### Modification by Vanquisher for /etc/fstab ###"
##     Lfn_File_CheckIfExistSymbol oResult "$strFlag" "/etc/fstab"
##     if [ ${oResult} -eq 1 ]; then
##         echo "Modified"
##     else
##         echo "Un-modified"
##     fi
function Lfn_File_CheckIfExistSymbol()
{
    if [ $# -ne 3 ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to the fatal parameter error" 
        exit 0; 
    fi

    if [ -z "$2" -o -z "$3" -o ! -e "$3" ]; then
        Lfn_Sys_FuncComment
        eval $1="0"
        return; 
    fi

    LvFciesFlag=`grep -iwnr "$2" $3`  
    if [ -z "${LvFciesFlag}" ]; then
        eval $1="0"
    else
        eval $1="1" 
    fi
}



## Usage:
##     Lfn_File_GetMatchLine <oResult> <iKeyWord> <iFilePath>
## Details:
##     Get the Line Number of the File located in "<FilePath>" if "<KeyWord>" is
##     matched successfully. Save the result to <oResult>
## Parameter:
##     <iKeyWord> - specified string used for matching search file location.
##     <iFilePath> - specify the file path.
##     <oResult> - out the file line as the result.
## Example:
##     Lfn_File_GetMatchLine oFileLine "main" "/home/1.txt"
##     if [ ! -z "${oFileLine}" ]; then
##         echo "Line: ${oFileLine}"
##     fi
##
function Lfn_File_GetMatchLine()
{
    if [ -z "$1" -o -z "$2" -o -z "$3" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to error usage"
        Lfn_Sys_FuncComment
        exit 0
    fi  

    if [ ! -e "$3" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit because dont exist \"$3\""
        exit 0
    fi  

    # LvFgmlKeyword is only single line, so it doesnt need to be contained by the single quotes.
    LvFgmlKeyword=$(echo -e "$2" | sed "s#\/#\\\/#g")
    LvFgmlKeyword=$(echo -e "${LvFgmlKeyword}" | sed "s:    :\\\\t:g")
    LvFgmlKeyword=$(echo -e "${LvFgmlKeyword}" | sed "s:\[:\\\[:g")
    LvFgmlKeyword=$(echo -e "${LvFgmlKeyword}" | sed "s:\]:\\\]:g")
    LvFgmlKeyword=$(echo -e "${LvFgmlKeyword}" | sed "s:\*:\\\*:g")

    # Maybe the result contains the break line, and it will cause
    # the error that cannt find command.
    # Transform the line break symbol to the one space symbol
    LvFgmlLineNo=""
    for LvFgmlLineNoItem in $(sed -n "/${LvFgmlKeyword}/=" $3); do
        if [ -z "${LvFgmlLineNo}" ]; then
            LvFgmlLineNo="${LvFgmlLineNoItem}"
        else
            LvFgmlLineNo="${LvFgmlLineNo} ${LvFgmlLineNoItem}"
        fi
    done
    # Space is not recognised in the eval command. So it should be transferred.
    LvFgmlLineNo=$(echo -e "${LvFgmlLineNo}" | sed "s:\ :\\\\ :g")
#    if [ -z "${LvFgmlLineNo}" ]; then
#        Lfn_Sys_DbgEcho "Sorry, Dont find the line which is matched" 
#    fi  

    eval $1="${LvFgmlLineNo}"
}


## Usage:
##     Lfn_File_GetReverseMatchLine <oResult> <iKeyWord> <iFilePath>
## Details:
##     Get the Line Number of the File located in "<iFilePath>" if "<iKeyWord>" is
##     matched successfully.Then reverse the result and save it to <oResult> 
##
function Lfn_File_GetReverseMatchLine()
{
    Lfn_File_GetMatchLine LvFgrmlLines "$2" "$3"
    LvFgrmlLineSets=""
    for LvFgrmlLine in ${LvFgrmlLines}; do
        LvFgrmlLineSets="${LvFgrmlLine} ${LvFgrmlLineSets}"
    done
    LvFgrmlLines="${LvFgrmlLineSets}"
    LvFgrmlLines=`echo ${LvFgrmlLines} | sed 's#\ #\\\ #g'`
    eval $1="${LvFgrmlLines}"
}


## Usage:
##     Lfn_File_GetFileTailLine <oResult> <iFile>
## Detail:
##     Get the line number at the end of the file.
## Exmaple:
##     Lfn_File_GetFileTailLine oResult  "~/1.txt"
##     echo "EndLine: ${oResult}"
function Lfn_File_GetFileTailLine()
{
    if [ -z "$2" -o ! -e "$2" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit because dont exist \"$2\""
        exit 0
    fi

    LvFgftlLineNo=`sed -n '$=' $2`
    eval $1="${LvFgftlLineNo}"
}



## Usage:
##     Lfn_File_InsertAfterMatchLine <iKeyWord> <iFile>  <iString>
## Details:
##     Insert the "<iString>" to the next line of the File located in "<iFile>"
##     if "<iKeyWord>" is matched successfully. Or Insert the "<iString>" to the
##     tail of the File.
## Parameter:
##     <iKeyWord> - specified string used for matching search file location.
##     <iFilePath> - specify the file path.
##     <iString> - specify the content which is inserted.  # Example:
## Example:
##     Lfn_File_InsertAfterMatchLine  "main" "/home/1.txt" "jielong.lin"
##
function Lfn_File_InsertAfterMatchLine()
{
    if [ -z "$1" -o -z "$2" -o -z "$3" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    if [ ! -e "$2" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit because dont exist \"$2\""
        exit 0
    fi

    Lfn_File_GetReverseMatchLine  LvFiamlLines "$1" "$2"
    for LvFiamlLine in ${LvFiamlLines}; do
        sed "$LvFiamlLine a $3" -i $2
        Lfn_Sys_ColorEcho ${CvBgBlue}  ${CvFgWhite} "Done: insert at next line from ${LvFiamlLine}"
    done
    return
}

## Lfn_File_DownloadFromNet <URL>
function Lfn_File_DownloadFromNet()
{
    if [ -z "$1" -o x"$1" = x"" ]; then
        Lfn_Sys_DbgEcho "Sorry, exit due to the parameter is null"
        exit 0
    fi

    LvFdfnPathfile="$1"
    LvFdfnFile=`basename "${LvFdfnPathfile}"`
    wget -c ${LvFdfnPathfile} -O ${LvFdfnFile}
}



## Usage:
##     Lfn_Line_CheckIfExistSymbol <oResult> <iSymbol> <iContent>
##
## Details:
##     Return 1 if exist.
##     Return 0 if not exist.
##
## Sample:
##     Lfn_Line_CheckIfExistSymbol oResult  "main" "hello world, main entry"
##     echo "$oResult"
function Lfn_Line_CheckIfExistSymbol()
{
    if [ -z "$1" -o -z "$2" -o -z "$3" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to error usage"
        Lfn_Sys_FuncComment
        exit 0
    fi  

    # LvCiseKeyword is only single line, so it doesnt need to be contained by the single quotes.
    LvCiseKeyword=$(echo -e "$2" | sed "s#\/#\\\/#g")
    LvCiseKeyword=$(echo -e "${LvCiseKeyword}" | sed "s:    :\\\\t:g")
    LvCiseKeyword=$(echo -e "${LvCiseKeyword}" | sed "s:\[:\\\[:g")
    LvCiseKeyword=$(echo -e "${LvCiseKeyword}" | sed "s:\]:\\\]:g")
    LvCiseKeyword=$(echo -e "${LvCiseKeyword}" | sed "s:\*:\\\*:g")

    LvCiseResult=$(echo "$3" | sed -n "/${LvCiseKeyword}/=")
    if [ -z "${LvCiseResult}" ]; then
        eval $1="0"
    else
        eval $1="1"
    fi 
}



## Lfn_Cursor_EchoConfig [on|off] 
function Lfn_Cursor_EchoConfig()
{
    if [ -z "$1" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi
    if [ x"$1" = x"off" ]; then
        echo -e "${CvAccOff}\033[?25l${CvAccOff}"
    fi
    if [ x"$1" = x"on" ]; then
        echo -e "${CvAccOff}\033[?25h${CvAccOff}"
    fi
}


## Lfn_Cursor_Position <oXData> <oYData>
##
## Details:
##     Get the cursor position included (x,y)
## 
function Lfn_Cursor_Position()
{
    if [ $# -ne 2 -o -z "$1" -o -z "$2" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    echo -ne '\e[6n'; read -sdR LvCpPosition;
    #LvCpXPos=$(echo "${LvCpPosition#*[}" | cut -d ';' -f 1)
    #LvCpYPos=$(echo "${LvCpPosition#*[}" | cut -d ';' -f 2)

    LvCpXPos=$(echo "${LvCpPosition}" | awk -F ';'  '{print $2}')
    LvCpYPos=$(echo "${LvCpPosition}" | awk -F ';'  '{print $1}')

    eval $1="${LvCpXPos}"
    eval $2="${LvCpYPos}"
}



## Usage:
##     Lfn_Cursor_Move <xNum>  <yNum> 
## Details:
##     xNum: Left/Right towards
##     yNum: Up/Down    towards
## Note:
##     xNum=0 is the same to xNum=1
##     yNum=0 is the same to yNum=1 
## Sample:
##     Lfn_Cursor_Move 100  4
##     sleep 5
##     Lfn_Cursor_Move 100  10 
## 
function Lfn_Cursor_Move()
{
    if [ -z "$1" -o -z "$2" ]; then
        Lfn_Sys_FuncComment
        Lfn_Sys_DbgEcho "Sorry,Exit due to the invalid usage" 
        exit 0
    fi

    echo $1 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        Lfn_Sys_FuncComment
        Lfn_Sys_DbgEcho "Sorry,Return because the parameter1 isn't digit" 
        return; 
    fi

    echo $2 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        Lfn_Sys_FuncComment
        Lfn_Sys_DbgEcho "Sorry,Return because the parameter2 isn't digit" 
        return; 
    fi

    #'\c' or '-n' - dont break line
    LvCmTargetLocation="${CvAccOff}\033[$2;$1H${CvAccOff}"
    echo -ne "${LvCmTargetLocation}"
}


function Lfn_Stdin_Flush()
{
    # clear all data continuely from stdin
    while read -s -t 1 -n 1; do
        continue
    done
}



## Usage:
##     Lfn_Stdin_Read <oKeyData>
## Note:
##     Shell cant recognize the space and enter keycode.
##     So the space and enter keycode will be ignored.
## Sample:
##     Lfn_Stdin_Read  oKeyData
##     echo "Get: $oKeyData"
function Lfn_Stdin_Read()
{
    if [ -z "$1" ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to the bad usage"
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvSrData=""

    # Read one byte from stdin
    trap : 2   # enable to capture the signal from keyboard input
    while read -s -n 1 LvSrData
    do
        case "${LvSrData}" in
        "")
            read -s -n 1 -t 1 LvSrData
            case "${LvSrData}" in
            "[")
                read -s -n 1 -t 1 LvSrData
                case "${LvSrData}" in
                "A")
                    LvSrData="KeyUp"
                ;;
                "B")
                    LvSrData="KeyDown"
                ;;
                "C") 
                    LvSrData="KeyRight"
                ;;
                "D")
                    LvSrData="KeyLeft"
                ;;
                *)
                    Lfn_Sys_DbgEcho "Dont Recognize KeyCode: ${LvSrData}"
                    continue;
                ;;
                esac 
            ;;
            "")
                LvSrData="KeyEsc"
            ;;
            *)
                Lfn_Sys_DbgEcho "Dont Recognize KeyCode: ${LvSrData}"
                continue;
            ;;
            esac
        ;;
        "")
            # Space Key and Enter Key arent recognized
            continue;
        ;;
        *)
            break;
        ;;
        esac
        [ ! -z "${LvSrData}" ] && break;
    done
    trap "" 2  # disable to capture the singal from keyboard input
    eval $1="${LvSrData}"
}

## Lfn_Stdin_GetDigit <oResult> [<prompt>]
##
## Lfn_Stdin_GetDigit  oResult  "hello world: "
## echo "Result: $oResult"
function Lfn_Stdin_GetDigit()
{
    if [ ! -z "$2" ]; then
        LvSgdCmd='read -p "$2 " LvSgdNum'
    else
        LvSgdCmd='read LvSgdNum'
    fi

    LvSgdNum=""
    while [ -z "${LvSgdNum}" ]; do
        eval ${LvSgdCmd}   
        echo ${LvSgdNum} | grep -E '[^0-9]' >/dev/null && LvSgdNum="" || break; 
    done

    eval $1="${LvSgdNum}"
}





#
# GvRenderData[ ] contains all content data from the configure file.
# GvRenderData[ ] format specification :
#     GvRenderData[0]: is set to UI component name if it is initialized. 
#     GvRenderData[1]: is set to UI title.
#     GvRenderData[2...]: Ui content data.
# Note:
#     The offset of GvRenderData[ ] equals to the offset of the Checkbox UI.
#
declare -a GvRenderData
export     GvRenderData
declare -i GvCursorXCurrent
declare -i GvCursorYCurrent


## Lfn_UiCheckBox_RenderFromFile <iConfig> <iTitle> <oLineMin> <oLineMax>
##
## Details:
##     Read a config.Ui and build the UI.
##     Return a config.Ui with the latest updated status
##
##     Cursor Move by a line
## 
## >>>>> Title <<<<<
## [i]	Test0
## [u]	Test1
## [ ]	Test2
## [ ]	Test3
##
function Lfn_UiCheckBox_RenderFromFile()
{
    if [ -z "$1" -o -z "$2" -o -z "$3" -o -z "$4" -o ! -e "$1" ]; then
        Lfn_Sys_FuncComment
        Lfn_Sys_DbgEcho "Sorry, Exit due to the bad parameter"
        exit 0
    fi

    # Check if Configure File is valid
    LvUcbrffMin=1                         # Cursor gt LvUcbrffMin, start with 2
    LvUcbrffMax=${LvUcbrffMin}            # Cursor lt LvUcbrffMax

    # Should render the full image from the configure file
    # Meanwhile, the configure file should be checked if it conforms to the valid format.
    clear
    Lfn_Sys_ColorEcho "${CvBgYellow}" "${CvFgBlack}" ">>>>> $2 <<<<<"
    while read LvUcbrffLine; do
        LvUcbrffMax=`expr ${LvUcbrffMax} + 1`
        Lfn_Line_CheckIfExistSymbol LvUcbrffFlag "[ ]	" "${LvUcbrffLine}"
        if [ x"${LvUcbrffFlag}" = x"1" ]; then
            echo "${LvUcbrffLine}"
            GvRenderData[${LvUcbrffMax}]="${LvUcbrffLine}"
            continue;
        fi
        Lfn_Line_CheckIfExistSymbol LvUcbrffFlag "[i]	" "${LvUcbrffLine}"
        if [ x"${LvUcbrffFlag}" = x"1" ]; then
            echo "${LvUcbrffLine}"
            GvRenderData[${LvUcbrffMax}]="${LvUcbrffLine}"
            continue;
        fi
        Lfn_Line_CheckIfExistSymbol LvUcbrffFlag "[u]	" "${LvUcbrffLine}"
        if [ x"${LvUcbrffFlag}" = x"1" ]; then
            echo "${LvUcbrffLine}"
            GvRenderData[${LvUcbrffMax}]="${LvUcbrffLine}"
            continue;
        fi 
        Lfn_Sys_DbgEcho "Sorry, Exit due to bad configurate file: $1"
        exit 0;
    done < "$1"
    LvUcbrffMax=`expr ${LvUcbrffMax} + 1`
    if [ $(expr ${LvUcbrffMax} - ${LvUcbrffMin}) -lt 2 ]; then
        Lfn_Sys_DbgEcho "Sorry, Exit due to bad configurate file: $1"
        exit 0;
    fi
    GvCursorXCurrent=2
    if [ -z "${GvCursorYCurrent}" ]; then
        GvCursorYCurrent=`expr ${LvUcbrffMin} + 1`
    fi
    GvRenderData[0]="CheckBox"
    GvRenderData[1]="$2"
    Lfn_Cursor_Move ${GvCursorXCurrent} ${GvCursorYCurrent}
    eval $3=${LvUcbrffMin}
    eval $4=${LvUcbrffMax}
}



## Lfn_UiCheckBox_RenderPart <iConfig> <iItem> <iValue>
##
## <iItem> - the number of the item in checkbox
## <iValue> - the value of the item in checkbox, namely is set to i or u or s
##            i: install,   [i]
##            u: uninstall, [u]
##            s: space,     [ ]
##
## Render only a part of an image from the configure file
## Meanwhile, the configure file should be checked if it conforms to the valid format.
function Lfn_UiCheckBox_RenderPart()
{
    if [ $# -ne 3 ]; then
        Lfn_Sys_FuncComment 
        exit 0;
    fi

    if [ ! -e "$1" ]; then
        Lfn_Sys_FuncComment
        exit 0;
    fi

    if [ -z "${GvRenderData[0]}" ]; then
        Lfn_Sys_FuncComment
        exit 0;
    fi

    echo "$2" | grep -E '[^0-9]' >/dev/null && unset LvUcbrpMax || LvUcbrpMax=${#GvRenderData[@]};
    if [ -z "${LvUcbrpMax}" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi
    if [ $2 -gt ${LvUcbrpMax} -o $2 -eq ${LvUcbrpMax} -o $2 -lt 2 ]; then
        Lfn_Sys_FuncComment
        exit 0 
    fi
    if [ x"$3" != x"i" -a x"$3" != x"u" -a x"$3" != x"s" ]; then
        Lfn_Sys_FuncComment
        exit 0
    fi

    LvUcbrpIdx=2
    while [ ${LvUcbrpIdx} -lt ${LvUcbrpMax} ]; do
        if [ ${LvUcbrpIdx} -eq $2 ]; then
            if [ x"$3" = x"i" ]; then
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[u]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[u\]:\[i\]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[u\]:\[i\]:g" -i $1
                    return;
                fi
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[ ]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[ \]:\[i\]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[ \]:\[i\]:g" -i $1
                    return;
                fi
            fi
            if [ x"$3" = x"s" ]; then
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[u]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[u\]:\[ \]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[u\]:\[ \]:g" -i $1
                    return;
                fi
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[i]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[i\]:\[ \]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[i\]:\[ \]:g" -i $1
                    return;
                fi
            fi
            if [ x"$3" = x"u" ]; then
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[i]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[i\]:\[u\]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[i\]:\[u\]:g" -i $1
                    return;
                fi
                Lfn_Line_CheckIfExistSymbol LvUcbrpFlag "[ ]	" "${GvRenderData[${LvUcbrpIdx}]}"
                if [ x"${LvUcbrpFlag}" = x"1" ]; then
                    GvRenderData[${LvUcbrpIdx}]=$(echo "${GvRenderData[${LvUcbrpIdx}]}" | sed  "s:\[ \]:\[u\]:g")
                    Lfn_Cursor_Move 1 ${GvCursorYCurrent}
                    echo -ne "${GvRenderData[${LvUcbrpIdx}]}"
                    Lfn_Cursor_Move 2 ${GvCursorYCurrent}
                    sed      "$(expr ${LvUcbrpIdx} - 1)s:\[ \]:\[u\]:g" -i $1
                    return;
                fi
            fi
 
        fi
        LvUcbrpIdx=`expr ${LvUcbrpIdx} + 1`
    done
}



##################################################
#  jielong.lin: Customized Functions 
##################################################



## Fn_CustomizedUI_Main  <iFile> <iTitle>
##
function Fn_CustomizedUI_Main()
{
    LvCustuiData=""

    # Ctrl_c : 3=SIGINT
    # Ctrl_z : 20=SIGTSTP
    # trap "clear;exit 0" 3 20 
 
    # Show UI Command 
    Lfn_UiCheckBox_RenderFromFile "$1"  "$2 (q: Quit)" LvCuiMin LvCuiMax 
 
    while [ 1 ]; do
        # Read one byte from stdin
        Lfn_Stdin_Read LvCustuiData
        case "${LvCustuiData}" in
        "KeyUp"|"k")
            LvCuiPos=`expr ${GvCursorYCurrent} - 1`
            if [ ${LvCuiPos} -gt ${LvCuiMin} ]; then
                GvCursorYCurrent=${LvCuiPos}
                Lfn_Cursor_Move ${GvCursorXCurrent} ${GvCursorYCurrent}
            fi 
        ;;
        "KeyDown"|"j")
            LvCuiPos=`expr ${GvCursorYCurrent} + 1`
            if [ ${LvCuiPos} -lt ${LvCuiMax} ]; then
                GvCursorYCurrent=${LvCuiPos}
                Lfn_Cursor_Move ${GvCursorXCurrent} ${GvCursorYCurrent}
            fi 
        ;;
        "i")
            Lfn_UiCheckBox_RenderPart "$1" "${GvCursorYCurrent}" "i"
        ;;
        "u")
            Lfn_UiCheckBox_RenderPart "$1" "${GvCursorYCurrent}" "u" 
        ;;
        "s")
            Lfn_UiCheckBox_RenderPart "$1" "${GvCursorYCurrent}" "s" 
        ;; 
        "q")
            clear
            break;
        ;;
        *)
        ;;
        esac
        # echo "Get:$LvCustuiData"
    done 
}


function Fn_Help_Usage()
{
cat >&1 << EOF

[DESCRIPTION]
    Help user to learn about more usage of ${CvScriptName} 

[USAGE-DETAILS]

    ${CvScriptName} [help]
        Offer user for that how to use this command.

    ${CvScriptName} --target=tpv.host --ip=172.20.27.26 [-f]
        remote connect to tpv host addressed in 172.20.27.26
        [-f] is optional, it specifies remote desktop is full-screen mode. 

    172.20.8.200

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


#-----------------------
# The Main Entry Point
#-----------------------

# rdesktop -u jielong.lin -d tpvaoc -f -p 333333 172.20.27.26

GvTpvHostIPv4="TPV-PC"
GvTpvHostPassword=""

GvNetworkTestingTimeout=3

declare -a GvShellCommands=(
    "0		Quit"                    "break"  "0"
    "1		tpv.host=${GvTpvHostIPv4}"   "rdesktop -u jielong.lin -d tpvaoc -f -p \${GvTpvHostPassword} \${GvTpvHostIPv4}" "ping -c 1 -t \${GvNetworkTestingTimeout} \${GvTpvHostIPv4} | grep -Ei 'ttl'"
    "2		tpv.server=172.20.30.29" "ssh jielong.lin@172.20.30.29"   "ping -c 1 -t \${GvNetworkTestingTimeout} 172.20.30.29 | grep -Ei 'ttl'"
)
declare -i GvShellCommandsCount=${#GvShellCommands[@]}/3


GvFlags=$(which rdesktop)
if [ -z "${GvFlags}" ]; then
    aptitude install rdesktop
fi
GvFlags=$(which ssh)
if [ -z "${GvFlags}" ]; then
    aptitude install ssh 
fi



while [ 1 ]; do

    echo ""
    echo "***** Select Menu *****"
    for (( GvIdx=0 ; GvIdx<GvShellCommandsCount ; GvIdx++ )) do
        echo "${GvShellCommands[GvIdx*3]}"
    done

    Lfn_Stdin_GetDigit  GvChoice  " Your Choice:   "
    if [ ${GvChoice} -ge ${GvShellCommandsCount} ]; then
        continue
    fi
    if [ ${GvChoice} -eq 0 ]; then
        exit 0
    fi

    break
done

GvRunTesting="${GvShellCommands[${GvChoice}*3+2]}"
GvRunConnect="${GvShellCommands[${GvChoice}*3+1]}"
GvRunTarget=$(echo "${GvShellCommands[${GvChoice}*3+0]}" | awk -F'=' '{print $2}')

function DemoEntry()
{
cat >&1 << EOF

#--------------------------------------
# Test if ping network successfully
#--------------------------------------
EOF
GvRunTimes=0
while [ ${GvRunTimes} -lt 3 ]; do
    GvNetworkTestingTimeout=$(( GvNetworkTestingTimeout + 5 ))
cat >&1 <<EOF

JLL: Try to connect "${GvRunTarget}" with timeout=${GvNetworkTestingTimeout}s : ${GvRunTimes} times
EOF

    if [ ${GvChoice} -eq 1 ]; then
        GvValidFlag=""
        break
    fi

    GvValidFlag="$(eval ${GvRunTesting})"
    if [ x"${GvValidFlag}" = x ]; then
        echo "JLL: Test Failure"
        GvRunTimes=$(( GvRunTimes + 1 ))
        continue
    fi
    echo "JLL: Test Success"
    echo
    break
done

if [ x"${GvValidFlag}" != x ]; then
    if [ ${GvChoice} -eq 1 ]; then
        echo "If enter Full-Screen Mode by remote desktop, Exit by [Ctrl_Shift_Enter] "
        read -p "Continue by pressing any key "
    fi
    echo "Run: ${GvShellCommands[${GvChoice}*3+1]}" 
    eval ${GvShellCommands[${GvChoice}*3+1]}
else
    if [ ${GvChoice} -eq 1 ]; then
        echo " Please specify the new IPv4 if re-connection, or exit if [enter]"
        read -p "TPV.HostIPv4=" GvTpvHostIPv4
        if [ x"$GvTpvHostIPv4" = x ]; then
            exit 0
        fi
        echo " Please specify the Password when re-connection, or exit if [enter]"
        read -p "TPV.HostPassword=" GvTpvHostPassword
        if [ x"$GvTpvHostPassword" = x ]; then
            exit 0
        fi

        GvValidFlag="$(eval ${GvShellCommands[${GvChoice}*3+2]})"
        if [ x"$GvValidFlag" != x ]; then
            echo "If enter Full-Screen Mode by remote desktop, Exit by [Ctrl_Shift_Enter] "
            read -p "Continue by pressing any key "
            echo "Run: ${GvShellCommands[${GvChoice}*3+1]}" 
            eval ${GvShellCommands[${GvChoice}*3+1]}
            exit 0
        fi
    fi
    Lfn_Sys_DbgEcho "Sorry, Exit because network is invalid"
fi
}

DemoEntry 


exit 0
####################################################################
#  Copyright (c) 2015.  lin_jie_long@126.com,  All rights reserved.
####################################################################


