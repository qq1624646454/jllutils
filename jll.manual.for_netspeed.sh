#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.for_netspeed.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-03 09:34:27
#   ModifiedTime: 2019-01-06 18:22:31

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

#!/bin/bash

totalTime=10

id=0
while true; do
    echo "JLLim: $id trying to obtain the bytes from rx and tx"
    R1=`cat /sys/class/net/$1/statistics/rx_bytes`
    T1=`cat /sys/class/net/$1/statistics/tx_bytes`
    sleep 1
    R2=`cat /sys/class/net/$1/statistics/rx_bytes`
    T2=`cat /sys/class/net/$1/statistics/tx_bytes`
    echo "JLLim: $id calculating the bytes count during 1s"
    T_byte_per_second=`expr $T2 - $T1`
    R_byte_per_second=`expr $R2 - $R2`

    Is_Human_T_bps=0
    if [ x"${T_byte_per_second}" != x ]; then
        if [ ${T_byte_per_second} -ge 1024 ]; then
            Is_Human_T_bps=1
        fi
    fi

    Is_Human_R_bps=0
    if [ x"${R_byte_per_second}" != x ]; then
        if [ ${R_byte_per_second} -ge 1024 ]; then
            Is_Human_R_bps=1
        fi
    fi

    if [ x${IS_Human_T_bps} = x1 ]; then
        echo -e "JLLim: $id reporting Transmit: $((T_byte_per_second/1024)) KB/s"
    else
        echo -e "JLLim: $id reporting Transmit: ${T_byte_per_second} B/s"
    fi

    id=`expr $id + 1`

    if [ $id -ge $totalTime ]; then
        break
    fi
done



