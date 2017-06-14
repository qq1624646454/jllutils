#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"

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


# adapt to more/echo/less and so on
  ESC=
  AC=${ESC}[0m
  Fblack=${ESC}[30m
  Fred=${ESC}[31m
  Fgreen=${ESC}[32m
  Fyellow=${ESC}[33m
  Fblue=${ESC}[34m
  Fpink=${ESC}[35m
  Fseablue=${ESC}[36m
  Fwhite=${ESC}[37m
  Bblack=${ESC}[40m
  Bred=${ESC}[41m
  Bgreen=${ESC}[42m
  Byellow=${ESC}[43m
  Bblue=${ESC}[44m
  Bpink=${ESC}[45m
  Bseablue=${ESC}[46m
  Bwhite=${ESC}[47m


function _FN_help()
{
more >&1<<EOF

${Fyellow}Usage on Production${AC}
${BYellow}------------------------------------------------------${AC}
${Fgreen}persist.sys.jll_pr = 0x1<<1 = 0x1  ${Fpink}# enable the ALOGV${AC}
${Fgreen}persist.sys.jll_pr = 0x1<<2 = 0x2  ${Fpink}# enable the ALOGD${AC}
${BYellow}------------------------------------------------------${AC}

EOF
}



GvContent="/*** JLL.S$(date +%Y%m%d): Tracing with property ***/ \
\n#include <cutils/properties.h> \
\n#include <utils/Log.h> \
\n\
\n#ifdef ALOGV \
\n#undef ALOGV \
\n#endif \
\n#define ALOGV(...) \\\\\
\n            do { \\\\\
\n                if (property_get_int32(\"persist.sys.jll_pr\", 0) & 0x1) { \\\\\
\n                    (void)ALOG(LOG_INFO, LOG_TAG, __VA_ARGS__); \\\\\
\n                }\\\\\
\n            } while (0)\
\n\
\n#ifdef ALOGD \
\n#undef ALOGD \
\n#endif \
\n#define ALOGD(...) \\\\\
\n            do { \\\\\
\n                if (property_get_int32(\"persist.sys.jll_pr\", 0) & 0x2) { \\\\\
\n                    (void)ALOG(LOG_INFO, LOG_TAG, __VA_ARGS__); \\\\\
\n                }\\\\\
\n            } while (0)\
\n\
\n/*** JLL.E$(date +%Y%m%d): Tracing with property ***/\
\n"


GvCurrentPath=$(pwd)
GvFiles=$(find ${GvCurrentPath} -type f -a -name \*.cpp -print)
declare -a __lstFiles
declare -i __iFiles=0
declare -a __lstFLines
for GvFL in ${GvFiles}; do
    #sed "s://#define LOG_NDEBUG 0:#define LOG_NDEBUG 0:g" -i ${GvCppF}
    GvFLns=$(grep -E -n -i "^[ \t]{0,}//[ \t]{0,}#[ \t]{0,}define[ \t]{1,}LOG_NDEBUG[ \t]{1,}0" ${GvFL})
    if [ x"${GvFLns}" != x ]; then
        __GvFLns=$(grep -E -n -i "Tracing with property" ${GvFL})
        if [ x"${__GvFLns}" != x ]; then
            continue
        fi
        __lstFiles[__iFiles]="${GvFL}"
#        echo -e "JLL-Parse| \n${GvFLns}"
        OldIFS="${IFS}"
        IFS=$'\n'
        for GvFLn in ${GvFLns}; do
#            echo -e "JLL-Parsing| ${GvFLn} \n${GvFLn%%:*}"
            __lstFLines[__iFiles]="${GvFLn%%:*} ${__lstFLines[__iFiles]}"
        done
        IFS="${OldIFS}"
        __iFiles=$((__iFiles+=1))
    fi
done
unset GvFiles
if [ ${__iFiles} -lt 1 ]; then
    unset __lstFiles
    unset __lstFLines
    unset __iFiles
    echo
    echo "JLL: Exit due to none file contain \"//#define LOG_NDEBUG 0\""
    echo
    _FN_help
    exit 0
fi

if [ -e "$(pwd)/report_from_${__CvScriptName}.read_by_more" ]; then
    rm -rf $(pwd)/report_from_${__CvScriptName}.read_by_more 
fi

for((iFL=0; iFL<__iFiles; iFL++)){
    __FL="${__lstFiles[iFL]}"
    for iLn in ${__lstFLines[iFL]}; do
        echo -ne "\r\n\033[0m\033[31m\033[43m${__FL##${GvCurrentPath}/}\033[0m:  line=${iLn}\r\n" \
          | tee -a report_from_${__CvScriptName}.read_by_more
        if [ ${iLn} -gt 0 ]; then
            sed -e "${iLn} a ${GvContent}" -i ${__FL}
        else
            echo "JLL-Error: ${iLn} <= 0  is invalid condition"
            iFL=${__iFiles} 
            break;
        fi
    done
}

[ x"${__lstFiles}" != x ] && unset __lstFiles
[ x"${__lstFLines}" != x ] && unset __lstFLines
[ x"${__iFiles}" != x ] && unset __iFiles
git status -s


more >&1<<EOF

Please check if Android.mk contain the follows:
---------------------------------------------------
${Fseablue}LOCAL_C_INCLUDES += \$(TOP)/system/core/include${AC}
${Fseablue}LOCAL_SHARED_LIBRARIES += libcutils ${Fpink}# Support for property_get_int32(...)${AC}
${Fseablue}LOCAL_SHARED_LIBRARIES += liblog    ${Fpink}# Support for __android_log_print(...)${AC}

EOF
_FN_help

