#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

function Lfn_Usage()
{
    echo ""
    echo "Usage:  $(which $0) <BitMask>"
    echo "        @ <BitMask>: in {0~31} range, it identify which bit is used as enable switch"
    echo ""
    echo "  The log output will be enable only when the <BitMask> bit is"
    echo "  set to 1 in property 'persist.jll_alog'"
    echo ""
}

if [ $# -ne 1 ]; then
    Lfn_Usage
    exit 0
fi

echo $1 | grep -E '[^0-9]' >/dev/null && GvBitMask="" || GvBitMask=$1;
if [ x"${GvBitMask}" = x ]; then
    echo ""
    echo "Sorry, Parameter 1 isn't a digit"
    Lfn_Usage
    exit 0
fi

if [ ${GvBitMask} -lt 0 -o ${GvBitMask} -gt 31 ]; then
    echo ""
    echo "Sorry, Parameter 1 isn't in {0-31} range"
    Lfn_Usage
    exit 0
fi

GvLogTag="LOG_TAG"

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
        Lfn_Sys_DbgEcho "Sorry, Could you please use check if the usage is correct" 
        eval $1="0"
        return; 
    fi

    LvFciesFlag=`grep -inr "$2" $3`  
    if [ -z "${LvFciesFlag}" ]; then
        eval $1="0"
    else
        eval $1="1" 
    fi
}


GvDate=$(date +%Y%m%d%H%M%S)
## Lfn_InsertToFile iLineNo iFile iLogTag
function Lfn_InsertCustomToFile()
{
    if [ x"$3" = x ]; then
        echo ""
        echo "Sorry, invalid parameter 3 in Lfn_InsertCustomToFile()"
        echo ""
        exit 0
    fi

    LvFileLine=$1

    LvContent="/*** JLL.S${GvDate}: Change Logcat With Property ***/"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#include <android/log.h>"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#include <cutils/properties.h>"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
 
    LvContent="#ifdef __cplusplus"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent='extern "C" {'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent='static int i4JllAlogPropVal = property_get_int32("persist.jll_alog", 0);'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#define jll_alog${GvBitMask}(...)   \\\\"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent='\ \ \ \ \ \ \ \ \ \ \ \ do {  \\'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ if (i4JllAlogPropVal && (i4JllAlogPropVal & (0x1<<${GvBitMask}))) {  \\\\"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ __android_log_print(ANDROID_LOG_INFO, $3,\"%s,%d@%s\" __VA_ARGS__, \\\\"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ __FUNCTION__, __LINE__, __FILE__); \\\\"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent='\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ } \\'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent='\ \ \ \ \ \ \ \ \ \ \ \ } while (0);'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef ALOGV"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#undef ALOGV"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#define ALOGV(...)  jll_alog${GvBitMask}(__VA_ARGS__)"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef ALOGD"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#undef ALOGD"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#define ALOGD(...)  jll_alog${GvBitMask}(__VA_ARGS__)"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef ALOGI"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#undef ALOGI"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#define ALOGI(...)  jll_alog${GvBitMask}(__VA_ARGS__)"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef ALOGW"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#undef ALOGW"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#define ALOGW(...)  jll_alog${GvBitMask}(__VA_ARGS__)"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef ALOGE"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#undef ALOGE"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#define ALOGE(...)  jll_alog${GvBitMask}(__VA_ARGS__)"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="#ifdef __cplusplus"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent='}'
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))
    LvContent="#endif"
    sed "${LvFileLine} a ${LvContent}" -i $2
    ((LvFileLine+=1))

    LvContent="/*** JLL.E${GvDate}: Change Logcat With Property ***/"
    sed "${LvFileLine} a ${LvContent}\n" -i $2
    ((LvFileLine+=1))
}






### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

GvCurrentPath=$(pwd)
GvCppFiles=$(find ${GvCurrentPath} -type f | grep -Ei "*.cpp")
for GvCppF in ${GvCppFiles}; do
#    sed "s://#define LOG_NDEBUG 0:#define LOG_NDEBUG 0:g" -i ${GvCppF} 
     GvFlag="Change Logcat With Property"
     Lfn_File_CheckIfExistSymbol GvResult "${GvFlag}" "${GvCppF}"
     if [ ${GvResult} -eq 1 ]; then
         echo -e "Have already Modified @ \033[0m\033[31m\033[43m${GvCppF}\033[0m"
     else
         echo -e "Modifying @ \033[0m\033[31m\033[43m${GvCppF}\033[0m"
         GvFlag="alog"
         Lfn_File_CheckIfExistSymbol GvResult "${GvFlag}" "${GvCppF}"
         if [ ${GvResult} -eq 0 ]; then
             echo "Don't find any android log API, and don't need to change ALOGx(...)"
             continue
         fi
         GvLogTag="LOG_TAG"
         Lfn_File_CheckIfExistSymbol GvResult "${GvLogTag}" "${GvCppF}"
         if [ ${GvResult} -eq 0 ]; then
             echo "Don't find any ${GvLogTag}, and force set LOG_TAG to \"jll_alog${GvBitMask}\""
             GvLogTag="\"jll_alog${GvBitMask}\""
         fi

         GvLineSet=$(grep -Ewn 'namespace[\ a-zA-Z0-9_]*{' "${GvCppF}" | awk -F ':' '{print $1}')
         if [ -z "${GvLineSet}" ]; then
             echo "Don't find target symbol: namespace[\\ a-zA-Z0-9_]*{"
             continue 
         fi
         for GvFileLine in ${GvLineSet}; do
             break;
         done
         if [ ! -z "${GvFileLine}" ]; then
             if [ ${GvFileLine} -ge 1 ]; then
                 ((GvFileLine -= 1))
             fi
             echo "Change is inserted @ Line: ${GvFileLine}"
             Lfn_InsertCustomToFile ${GvFileLine} ${GvCppF} "${GvLogTag}"
         fi
         echo -e "\r\n"
     fi
done

git status -s

