#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
#    sed "s://#define LOG_NDEBUG 0:#define LOG_NDEBUG 0:g" -i ${GvCppF}


##
## Add the miss libraries to Android.mk by automatically
##   LOCAL_SHARED_LIBRARIES := libcutils liblog
##


GvCurrentPath=$(pwd)
GvFiles=$(find ${GvCurrentPath} -type f | grep -Ew "Android.mk")
for GvFile in ${GvFiles}; do
     echo -e "\033[0m\033[31m\033[43m@${GvFile}\033[0m"

     # Get the total line count
     GvFileLines=$(sed -n '$=' ${GvFile})
     GvKeyLineNumbers=$(grep -En "LOCAL_SHARED_LIBRARIES[ :+]*=" "${GvFile}" | awk -F ':' '{print $1}')

     GvStatus=0
     GvMachine=""
     declare -a GvWhereTable
     declare -a GvNewTargetTable
     declare -i GvTableCnt=0
     for ((i=1; i<=GvFileLines; i++)) {
         GvContent=$(sed -n "${i}p" ${GvFile})
         GvFlag=$(echo "${GvContent}" | grep -E "LOCAL_SHARED_LIBRARIES[ :+]*=")
         case ${GvStatus} in
         0) # Uninit
             if [ x"${GvFlag}" = x ]; then
                 # Skip because the current line isn't a start with the target
                 continue
             fi
             GvContent=$(echo "${GvContent}" | sed 's/LOCAL_SHARED_LIBRARIES[ :+]*=//g')
             GvMachine="$i :: ${GvContent}"
             GvMachine=$(echo "${GvMachine}" | sed 's/[ ]*\\$/ /g')
             

             GvFlag=$(echo "${GvContent}" | sed -n '/\\$/p')
             if [ x"${GvFlag}" = x ]; then 
                 GvStatus=1
             else
                 GvStatus=2
             fi
         ;;
         1) # Collect Tags without unbreak Symbol '\' 
             if [ x"${GvFlag}" != x ]; then
                 # Append object if symbol "+=" exist
                 GvFlag=$(echo "${GvContent}" | grep -E "LOCAL_SHARED_LIBRARIES[ ]*\+=")
                 if [ x"${GvFlag}" != x ]; then
                     GvContent=$(echo "${GvContent}" | sed 's/LOCAL_SHARED_LIBRARIES[ :+]*=//g')
                     GvMachine="${GvMachine} ${GvContent}"
                     GvMachine=$(echo "${GvMachine}" | sed 's/[ ]*\\$/ /g')
                     GvFlag=$(echo "${GvContent}" | sed -n '/\\$/p')
                     if [ x"${GvFlag}" = x ]; then 
                         GvStatus=1
                     else
                         GvStatus=2
                     fi
                     continue
                 fi
                 GvStatus=3
                 #
                 # meet the symbol ":=" to start the new target
                 # Done for collect and push it to table 
                 #
                 GvWhereTable[GvTableCnt]="${GvMachine}"
                 GvContent=""
                 GvFlag=$(echo "${GvMachine}" | grep -E "libcutils")
                 if [ x"${GvFlag}" = x ]; then
                     GvContent="libcutils"
                 fi 
                 GvFlag=$(echo "${GvMachine}" | grep -E "liblog")
                 if [ x"${GvFlag}" = x ]; then
                     GvContent="${GvContent} liblog"
                 fi
                 GvNewTargetTable[GvTableCnt]="${GvContent}"
                 ((GvTableCnt+=1))
                 ((i-=1)) 
                 GvStatus=0
             fi
         ;;
         2) # Collect Tags with unbreak Symbol '\'
             if [ x"${GvFlag}" != x ]; then
                 #Parse Error And halt to handle this file
                 echo -e "\033[0m\033[31m\033[43mParse Error : S=${GvStatus} L=$i @ ${GvFile}\033[0m"
                 ((i=2*GvFileLines))
                 continue
             fi
 
             GvMachine="${GvMachine} ${GvContent}"
             GvMachine=$(echo "${GvMachine}" | sed 's/[ ]*\\$/ /g')

             GvFlag=$(echo "${GvContent}" | sed -n '/\\$/p')
             if [ x"${GvFlag}" = x ]; then 
                 GvStatus=1
                 continue
             fi
         ;;
         *) # unknown error
         ;;
         esac
     }

     if [ $i -ne $((GvFileLines+1)) ]; then
         unset GvWhereTable
         unset GvNewTargetTable
         unset GvTableCnt
         continue
     fi

     #
     # Of course, the latest target mayn't meet the new start symbol, and we will lost to push 
     # the latest target to table.
     # 
     if [ ${GvStatus} -ne 0 -a x"${GvMachine}" != x ]; then
          GvFlag=$(echo "${GvMachine}" | awk -F'::' '{print $1}' | grep -E '[0-9]*')
          if [ x"${GvFlag}" != x ]; then
               GvWhereTable[GvTableCnt]="${GvMachine}"
               GvContent=""
               GvFlag=$(echo "${GvMachine}" | grep -E "libcutils")
               if [ x"${GvFlag}" = x ]; then
                    GvContent="libcutils"
               fi 
               GvFlag=$(echo "${GvMachine}" | grep -E "liblog")
               if [ x"${GvFlag}" = x ]; then
                    GvContent="${GvContent} liblog"
               fi
               GvNewTargetTable[GvTableCnt]="${GvContent}"
               ((GvTableCnt+=1))
               GvStatus=0
          fi
     fi

     GvOffset=0
     for((i=0;i<GvTableCnt;i++)) {
         GvIdx=$(echo "${GvWhereTable[i]}" | awk -F'::' '{print $1}')
         ((GvIdx+=GvOffset))
         echo "==>\"${GvNewTargetTable[i]}\"  should be insert to the below"
         echo "FileLine=$GvIdx @${GvFile}"
         GvContent=$(sed -n "${GvIdx}p" ${GvFile})
         GvContent=$(echo "${GvContent}" | sed 's/\\/\\\\/g')
         GvContent=$(echo "${GvContent}" | sed "s/LOCAL_SHARED_LIBRARIES[ :+]*=/& ${GvNewTargetTable[i]}/g")
         sed -i "${GvIdx}s/^/# JLL.R$(date +%Y%m%d%H%M%S): CurrentLine is replaced by NextLine # &/" ${GvFile}
         sed -i "$((GvIdx+1)) i${GvContent}" ${GvFile}
         ((GvOffset+=1))
     }

     unset GvWhereTable
     unset GvNewTargetTable
     unset GvTableCnt
done



