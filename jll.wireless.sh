#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

function Fn_Usage()
{
more >&1 <<EOF

[DESCRIPTION]
    Help user to learn about more usage of ${CvScriptName}
    Version: v1 - 2016-2-2 

Usecase0: WPA + Passwork AP
    wpa_passphrase Xiaomi_31A6 icfw602b > wifi_login.conf
    wpa_supplicant -B -iwlan0 -Dwext -cwifi_login.conf
    iwconfig wlan0
    dhclient wlan0
    ping www.baidu.com 


Usacase1: WEP + Passwork AP
    iwconfig wlan0 key s:password
    iwconfig wlan0 key open
    iwconfig wlan0 essid ssidname
    ifconfig wlan0 up
    dhclient wlan0

Usacase2: without passwork AP
   iwconfig wlan0 essid ssidname
   ifconfig wlan0 up
   dhclient wlan0 

[USAGE-DETAILS] 

    ${CvScriptName} [help]
        Offer user for that how to use this command.

    ${CvScriptName}  -q
        List Wireless Name By ESSID

    ${CvScriptName}  -x 
        wpa_supplicant -i${GvNetIf} -D${GvDriver} -c/etc/.../wpa_supplicant.conf
 
EOF

}


if [ $# -lt 1 -o x"$1" = x"help" ]; then
    Fn_Usage
    exit 0
fi


function Fn_ntoa()
{
    awk '{c=256;print int($0/c^3)"."int($0%c^3/c^2)"."int($0%c^3%c^2/c)"."$0%c^3%c^2%c}' <<<$1
}

function Fn_aton()
{
    awk '{c=256;split($0,ip,".");print ip[4]+ip[3]*c+ip[2]*c^2+ip[1]*c^3}' <<<$1
}

function Fn_dtom()
{
    local i=$((~0))
    ((i<<=(32-$1)))
    echo $i
}

function Fn_atom()
{
    local mask=$(Fn_aton $1)
    local i=0 
    local n=0 
    for((i=31;i>=0;i--)); do
        if [[ $((mask&(1<<$i))) -gt 0 ]]; then
            ((n++))
        fi
    done
    echo $(Fn_dtom $n)
}


#
# probe all active network devices
#
GvIPv4=""
GvNetIf=""

declare -a GvMenuUtilsContent
declare -i GvMenuUtilsCtxNr=0

GvDevList=$(ifconfig | cut -d" " -f 1 | sed '/^$/d')

for GvDev in ${GvDevList}; do
    GvIPv4=$(ifconfig "${GvDev}" | grep "inet addr" | cut -d':' -f 2 | awk -F ' ' '{print $1}')
    if [ x"${GvIPv4}" = x ]; then
        continue
    fi
    GvMenuUtilsContent[GvMenuUtilsCtxNr]="${GvDev}=${GvIPv4}"
    GvMenuUtilsCtxNr=$((GvMenuUtilsCtxNr+1))
done
unset GvDevList
unset GvDev

if [ ${GvMenuUtilsCtxNr} -lt 1 ]; then
    echo "Sorry to exit - Dont exist any active network devices as follows:"
    ifconfig
    echo ""
    unset GvIPv4
    unset GvNetIf
    unset GvMenuUtilsContent
    unset GvMenuUtilsCtxNr
    exit 0
fi

GvIPv4=""
GvNetIf=""

echo ""
Lfn_MenuUtils GvResult  "Select" 7 4 "***** Select Wireless Network Device (q: quit) *****"
for(( GvIdx=0; GvIdx < GvMenuUtilsCtxNr; GvIdx++ )) {
    if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvIdx]}" ]; then
        GvIPv4=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $2}')
        GvNetIf=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $1}')
        break
    fi
}
unset GvMenuUtilsContent
unset GvMenuUtilsCtxNr

if [ x"${GvNetIf}" = x -o x"${GvIPv4}" = x ]; then
    echo "Sorry to exit, Invaid Network interface"
    unset GvIPv4
    unset GvNetIf
    exit 0
fi


#
# List all ESSID from Wireless Network Device
#
declare -a GvESSIDTable
declare -a GvESSIDTableNr=0
GvTempESSIDs=$(iwlist wlan0 scanning | grep -i ESSID | cut -d":" -f 2 | sed '/^$/d')
for GvESSIDItem in ${GvTempESSIDs}; do
    GvESSIDItem=$(echo  "${GvESSIDItem}" | sed "s/\"//g") 
    if [ x"${GvESSIDItem}" = x ]; then
        continue
    fi
    GvESSIDTable[GvESSIDTableNr]="${GvESSIDItem}"
    GvESSIDTableNr=$((GvESSIDTableNr+1))
done
unset GvTempESSIDs
unset GvESSIDItem


#
# Specify the Network Driver 
#
GvStartNumber=$(wpa_supplicant -h | grep -nw "^drivers:" | awk -F ':' '{print $1}')
GvStartNumber=$((GvStartNumber+1))
GvEndNumber=$(wpa_supplicant -h | grep -nw "^options:" | awk -F ':' '{print $1}')
GvEndNumber=$((GvEndNumber-1))

if [ x"${GvStartNumber}" = x -o x"${GvEndNumber}" = x -o ${GvStartNumber} -ge ${GvEndNumber} ]; then
    unset GvStartNumber
    unset GvEndNumber

    unset GvESSIDTableNr
    unset GvESSIDTable
    unset GvIPv4
    unset GvNetIf
 
    exit 0
fi

GvDriver=""

declare -a GvMenuUtilsContent
declare -i GvMenuUtilsCtxNr=0

for((GvIdx=GvStartNumber; GvIdx<=GvEndNumber; GvIdx++ )); do
    GvTempItem=$(wpa_supplicant -h | sed -n "${GvIdx}p" | awk -F'=' '{print $1}')
    GvMenuUtilsContent[GvMenuUtilsCtxNr]=$(echo "${GvTempItem}" | sed 's/ //g')
    echo "${GvMenuUtilsContent[GvMenuUtilsCtxNr]}"
    GvMenuUtilsCtxNr=$((GvMenuUtilsCtxNr+1))
done
unset GvStartNumber
unset GvEndNumber
if [ ${GvMenuUtilsCtxNr} -lt 1 ]; then
    echo "Sorry to exit - Dont exist any active network driver as follows:"
    echo ""
    unset GvESSIDTableNr
    unset GvESSIDTable
    unset GvIPv4
    unset GvNetIf
    unset GvDriver 
    unset GvMenuUtilsContent
    unset GvMenuUtilsCtxNr
    exit 0
fi
echo ""
Lfn_MenuUtils GvResult  "Select" 7 4 "***** Select Wireless Network Driver (q: quit) *****"
for(( GvIdx=0; GvIdx<GvMenuUtilsCtxNr; GvIdx++ )); do
    if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvIdx]}" ]; then
        GvDriver=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $1}')
        break
    fi
done
unset GvIdx
unset GvMenuUtilsContent
unset GvMenuUtilsCtxNr

if [ x"${GvDriver}" = x ]; then
    echo "Sorry to exit, Invaid Network Driver"
    unset GvESSIDTableNr
    unset GvESSIDTable
    unset GvIPv4
    unset GvNetIf
    unset GvDriver 
    unset GvMenuUtilsContent
    unset GvMenuUtilsCtxNr
    exit 0
fi

function Fn_ListWirelessNameByESSID( )
{
    echo
    echo "    === Wireless Network Names ==="
    for(( LvIdx=0; LvIdx<GvESSIDTableNr; LvIdx++ )); do
        echo "    ($LvIdx)   \"${GvESSIDTable[${LvIdx}]}\""
    done
    echo
}



function Fn_GetDriverListFromWPA()
{
    LvStartNumber=$(wpa_supplicant -h | grep -nw "^drivers:" | awk -F ':' '{print $1}')
    LvStartNumber=$((LvStartNumber+1))
    LvEndNumber=$(wpa_supplicant -h | grep -nw "^options:" | awk -F ':' '{print $1}')
    LvEndNumber=$((LvEndNumber-1))

    if [ x"${LvStartNumber}" = x -o x"${LvEndNumber}" = x -o ${LvStartNumber} -ge ${LvEndNumber} ]; then
        unset LvStartNumber
        unset LvEndNumber
        return
    fi

    wpa_supplicant -h | sed -n "${LvStartNumber},${LvEndNumber}p"
}


for ac_arg; do
    case $ac_arg in
        -q)
            Fn_ListWirelessNameByESSID
            exit 0
        ;;
        -x)
            echo "wpa_supplicant -i${GvNetIf} -D${GvDriver} -c/etc/.../wpa_supplicant.conf"
            exit 0
        ;;
        --hello=*)
            echo "ac_arg: $ac_arg"
            GvHello=`echo $ac_arg | sed -e "s/--hello=//g" -e "s/,/ /g"`
            echo "value: $GvHello"
            exit 0
        ;;
        *)
            Fn_Usage
            exit 0
        ;;
    esac
done


