#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

Lfn_Sys_CheckRoot



function Fn_Usage()
{
cat >&1 << EOF

[DESCRIPTION]
    Help user to learn about more usage of ${CvScriptName}
    Version: v1 - 2016-2-22


[USAGE-DETAILS]

    ${CvScriptName} [help]
        Offer user for that how to use this command.

    ${CvScriptName} -src=IP:Port -dst=IP:Port 
        -src    specify the package go from where included the Source Host IP addres and port
        -dst    specify the package to to where included the Destination Host IP addres and port
     Example:
        ${CvScriptName} -src=172.20.27.3:22000 -dst=192.168.1.11:22 

EOF
}

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


echo
[ $# -ne 2 ] && { Fn_Usage;exit 0; }

for ac_arg; do
    case $ac_arg in
    -src=*)
        echo
        echo "ac_arg: $ac_arg"
        GvSrc=`echo $ac_arg | sed -e "s/-src=//g" -e "s/,/ /g"`
        echo "value: $GvSrc"
        echo
        ;;
    -dst=*)
        echo
        echo "ac_arg: $ac_arg"
        GvDst=`echo $ac_arg | sed -e "s/-dst=//g" -e "s/,/ /g"`
        echo "value: $GvDst"
        echo
        ;;
    help)
        echo "Enter help:"
        Fn_Usage
        exit 0
        ;;
    *)
        echo "Invalid Parameter due to any value"
        Fn_Usage
        exit 0
        ;;
    esac
done

if [ x"${GvSrc}" = x -o x"${GvDst}" = x ]; then
    echo
    echo "Sorry, Dont retrieve Source or Destination,details as follows:"
    echo "  Source:       ${GvSrc}"
    echo "  Destination:  ${GvDst}"
    echo
    Fn_Usage
    exit 0
fi

GvSrcIP=$(echo ${GvSrc} | awk -F ':' '{print $1}')
GvSrcPort=$(echo ${GvSrc} | awk -F ':' '{print $2}')
GvDstIP=$(echo ${GvDst} | awk -F ':' '{print $1}')
GvDstPort=$(echo ${GvDst} | awk -F ':' '{print $2}')
if [ x"${GvSrcIP}" = x -o x"${GvSrcPort}" = x -o x"${GvDstIP}" = x -o x"${GvDstPort}" = x ]; then
    echo
    echo "Sorry, Some errors are occurred as follows:"
    echo "  SrcIP:   ${GvSrcIP}"
    echo "  SrcPort: ${GvSrcPort}"
    echo "  DstIP:   ${GvDstIP}"
    echo "  DstPort: ${GvDstPort}"
    echo
    exit 0 
fi

echo
echo "  SrcIP:   ${GvSrcIP}"
echo "  SrcPort: ${GvSrcPort}"
echo "  DstIP:   ${GvDstIP}"
echo "  DstPort: ${GvDstPort}"
echo 

# Retrieve all active network devices
GvDevList=$(ifconfig | cut -d" " -f 1 | sed '/^$/d')

declare -a GvDevTable
declare -a GvIPv4Table
declare -a GvIPv4MaskTable
declare -i GvTableCnt=0
for GvDev in ${GvDevList}; do
    if [ x"$(ifconfig $GvDev | grep 'inet addr')" = x ]; then
        continue
    fi
    GvDevTable[GvTableCnt]="${GvDev}"
    if [ x"${GvDevTable[GvTableCnt]}" = x ]; then
        continue
    fi
    GvIPv4Table[GvTableCnt]=$(ifconfig "${GvDev}" | grep "inet addr" | cut -d':' -f 2 | awk -F ' ' '{print $1}')
    if [ x"${GvIPv4Table[GvTableCnt]}" = x ]; then
        unset GvDevTable[GvTableCnt]
        continue
    fi
    GvIPv4MaskTable[GvTableCnt]=$(ifconfig "${GvDev}" | grep "Mask" | cut -d':' -f 4)
    if [ x"${GvIPv4MaskTable[GvTableCnt]}" = x ]; then
        unset GvDevTable[GvTableCnt]
        unset GvIPv4Table[GvTableCnt]
        continue
    fi
 
    GvTableCnt=$(( GvTableCnt + 1 ))
done

if [ ${GvTableCnt} -lt 1 ]; then
    echo
    echo "Sorry, Dont exist any valid Network device with IPv4"
    exit 0
fi

GvIPNsrc=$(Fn_aton ${GvSrcIP})
GvIPNdst=$(Fn_aton ${GvDstIP})
GvSrcDev=""
GvDstDev=""
for(( GvIdx=0 ; GvIdx<GvTableCnt; GvIdx++ )) do
    echo
    echo "Dev=${GvDevTable[GvIdx]}"
    echo "IPv4=${GvIPv4Table[GvIdx]}"
    echo "Mask=${GvIPv4MaskTable[GvIdx]}"
    GvIPN=$(Fn_aton ${GvIPv4Table[GvIdx]})
    GvMask=${GvIPv4MaskTable[GvIdx]}
    if [[ ${#GvMask} -le 2 ]]; then
        GvMask=$(Fn_dtom ${GvMask}) 
    else
        GvMask=$(Fn_atom ${GvMask}) 
    fi
    GvNetwork=$((GvIPN & GvMask ))
    GvNetworkSrc=$((GvIPNsrc & GvMask ))
    GvNetworkDst=$((GvIPNdst & GvMask ))
    if [ x"${GvNetworkSrc}" = x"${GvNetworkDst}" ]; then
        unset GvNetworkSrc
        unset GvNetworkDst
        unset GvDevTable
        unset GvIPv4MaskTable
        unset GvSrcDev
        unset GvDstDev
        unset GvIPv4Table
        echo "Sorry, Source Network should not equal to Destination Network"
        exit 0
    fi
    if [ x"${GvSrcDev}" = x ]; then
        GvNetworkSrc=$((GvIPNsrc & GvMask ))
        if [ x"${GvNetwork}" = x"${GvNetworkSrc}" ]; then
            GvSrcDev="${GvDevTable[GvIdx]}"
            echo "Found Input Network Device: ${GvSrcDev} @ Network=$(Fn_ntoa ${GvNetworkSrc})"
            continue
        fi
    fi
    if [ x"${GvDstDev}" = x ]; then
        GvNetworkDst=$((GvIPNdst & GvMask ))
        if [ x"${GvNetwork}" = x"${GvNetworkDst}" ]; then
            GvDstDev="${GvDevTable[GvIdx]}"
            echo "Found Output Network Device: ${GvDstDev} @ Network=$(Fn_ntoa ${GvNetworkDst})"
            continue
        fi
    fi
    if [ x"${GvSrcDev}" != x -a x"${GvDstDev}" != x ]; then
        break;
    fi
done
if [ x"${GvSrcDev}" = x -o x"${GvDstDev}" = x ]; then
    unset GvNetworkSrc
    unset GvNetworkDst
    unset GvDevTable
    unset GvIPv4MaskTable
    unset GvSrcDev
    unset GvDstDev
    unset GvIPv4Table
    echo "Sorry, Dont find Input Network device or Output Network device:"
    echo
    exit 0
fi

exit 0


 iptables -A FORWARD -i eth0 -o tap0 -d 192.168.1.11 -s 172.20.27.3 -j ACCEPT
 iptables -A FORWARD -o eth0 -i tap0 -s 192.168.1.11 -d 172.20.27.3 -j ACCEPT
 iptables -t nat -A PREROUTING -i eth0 -p tcp -s 172.20.27.3 --dport 22000 -j DNAT --to-destination 192.168.1.11:22





