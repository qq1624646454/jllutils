#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLFULLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLFULLPATH})"
JLLFILE="$(basename ${JLLFULLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

#sudo python -m SimpleHTTPServer 80

echo
if [ x"`whoami`" != x"root" ]; then
    echo "Sorry, Current User isn't root"
    echo
    exit 0
fi
echo
echo  "===== Checking @ Process Name & ID "
GvPSList=$(ps aux | grep -i "SimpleHttpServer" | grep -v 'grep')
OIFS=${IFS}
IFS=$'\n'
declare -a GvArrayPID
declare -a GvArrayName
declare -i GvIdx=0
for GvPSItem in ${GvPSList}; do
    GvArrayPID[GvIdx]=$(echo "${GvPSItem}" | awk -F' ' '{print $2}')
    GvArrayName[GvIdx]=$(echo "${GvPSItem}" | sed 's/$/+/g' | awk -F' ' '{for(i=1;i<=10;i++) $i="";print}' | sed 's/^          //g')
    echo "${GvIdx}: PID=${GvArrayPID[GvIdx]} PName=${GvArrayName[GvIdx]}"
    GvIdx=$((GvIdx+1))
done
IFS=${OIFS}
echo "Total_Of_Items=${GvIdx}"
if [ ${GvIdx} -gt 0 ]; then
    echo
    echo
    echo  "===== Sorting By Descending Order "
    echo
    # Sort
    for((j=0; j<GvIdx; j++)) {
        for((i=j+1; i<GvIdx; i++)) {
            echo "$j:: ${GvArrayPID[j]} < ${GvArrayPID[i]}"
            if [ ${GvArrayPID[j]} -lt ${GvArrayPID[i]} ]; then
                tempP=${GvArrayPID[i]};
                tempN=${GvArrayName[i]};
                GvArrayPID[i]=${GvArrayPID[j]}
                GvArrayName[i]=${GvArrayName[j]}
                GvArrayPID[j]=${tempP}
                GvArrayName[j]=${tempN}
                #echo "SwitchDataResult: $j:(${GvArrayName[j]})--->$i:(${GvArrayName[i]})"
                #echo "SwitchDataResult: $j:(${GvArrayPID[j]})-->$i:(${GvArrayPID[i]})"
            fi
        }
        echo "->$j:: PID=${GvArrayPID[j]} PName=${GvArrayName[j]}"
        echo
    }
    echo
    echo
    echo  "===== Process ID and Name Table By Descending Order"
    for((k=0; k<GvIdx; k++)) {
        echo "$k:: PID=${GvArrayPID[k]} PName=${GvArrayName[k]}"
    }
    echo
    echo
    echo
    echo  "===== Killing the unused Processes"
    for((k=1; k<GvIdx; k++)) {
        if [ x"$$" = x"${GvArrayPID[k]}" ]; then 
            echo "Skipping | PID=${GvArrayPID[k]} Due to Itself PName=${GvArrayName[k]}"
        else
            echo "Killed   | PID=${GvArrayPID[k]} PName=${GvArrayName[k]}"
            kill -9 ${GvArrayPID[k]}
        fi
    }

    unset GvArrayPID
    unset GvArrayName
fi
echo
echo
echo  "===== Simple Http Server Is Running..."
echo
python -m SimpleHTTPServer 8080


