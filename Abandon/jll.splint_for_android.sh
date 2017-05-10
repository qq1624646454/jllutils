#!/bin/bash

function Fn_Usage()
{
cat >&1 <<EOF

 $(basename $0) [-m0|-m1] [FileList] [SplintParameter]

   @-m0: Default mode, it indicates all c source files are handled but except <FileList> are specified.
   Eg.
       # handle all c source files excepted xxx.c
       $(basename $0)  xxx.c
       $(basenmae $0)  -m0 xxx.c

   @-m1: Except mode, it indicates all c source files aren't handled but except <FileList> are specified. 
       # only handle xxx.c
       $(basename $0)  -m1 xxx.c


EOF
}

#
# Check if the parameters are valid
#
GvMode=0
GvFileList=""
GvSplintFlags=""
GvParseState=0
for GvParameter in $@; do
echo "State=${GvParseState}: ${GvParameter}"
     if [ x"${GvParameter}" = x"-h" ]; then
        if [ x"${GvParseState}" != x"0" ]; then
            echo "JLL: Error due to parse fail"
            exit 0
        fi
        Fn_Usage
        exit 0
    fi

    if [ x"${GvParameter}" = x"-m1" ]; then
        if [ x"${GvParseState}" != x"0" ]; then
            echo "JLL: Error due to parse fail"
            exit 0
        fi
        GvMode=1
        continue
    fi
    if [ -e "$(pwd)/${GvParameter}" ]; then
        if [ x"${GvParseState}" != x"0" ]; then
            if [ x"${GvParseState}" = x"1" ]; then
                GvParameter=$(echo ${GvParameter} | sed -e "s#./##g")
                GvSplintFlags="${GvSplintFlags} -I./${GvParameter}"
                echo "JLL: Hit Splint Parameter is \" -I./${GvParameter} \""
                GvParseState=0
                continue
            fi
        else
            GvFileList="${GvFileList} ${GvParameter}"
            continue
        fi
    fi

    if [ x"${GvParseState}" = x"1" ]; then
        if [ -e "${GvParameter}" ]; then
            GvSplintFlags="${GvSplintFlags} -I${GvParameter}"
            echo "JLL: Hit Splint Parameter is \" -I${GvParameter} \""
            GvParseState=0
            continue
        fi
    fi
 
    case ${GvParameter} in
    -I*)
        GvParameter=`echo ${GvParameter} | sed -e "s/-I//g"` 
        echo "JLL: Check Splint Parameter is \" ${GvParameter} \""
        if [ x"${GvParameter}" != x ]; then
            if [ -e "$(pwd)/${GvParameter}" ]; then
                GvParameter=$(echo ${GvParameter} | sed -e "s#./##g")
                GvSplintFlags="${GvSplintFlags} -I./${GvParameter}"
                echo "JLL: Hit Splint Parameter is \" -I./${GvParameter} \""
                GvParseState=0
                continue
            fi
        else
            GvParseState=1
            continue
        fi
    ;;
    *)
        GvSplintFlags="${GvSplintFlags} ${GvParameter}"
    ;; 

    esac
done

GvFiles=""
if [ x"${GvMode}" = x"0" ]; then
    echo "JLL: Mode is 0: all source files are handled excepted {${GvFileList}}"
    GvFl=$(find . -type f -a -name "*.c" -print)
    if [ x"${GvFl}" = x ]; then
        echo "Sorry, can't find any source file @$(pwd)"
        exit 0
    fi
    if [ x"${GvFileList}" != x ]; then
        i=0
        for GvF in ${GvFl}; do
            GvF_=$(basename ${GvF})
            for GvFile in ${GvFileList}; do
                GvFile=$(basename ${GvFile})
                if [ x"${GvF_}" = x"${GvFile}" ]; then
                    echo "JLL-$i: Filter ${GvF}"
                    ((i+=1))
                    GvF_=""
                    break
                fi
            done
            if [ x"${GvF_}" != x ]; then
               GvFiles="${GvFiles} ${GvF}" 
            fi
        done
    else
        GvFiles="${GvFl}"
    fi
else
    echo "JLL: Mode is 1: {${GvFileList}} are handled excepted"
    for GvFile in ${GvFileList}; do
        GvFiles="${GvFiles} ${GvFile}"
    done 
fi

if [ x"${GvFiles}" = x ]; then
    echo "JLL: Sorry to exit due to lack of C source files"
    exit 0
fi




GvDate=$(date +%Y%m%d)

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

function Lfn_Sys_GetEachUpperLevelPath()
{
    if [ -z "$1" ]; then
        echo "Error and Exit | Lfn_Sys_GetEachUpperLevelPath() - usage is incorrect "
        exit 0
    fi

    LvGadoulPaths=""
    LvGadoulPath=`pwd`
    while [ x"${LvGadoulPath}" != x -a x"${LvGadoulPath}" != x"/" ]; do
        if [ -z "${LvGadoulPaths}" ]; then
            LvGadoulPaths="${LvGadoulPath}"
        else
            LvGadoulPaths="${LvGadoulPaths}:${LvGadoulPath}"
        fi

        #LvGadoulBasename=`basename "${LvGadoulPath}"`
        #LvGadoulPath=`echo "${LvGadoulPath}" | sed "s/\/${LvGadoulBasename}//"`
        LvGadoulPath=`cd ${LvGadoulPath}/..;pwd`
    done

    LvGadoulPaths=`echo "${LvGadoulPaths}" | sed "s/\ /\\\\\ /g"`
    if [ -z "${LvGadoulPaths}" ]; then
        echo "Fail to find the required PATH and Exit"
        exit 0
    fi

    eval $1="${LvGadoulPaths}"
}




function Lfn_Sys_GetSameLevelPath()
{
    if [ $# -ne 2 -o -z "$2" ]; then
        echo "Error and Exit | Lfn_Sys_GetSameLevelPath() - usage is incorrect "
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
        echo
        echo "Matching:\"${LvSgslpKey}\""
        echo "  ├──SearchPath= \"${LvSgslpPath}\""
        for LvSgslpKey in ${LvSgslpKeywords}; do
            LvSgslpEntrys="$(ls -a ${LvSgslpPath})"
            for LvSgslpEntry in ${LvSgslpEntrys}; do
                if [ x"${LvSgslpEntry}" = x"${LvSgslpKey}" ]; then
        echo "  │  ├──Matching= \"${LvSgslpEntry}\" (Hit)"
                    LvSgslpPath=`echo "${LvSgslpPath}" | sed "s/\ /\\\\\ /g"`
                    eval $1="${LvSgslpPath}"
                    IFS=$OldIFS
        echo
        echo "Done-Success: \"${LvSgslpPath}\""
                    echo
                    return 0
                fi
        echo "  │  ├──Matching= \"${LvSgslpEntry}\""
            done
        done
        IFS=:
    done
    IFS=$OldIFS
    echo
    echo "Done-Failure: FinalPath=\"${LvSgslpPath}\""
    echo
    return 0
}



#
# Find the same level path which contains .git folder
#

Lfn_Sys_GetSameLevelPath  GvPrjRootPath ".repo"
if [ ! -e "${GvPrjRootPath}" ]; then
    echo "Path=\"${GvPrjRootPath}\"" 
    echo "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

TOPDIR=${GvPrjRootPath}

echo
echo "TOPDIR=${TOPDIR}"
echo


echo
echo "***********************************************************"
echo "**  SPLINT To Check If C Programming Language Is Well    **"
echo "***********************************************************"
echo

if [ 0 -eq 1 ]; then
splint -I./ \
       -I${TOPDIR}/system/core/include \
       -I${TOPDIR}/hardware/libhardware/include \
       -I${TOPDIR}/hardware/libhardware_legacy/include  \
       -I${TOPDIR}/hardware/ril/include \
       -I${TOPDIR}/dalvik/libnativehelper/include  \
       -I${TOPDIR}/frameworks/base/include \
       -I${TOPDIR}/frameworks/base/opengl/include  \
       -I${TOPDIR}/external/skia/include \
       ${GvSplintFlags}  \
       ${GvFiles}
else
GvSplintFlags="${GvSplintFlags} -I android-arm -skip-sys-headers -skip-iso-headers  +D__gnuc_va_list=int  +D__builtin_va_list=int  -preproc -retvalint -warnposix -warnposixheaders -nestcomment +bounds -showconstraintlocation "

GvSplintFlags="${GvSplintFlags}" 
#GvSplintFlags="${GvSplintFlags} -I android-arm -nestcomment"
cat >&1 <<EOF
splint -I./ \
       -I${TOPDIR}/system/core/include \
       -I${TOPDIR}/hardware/libhardware/include \
       -I${TOPDIR}/hardware/libhardware_legacy/include  \
       -I${TOPDIR}/hardware/ril/include \
       -I${TOPDIR}/dalvik/libnativehelper/include  \
       -I${TOPDIR}/frameworks/base/include \
       -I${TOPDIR}/frameworks/base/opengl/include  \
       -I${TOPDIR}/external/skia/include \
       ${GvSplintFlags}  \
       ${GvFiles}
EOF

splint -I./ \
       -I${TOPDIR}/system/core/include \
       -I${TOPDIR}/hardware/libhardware/include \
       -I${TOPDIR}/hardware/libhardware_legacy/include  \
       -I${TOPDIR}/hardware/ril/include \
       -I${TOPDIR}/dalvik/libnativehelper/include  \
       -I${TOPDIR}/frameworks/base/include \
       -I${TOPDIR}/frameworks/base/opengl/include  \
       -I${TOPDIR}/external/skia/include \
       ${GvSplintFlags}  \
       ${GvFiles}
fi
