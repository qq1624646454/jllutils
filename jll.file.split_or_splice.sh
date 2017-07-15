#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.file.split_or_splice.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-14 10:06:43
#   ModifiedTime: 2017-07-15 17:52:37
JLLPATH="$(which $0)"
# ./xxx.sh
# ~/xxx.sh
# /home/xxx.sh
# xxx.sh
if [ x"${JLLPATH}" != x ]; then
    __CvScriptName=${JLLPATH##*/}
    __CvScriptPath=${JLLPATH%/*}
    if [ x"${__CvScriptPath}" = x ]; then
        __CvScriptPath="$(pwd)"
    else
        __CvScriptPath="$(cd ${__CvScriptPath};pwd)"
    fi
    if [ x"${__CvScriptName}" = x ]; then
        echo
        echo "JLL-Exit:: Not recognize the command \"$0\", then exit - 0"
        echo
        exit 0
    fi 
else
    echo
    echo "JLL-Exit:: Not recognize the command \"$0\", then exit - 1"
    echo
    exit 0
fi

JLLCFG_CONFIG_PATH="${HOME}/.cache/jllutils"
JLLCFG_CONFIG_FILE="${JLLCFG_CONFIG_PATH}/${__CvScriptName}"
if [ ! -d "${JLLCFG_CONFIG_PATH}" ]; then
    mkdir -pv ${JLLCFG_CONFIG_PATH}
fi

##################################################################################################
## Default Settings, But They will be replaced by ${JLLCFG_CONFIG_FILE} 
##################################################################################################

JLLCFG_HUMAN_COUNT=1 #32 #Beyond it, Tool will privode input search for file selecting.
JLLCFG_UNIT_SIZE=$((1024 * 1024))  # 1024 * 1024 = 1MB. Tool will list the files beyond 1MB
JLLCFG_SUFFIX_LENGTH=10
JLLCFG_PREFIX_NAME=_sp_

if [ x"$(ls ${JLLCFG_CONFIG_FILE} 2>/dev/null)" != x ]; then
    . ${JLLCFG_CONFIG_FILE}
fi


JLLPATH="${__CvScriptPath}"
source ${JLLPATH}/BashShellLibrary

# TEST: make a file with size 1KB - dd if=/dev/zero of=./test_1kb bs=1K count=1

___i=0
declare -i GvPageUnit=10
declare -a GvPageMenuUtilsContent

GvPageMenuUtilsContent[___i++]=\
"Settings:   configurate workflow for customizing various users' requirements"

GvPageMenuUtilsContent[___i++]=\
"Split_From_Other:  split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} \
BIG_FILE ${JLLCFG_PREFIX_NAME}"

GvPageMenuUtilsContent[___i++]=\
"Split_From_Current:  split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} \
BIG_FILE ${JLLCFG_PREFIX_NAME}"

__CHK_debris="$(ls ${JLLCFG_PREFIX_NAME}* 2>/dev/null)"
if [ x"${__CHK_debris}" != x ]; then
GvPageMenuUtilsContent[___i++]=\
"Splice:  cat ${JLLCFG_PREFIX_NAME}* > BIG_FILE; md5sum -b BIG_FILE > BIG_FILE.md5sum"
fi

Lfn_PageMenuUtils_Plus __resultI "Select" 7 4 "***** SPLIT or SPLICE (q: quit) *****"
if [ x"${__resultI}" = x -o ${__resultI} -ge ${___i} ]; then
    __result="none"
fi
__result="${GvPageMenuUtilsContent[__resultI]}"



##################################################################
## Action for Menu
##################################################################

while [ x"${__result%%:*}" = x"Settings" ]; do 


if [ x"$(ls ${JLLCFG_CONFIG_FILE} 2>/dev/null)" = x ]; then
cat >${JLLCFG_CONFIG_FILE} <<EOF
#!/bin/bash
# Copyright(c) 2017-2100.  jielong.lin@qq.com.     All rights reserved.
#
# Automatically generated configuration by ${__CvScriptName}
# @$(date +%Y-%m-%d\ %H:%M:%S)
#################################################################################


#Beyond it, Tool will privode input search for file selecting.
#
#  If the number of the listed legal files is less than JLLCFG_HUMAN_COUNT
#
#      ***** Select a Big File to SPLIT (q: quit) *****
#      ├── HttpRingBuffer_ExoPlayer.tgz:  93M
#      ├── MediaPlayerTestDemo.zip:  219M
# 
#  else you must remember the filename and path, contained the current path, to type.
#
#      JLL: Please type Big File for split(q: Quit)     /home/tpv/ssh.config.tgz
#      or
#      JLL: Please type Big File for split(q: Quit)     test_1kb
#
# Default by 32
JLLCFG_HUMAN_COUNT=32 

#It is valid only for Split, and it also represent the slice file size.
#   Tool can only collect the legal files which size must be beyond JLLCFG_UNIT_SIZE,
#   namely it will ignore much small files because they should not be splitted.
#
# Default by 1024 * 1024 = 1MB
JLLCFG_UNIT_SIZE=\$((1024 * 1024))


#Split a big file and output many slices with orderring by the specified format.As follows:
#    Xaa, Xab, Xac, ..., Xaz, Xba, Xbb, Xbc, ..., Xbz, ..., Xza, Xzb, Xzc, ..., Xzz
#
# (1) X is the prefix name which can be specified by JLLCFG_PREFIX_NAME
# (2) aa...zz is the suffix name with two characters, and its character number is specified 
#     by JLLCFG_SUFFIX_LENGTH
# 
# Default by 10
JLLCFG_SUFFIX_LENGTH=10

#Split a big file and output many slices with prefix name \${JLLCFG_PREFIX_NAME}
# Default by _sp_
JLLCFG_PREFIX_NAME=_sp_

EOF
chmod 0777 ${JLLCFG_CONFIG_FILE}
fi

vim ${JLLCFG_CONFIG_FILE}

break
done




while [ x"${__result%%:*}" = x"Split_From_Other" ]; do 
    __BigFile=""
        while [ x"${__BigFile}" = x -o ! -e "${__BigFile}" ]; do
            echo -ne "${Bgreen}${Fblack}\
JLL: Please type Big File with ${Fyellow}PATH${Fblack} for split(q: Quit)${AC}  \033[04m   "
            read __BigFile
            echo -ne "\033[0m"
            if [ x"${__BigFile}" = x"q" ]; then
                break
            fi 
            if [ x"${__BigFile}" = x ]; then
                echo "JLL: Failure because unfortunately type a null name as the big filename" 
                continue
            fi
            if [ -e "$(pwd)/${__BigFile}" ]; then
                __BigFile="$(pwd)/${__BigFile}"
            fi
            if [ x"$(ls -l ${__BigFile} 2>/dev/null | grep -E '^-')" = x ]; then
                echo "JLL: not found \"${__BigFile}\""
                __BigFile=""
            fi
        done

    if [ x"${__BigFile}" = x ]; then 
        echo -e "${Fred}jll: Not obtain the Big File because of some mistakes ${AC}"
        echo
        break
    fi

    if [ x"${__BigFile}" = x"q" ]; then
        echo -e "${Fred}jll: quit to over immediately ${AC}"
        echo
        break
    fi

    echo
    echo -e "${Bseablue}                                        ${AC}"
    echo -e "${Bseablue}  ${AC}JLL: ${Fseablue}${__BigFile}${AC} will be splitted."
    echo -e "${Bseablue}                                        ${AC}"
    echo

    __TargetFile=${__BigFile##*/}__slices
    __TargetFile="$(pwd)/${__TargetFile}"
    if [ -e "${__TargetFile}" ]; then
        rm -rvf ${__TargetFile}
    fi
    mkdir -pv ${__TargetFile}
    cd ${__TargetFile}
    echo
    echo -e "${Bgreen}${Fblack}md5sum -b ${__BigFile} > origin.md5sum${AC}"
    md5sum -b ${__BigFile} > origin.md5sum
    echo -e "\
${Bgreen}${Fblack}split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} \
${__BigFile} ${JLLCFG_PREFIX_NAME} ${AC}"
    split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} ${__BigFile} ${JLLCFG_PREFIX_NAME}
    cd - >/dev/null
    echo 
break
done




while [ x"${__result%%:*}" = x"Split_From_Current" ]; do 
    __BigFile=""

    __doCMD_="find ./ \\( -regex \".*/?\.git\" -o -regex \".*/\..*\" \\) -prune"
    __doCMD_="${__doCMD_} -o -type f -size +${JLLCFG_UNIT_SIZE}c -print"
    __doCMD_="${__doCMD_} -exec ls -lh {} \\;"
    __doCMD_="${__doCMD_} | grep -E '^-'"
    echo
    echo    "JLL: Be probing by executing the follows:"
    echo -e "${Fyellow}${__doCMD_}${AC} | wc -l"
    echo
    echo
    echo -ne "JLL: Progressing For Collecting the legal files count...  "
    Lfn_Sys_Rotate_With_SIGNAL &
    __RotateBgPID_=$!
    __FLcnt=$(eval "${__doCMD_} | wc -l")
    sleep 1
    #kill -9 ${__RotateBgPID_} >/dev/null
    kill -12 ${__RotateBgPID_} >/dev/null
    sleep 1
    echo
    echo
    echo
    echo "JLL:  Probed the legal files number=${__FLcnt}, to compare  ${JLLCFG_HUMAN_COUNT}"
    if [ x"${__FLcnt}" != x -a ${__FLcnt} -le ${JLLCFG_HUMAN_COUNT} ]; then
        echo
        echo    "JLL: Be probing by executing the follows:"
        echo -e "${Fyellow}${__doCMD_}${AC} | wc -l"
        echo
        echo
        echo -ne "JLL: Progressing For Collecting the legal files...  "
        Lfn_Sys_Rotate_With_SIGNAL &
        __RotateBgPID_=$!
        __FLlist=$(eval "${__doCMD_}")
        sleep 1
        kill -12 ${__RotateBgPID_} >/dev/null
        sleep 1
        echo
        [ x"${GvPageUnit}" != x ] && unset GvPageUnit 
        [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent

        ___i=0
        declare -i GvPageUnit=10
        declare -a GvPageMenuUtilsContent

        OIFS=${IFS}
        IFS=$'\n'
        for __FL in ${__FLlist}; do
            __FL="${__FL##*./}"
            if [ -e "$(pwd)/${__FL}" ]; then
                __FLsz="$(du -h ${__FL} | awk -F' ' '{print $1}')"
                GvPageMenuUtilsContent[___i++]="${__FL}:  ${__FLsz}"
            fi
        done
        IFS=${OIFS}

        Lfn_PageMenuUtils_Plus __resultJ "Select" 7 4 \
                                         "***** Select a Big File to SPLIT (q: quit) *****"
        if [ x"${__resultJ}" = x -o ${__resultJ} -ge ${___i} ]; then
            echo "JLL: not found any legal big file in current path, maybe check your settings"
            __result2="none"
        fi
        __result2="${GvPageMenuUtilsContent[__resultJ]}"
        __BigFile="${__result2%%:*}"

        if [ x"${__BigFile}" != x -a -e "$(pwd)/${__BigFile}" ]; then
            __BigFile="$(pwd)/${__BigFile}"
        fi
        if [ x"${__BigFile}" != x -a y"$(ls -l ${__BigFile} 2>/dev/null | grep -E '^-')" = y ]; 
        then
            echo -e "${Fred}jll: Not exist the Big File named ${__BigFile} ${AC}"
            __BigFile=""
        fi
    else
        while [ x"${__BigFile}" = x -o ! -e "${__BigFile}" ]; do
            echo -ne \
            "${Bgreen}${Fblack}JLL: Please type Big File for split(q: Quit)${AC}  \033[04m   "
            read __BigFile
            echo -e "\033[0m"
            if [ x"${__BigFile}" = x"q" ]; then
                break
            fi 
            if [ x"${__BigFile}" = x ]; then
                echo "JLL: unfortunately type a null name as the big filename" 
                continue
            fi
            if [ -e "$(pwd)/${__BigFile}" ]; then
                __BigFile="$(pwd)/${__BigFile}" 
            fi
            if [ x"$(ls -l ${__BigFile} 2>/dev/null | grep -E '^-')" = x ]; then
                echo "JLL: not found \"${__BigFile}\""
                __BigFile=""
            fi
        done
    fi

    if [ x"${__BigFile}" = x ]; then 
        echo -e "${Fred}jll: Not obtain the Big File because of some mistakes ${AC}"
        echo
        break
    fi

    if [ x"${__BigFile}" = x"q" ]; then
        echo -e "${Fred}jll: quit to over immediately ${AC}"
        echo
        break
    fi

    echo
    echo -e "${Bseablue}                                        ${AC}"
    echo -e "${Bseablue}  ${AC}JLL: ${Fseablue}${__BigFile}${AC} will be splitted."
    echo -e "${Bseablue}                                        ${AC}"
    echo

    __TargetFile=${__BigFile}__slices
    if [ -e "${__TargetFile}" ]; then
        rm -rvf ${__TargetFile}
    fi
    mkdir -pv ${__TargetFile}
    cd ${__TargetFile}
    echo
    echo -e "${Bgreen}${Fblack}md5sum -b ${__BigFile} > origin.md5sum${AC}"
    md5sum -b ${__BigFile} > origin.md5sum
    echo -e "\
${Bgreen}${Fblack}split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} \
${__BigFile} ${JLLCFG_PREFIX_NAME} ${AC}"
    split -a${JLLCFG_SUFFIX_LENGTH} -b ${JLLCFG_UNIT_SIZE} ${__BigFile} ${JLLCFG_PREFIX_NAME}
    cd - >/dev/null
    echo 
break
done




while [ x"${__result%%:*}" = x"Splice" ]; do 
    __TargetFile="$(pwd)"
    __TargetFile="${__TargetFile##*/}"
    __TargetFile="${__TargetFile//\//_}"
    __TargetFile="${__TargetFile/%__slices/}"

    while [ x"${__TargetFile}" = x -o y"${__TargetFile}" = y"/" ]; do
        echo
        echo -ne "\
${Bgreen}${Fblack}JLL: Please Name filename to be spliced (q: Quit)${AC}  \033[04m\
${Fgreen}   ${AC}"
        read __TargetFile
        echo -ne "\033[0m"
        if [ x"${__TargetFile}" = x"q" ]; then
            break
        fi
        if [ x"$(echo ${__TargetFile} | grep -E ^${JLLCFG_PREFIX_NAME})" != x ]; then
            echo -e "\
${Fred}jll: Failure that new filename \"${Fgreen}${__TargetFile}${Fred}\" is \
started with ${Fgreen}${JLLCFG_PREFIX_NAME} ${AC}"
            continue
        fi
    done
    if [ x"${__TargetFile}" = x ]; then
        echo -e "${Fred}jll: Not obtain the legal spliced file name because of some mistakes ${AC}"
        echo
        break
    fi
    if [ x"${__TargetFile}" = x"q" ]; then
        echo -e "${Fred}jll: quit to over immediately ${AC}"
        echo
        break
    fi

    echo
    echo -e "${Bseablue}                                        ${AC}"
    echo -e "${Bseablue}  ${AC}JLL: ${Fseablue}${__TargetFile}${AC} will be spliced."
    echo -e "${Bseablue}                                        ${AC}"
    echo
    cat _sp_* >${__TargetFile}
    md5sum -b ${__TargetFile} > ${__TargetFile}.md5sum
    if [ -e "$(pwd)/origin.md5sum" ]; then
        __CHK_Orig=$(cat origin.md5sum | awk -F ' ' '{print $1}')
        __CHK_Cur=$(cat ${__TargetFile}.md5sum | awk -F ' ' '{print $1}')
        if [ x"${__CHK_Orig}" = x"${__CHK_Cur}" ]; then
            echo -e "${Bseablue}                                        ${AC}"
            echo -e "${Bseablue}  ${AC}JLL: ${Fseablue}${__TargetFile}${AC} is spliced Okay."
            echo -e "${Bseablue}                                        ${AC}"
        else
            echo -e "${Bred}                                        ${AC}"
            echo -e "${Bred}  ${AC}JLL: ${Fred}${__TargetFile}${AC} is spliced Failure."
            echo -e "${Bred}                                        ${AC}"
        fi
    else
        echo -e "${Bpink}                                        ${AC}"
        echo -e "${Bpink}  ${AC}JLL: ${Fpink}${__TargetFile}${AC} is spliced but not verified."
        echo -e "${Bpink}                                        ${AC}"
    fi

break
done


[ x"${__result}" != x ] && unset __result
[ x"${GvPageUnit}" != x ] && unset GvPageUnit 
[ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
exit 0

