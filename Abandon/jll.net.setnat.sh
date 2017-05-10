#!/bin/bash
# Copyright (c) 2016-2100.   jielong.lin    All rights reserved.
#

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



## Lfn_Cursor_EchoConfig [on|off] 
function Lfn_Cursor_EchoConfig()
{
    if [ -z "$1" ]; then
        exit 0
    fi
    if [ x"$1" = x"off" ]; then
        echo -e "${CvAccOff}\033[?25l${CvAccOff}"
    fi
    if [ x"$1" = x"on" ]; then
        echo -e "${CvAccOff}\033[?25h${CvAccOff}"
    fi
}

function Lfn_Cursor_Move()
{
    if [ -z "$1" -o -z "$2" ]; then
        
        echo "Sorry,Exit due to the invalid usage" 
        exit 0
    fi

    echo $1 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        
        echo "Sorry,Return because the parameter1 isn't digit" 
        return; 
    fi

    echo $2 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        
        echo "Sorry,Return because the parameter2 isn't digit" 
        return; 
    fi

    #'\c' or '-n' - dont break line
    LvCmTargetLocation="${CvAccOff}\033[$2;$1H${CvAccOff}"
    echo -ne "${LvCmTargetLocation}"
}


function Lfn_Stdin_Read()
{
    if [ -z "$1" ]; then
        echo "Sorry, Exit due to the bad usage"
        
        exit 0
    fi

    LvSrData=""

    # Read one byte from stdin
    trap : 2   # enable to capture the signal from keyboard input ctrl_c
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
                    echo "Dont Recognize KeyCode: ${LvSrData}"
                    continue;
                ;;
                esac 
            ;;
            "")
                LvSrData="KeyEsc"
            ;;
            *)
                echo "Dont Recognize KeyCode: ${LvSrData}"
                continue;
            ;;
            esac
        ;;
        "")
            # Space Key and Enter Key arent recognized
            LvSrData="KeySpaceOrEnter"
            break;
        ;;
        *)
            break;
        ;;
        esac
        [ ! -z "${LvSrData}" ] && break;
    done
    trap "" 2  # disable to capture the singal from keyboard input ctrl_c
    eval $1="${LvSrData}"
}


##
##    declare -a GvMenuUtilsContent=(
##        "userdebug: It will enable the most debugging features for tracing the platform."
##        "user:      It is offically release, and it only disable debugging features."
##    )
##    Lfn_MenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Product Type (q: quit) *****"
##    if [ x"${LvpcResult}" = x"${GvMenuUtilsContent[0]}" ]; then
##        LvpcOptionBuild=userdebug
##        echo "hit"
##    fi
##
function Lfn_MenuUtils()
{
    if [ $# -gt 5 ]; then
        exit 0
    fi

    # Check if parameter is digit and Converse it to a valid parameter 
    echo "$3" | grep -E '[^0-9]' >/dev/null && LvVisuX="0" || LvVisuX="$3";
    if [ x"${LvVisuX}" = x"0" ]; then
        LvVisuX=1
    fi
    echo "$4" | grep -E '[^0-9]' >/dev/null && LvVisuY="0" || LvVisuY="$4";
    if [ x"${LvVisuY}" = x"0" ]; then
        LvVisuY=1
    fi

    # Check if parameter is a valid 
    if [ x"$2" != x"Input" -a x"$2" != x"Select" ]; then
        exit 0
    fi 

    #LvVisuCount=$[${#GvMenuUtilsContent[@]} / 2]
    LvVisuCount=$(( ${#GvMenuUtilsContent[@]} / 1 ))
    if [ x"$2" = x"Select" -a ${LvVisuCount} -lt 1 ]; then
        # Select Mode but none item to be selected
        echo "Sorry, Cant Run Select Mode Because of None items to be selected."
        return
    fi

    # Select for configuration guide
    LvVisuFocus=99999 #None Focus
    LvVisuNextFocus=0

    while [ 1 ]; do
        ##
        ## Render UI
        ##
        if [ x"$2" = x"Select" ]; then # Input Mode
            Lfn_Cursor_EchoConfig "off"
        fi
        clear
        LvRenderLine=${LvVisuY}
        if [ x"$5" != x ]; then # exist title
            Lfn_Cursor_Move ${LvVisuX} ${LvRenderLine} 
            echo "$5"
            LvRenderLine=$(( LvRenderLine + 1 ))
        fi
        if [ ${LvVisuCount} -gt 0 ]; then
            for (( LvVisuIdx=0 ; LvVisuIdx<LvVisuCount ; LvVisuIdx++ )) do
                if [ x"$2" = x"Select" ]; then
                    Lfn_Cursor_Move ${LvVisuX} ${LvRenderLine} 
                    if [ ${LvVisuFocus} -eq ${LvVisuIdx} ]; then
                        if [ ${LvVisuFocus} -ne ${LvVisuNextFocus} ]; then
                            # Cancel the focus item reversed style
                            echo -ne "├── ${GvMenuUtilsContent[LvVisuIdx]}"
                            LvVisuFocus=99999 # lose the focus
                        else
                            # When Focus is the same to Next Focus, such as only exist one item
                            # Echo By Reversing its color 
                            echo -ne "├── ${CvAccOff}\033[07m${GvMenuUtilsContent[LvVisuIdx]}${CvAccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        fi
                    else
                        if [ ${LvVisuNextFocus} -eq ${LvVisuIdx} ]; then
                            # Echo By Reversing its color 
                            echo -ne "├── ${CvAccOff}\033[07m${GvMenuUtilsContent[LvVisuIdx]}${CvAccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        else
                            echo -ne "├── ${GvMenuUtilsContent[LvVisuIdx]}"
                        fi
                    fi
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
                if [ x"$2" = x"Input" ]; then
                    Lfn_Cursor_Move ${LvVisuX} ${LvRenderLine}
                    echo -ne "├── ${GvMenuUtilsContent[LvVisuIdx]}"
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
            done
            ##
            ## Drive UI
            ##

            if [ x"$2" = x"Select" ]; then
                Lfn_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 4 ))"
                # echo "Focus:${LvVisuFocus} NextFocus:${LvVisuNextFocus} Count:${LvVisuCount}"
                echo "Focus:${LvVisuFocus} Count:${LvVisuCount}"
                Lfn_Stdin_Read LvCustuiData
                case "${LvCustuiData}" in
                "KeyUp"|"k")
                    if [ ${LvVisuNextFocus} -eq 0 ]; then
                        LvVisuNextFocus=${LvVisuCount}
                    fi
                    LvVisuNextFocus=$(expr ${LvVisuNextFocus} - 1)
                ;;
                "KeyDown"|"j")
                    LvVisuNextFocus=$(expr ${LvVisuNextFocus} + 1)
                    if [ ${LvVisuNextFocus} -eq ${LvVisuCount} ]; then
                        LvVisuNextFocus=0
                    fi
                    ;;
                "KeySpaceOrEnter")
                    echo ""
                    LvVisuFocus=${LvVisuNextFocus}
                    Lfn_Cursor_EchoConfig "on"
                    break
                    ;;
                "q")
                    LvVisuFocus=99999
                    echo ""
                    echo "Exit: Quit due to your choice: q"
                    echo ""
                    Lfn_Cursor_EchoConfig "on"
                    exit 0
                    ;;
                *)
                    ;;
                esac
                Lfn_Cursor_EchoConfig "on"
            fi
            if [ x"$2" = x"Input" ]; then
                Lfn_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                echo "[Please Input A String (Dont repeat name with the above)]"
                Lfn_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
                read LvVisuData
                if [ -z "${LvVisuData}" ]; then
                    echo ""
                    continue
                fi
                if [ x"${LvVisuData}" = x"q" ]; then
                    echo ""
                    echo "Exit: due to your choice: q"
                    echo ""
                    exit 0 
                fi
                LvVisuIsLoop=0
                if [ ${LvVisuCount} -gt 0 ]; then
                    for (( LvVisuIdx=0 ; LvVisuIdx<LvVisuCount ; LvVisuIdx++ )) do
                        if [ x"${GvMenuUtilsContent[LvVisuIdx]}" = x"${LvVisuData}" ]; then
                            LvVisuIsLoop=1
                            echo "Sorry, Dont repeat to name the above Items:\"${LvVisuData}\""
                            echo ""
                            break
                        fi
                    done
                fi
                if [ x"${LvVisuIsLoop}" = x"0" -a x"${LvVisuData}" != x ]; then
                    eval $1=$(echo -e "${LvVisuData}" | sed "s:\ :\\\\ :g")
                    unset LvVisuData
                    unset LvVisuIdx
                    unset LvVisuIsLoop
                    break
                fi
            fi
        else
            if [ x"$2" = x"Select" ]; then
                eval $1=""
                return
            fi
            if [ x"$2" = x"Input" ]; then
                Lfn_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                echo "[Please Input A String (Dont repeat name with the above)]"
                Lfn_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
                read LvVisuData
                echo ""
                if [ x"${LvVisuData}" != x ]; then
                    eval $1="${LvVisuData}"
                    break 
                fi
                if [ x"${LvVisuData}" = x"q" ]; then
                    echo "Exit: due to your choice: q"
                    echo ""
                    break 
                fi
            fi 
        fi
    done

    if [ x"$2" = x"Select" ]; then
        if [ ${LvVisuFocus} -ge 0 -a ${LvVisuFocus} -lt ${LvVisuCount} ]; then
            echo ""
            eval $1=$(echo -e "${GvMenuUtilsContent[LvVisuFocus]}" | sed "s:\ :\\\\ :g")
        fi
    fi
 
    unset LvVisuNextFocus
    unset LvVisuFocus
    unset LvVisuCount
}



# Converts Network Address Integer (IPv4) TO Ascii String in Internet Standard dotted format
# Note: Network Address Integer is the 32bit Integer, it is calculated by 256 as a unit handle.
#       For example, 255.255.0.0 --->  255 + 255*256 + 0*256*256 + 0*256*256*256
#
#    Fn_ntoa 123456789 ---> return 7.91.205.21
#
function Fn_ntoa()
{
    awk '{c=256;print int($0/c^3)"."int($0%c^3/c^2)"."int($0%c^3%c^2/c)"."$0%c^3%c^2%c}' <<<$1
}



# Converts Ascii String in Internet Standard dotted format TO Network Address Integer (IPv4)
#    Fn_aton 7.91.205.21 ---> return 123456789
#
function Fn_aton()
{
    # JLL:  ip4+ip3*256+ip2*256*256+ip1*256*256*256
    awk '{c=256;split($0,ip,".");print ip[4]+ip[3]*c+ip[2]*c^2+ip[1]*c^3}' <<<$1
}


# Convert Digital Mask Ascii String to Mask Address Integer
#     Fn_dtom 24
# Note: the result is similar to Network Address Integer, so it can be converted back to
#       Internet Standard dotted format, as follows:
#         ttt=$(Fn_dtom 24)
#         Fn_ntoa $ttt  ---> return 255.255.255.0
#
function Fn_dtom()
{
    local i=$((~0))
    ((i<<=(32-$1)))
    # 4294967296 equals to ~(0)
    ((i += 4294967296))
    echo $i
}


# Convert Ascii String in Internet Standard dotted format TO Mask Address Integer
#     ttt=$(Fn_atom 255.255.0.0)
#     Fn_ntoa $ttt ---> 255.255.0.0
#
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


# 255.255.255.0 --> 24
# OK return less than 32
#
# echo $(Fn_atod 255.255.0.0)
# ---> Return 16
function Fn_atod()
{
    local mask=$(Fn_atom $1)
    ((mask=4294967296-mask))
    i=0
    for((i=0;i<32;i++)); do
        ((mask>>=1))
        if [ $mask -le 0 ]; then
            break
        fi
    done
    ((i=32-i))
    echo $i
}


# Fn_IpFormat_Check ip.ip.ip.ip
# Error return NULL, or return non-null
function Fn_IpFormat_Check()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}


# Fn_ConvertNetworkAddressFromIPv4AndMask  IP.IP.IP.IP Mask.Mask.Mask.Mask
#
#     Fn_ConvertNetworkAddressFromIPv4AndMask 192.168.201.1 255.255.255.0
#     ---> Return 192.168.201.0
function Fn_ConvertNetworkAddressFromIPv4AndMask()
{
    if [ x"$1" = x -o x"$2" = x ]; then
        echo "Usage:"
        echo "  Fn_ConvertNetworkAddressFromIPv4AndMask  IP.IP.IP.IP Mask.Mask.Mask.Mask"
        echo
        exit 0
    fi

    if Fn_IpFormat_Check $1; then
        if Fn_IpFormat_Check $2; then
            IPa=$(echo $1 | cut -d '.' -f1)
            IPb=$(echo $1 | cut -d '.' -f2)
            IPc=$(echo $1 | cut -d '.' -f3)
            IPd=$(echo $1 | cut -d '.' -f4)
            Ma=$(echo $2 | cut -d '.' -f1)
            Mb=$(echo $2 | cut -d '.' -f2)
            Mc=$(echo $2 | cut -d '.' -f3)
            Md=$(echo $2 | cut -d '.' -f4)
        else
            echo "Bad IP format for $1"
            exit 0
        fi
    else
        echo "Bad IP format for $1"
        exit 0
    fi

    ((IPa = IPa & Ma))
    ((IPb = IPb & Mb))
    ((IPc = IPc & Mc))
    ((IPd = IPd & Md))

    echo "${IPa}.${IPb}.${IPc}.${IPd}"
}


clear
cat >&1 << EOF
## Step1.
## probe all active network devices
##
##
## Execute if press any
EOF
read

GvIPv4=""
GvMask=""
GvNetIf=""

declare -a GvMenuUtilsContent
declare -i GvMenuUtilsCtxNr=0

GvDevList=$(ifconfig | cut -d" " -f 1 | sed '/^$/d' | grep -v "tap")

for GvDev in ${GvDevList}; do
    GvIPv4=$(ifconfig "${GvDev}" | grep "inet addr" | cut -d':' -f 2 | awk -F ' ' '{print $1}')
    GvMask=$(ifconfig "${GvDev}" | grep "Mask:" | awk -F 'Mask:' '{print $2}')
    if [ x"${GvIPv4}" = x -o x"${GvMask}" = x ]; then
        continue
    fi
    GvMenuUtilsContent[GvMenuUtilsCtxNr]="${GvDev}=${GvIPv4}__${GvMask}"
    GvMenuUtilsCtxNr=$((GvMenuUtilsCtxNr+1))
done
unset GvDevList
unset GvDev

if [ ${GvMenuUtilsCtxNr} -lt 1 ]; then
    echo "Sorry to exit - Dont exist any active network devices as follows:"
    ifconfig
    echo ""
    exit 0
fi


cat >&1 << EOF
## Step2.
## Configurate the network environment
#####
## ===========#=============================
##            #
##  Virtual   #   +------+
##  Machine   #   | QEMU |
##  Layer     #   +-|----+
##            #     |
## ===========#=====|=======================
##            #     |
##  TCP/IP    #   +-|----+
##  Protocol  #   | TAP -|-------+
##  Stack     #   +-|----+       |
##            #     |            |
##            #   +--------------+
## ===========#===|     iptables |==========
##            #   +--------------+
##            #     |            |
##  Network   #   +-|-------+  +-|--------+
##  Device    #   | eth...? |  | wlan...? |
##  Interface #   +---------+  +----------+
##            #
## ===========#=============================
##
## Execute if press any
EOF
read

GvIPv4=""
GvMask=""
GvNetIf=""

echo ""
echo "Please Select a network device as mainly network interface in host OS"
Lfn_MenuUtils GvResult  "Select" 7 4 "***** Active Network Device Table (q: quit) *****"
for(( GvIdx=0; GvIdx < GvMenuUtilsCtxNr; GvIdx++ )) {
  if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvIdx]}" ]; then
    GvIPv4=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $2}' | awk -F '__' '{print $1}')
    GvMask=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $2}' | awk -F '__' '{print $2}')
    GvNetIf=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $1}')
    break
  fi
}
unset GvMenuUtilsCtxNr
unset GvMenuUtilsContent

if [ x"${GvNetIf}" = x -o x"${GvIPv4}" = x -o x"${GvMask}" = x ]; then
    echo "Sorry to exit, Invaid Network interface @PrimaryNetwork"
    exit 0
fi



clear
cat >&1 <<EOF
#####
## ===========#=============================
##            #
##  Virtual   #   +------+
##  Machine   #   | QEMU |
##  Layer     #   +-|----+
##            #     |
## ===========#=====|=======================
##            #     |
##  TCP/IP    #   +-|-------+
##  Protocol  #   | TAP...? +
##  Stack     #   +-|-------+
##            #     |
##            #   +--------------+
## ===========#===|     iptables |==========
##            #   +--------------+
##            #     |
##  Network   #     |
##  Device    #   ${GvNetIf}=${GvIPv4}/${GvMask}
##  Interface #
##            #
## ===========#=============================
##
## Execute if press any
EOF
read


while [ 1 -eq 1 ]; do

    #
    # Probe all tap devices
    #
    declare -a GvMenuUtilsContent
    declare -i GvMenuUtilsCtxNr=0

    GvDevList=$(ifconfig | cut -d" " -f 1 | sed '/^$/d' | grep -i "tap")

    GvTapIPv4=""
    GvTapMask=""
    GvTapNetIf=""
    for GvTapNetIf in ${GvDevList}; do
        GvTapIPv4=$(ifconfig "${GvTapNetIf}" | grep "inet addr" | cut -d':' -f 2 | awk -F ' ' '{print $1}')
        GvTapMask=$(ifconfig "${GvTapNetIf}" | grep "Mask:" | awk -F 'Mask:' '{print $2}')
        if [ x"${GvTapIPv4}" = x -o x"${GvTapMask}" = x ]; then
            continue
        fi
        GvMenuUtilsContent[GvMenuUtilsCtxNr]="${GvTapNetIf}=${GvTapIPv4}__${GvTapMask}"
        GvMenuUtilsCtxNr=$((GvMenuUtilsCtxNr+1))
    done
    unset GvDevList
    GvTapIPv4=""
    GvTapMask=""
    GvTapNetIf=""


    GvNewTapIdx=$((GvMenuUtilsCtxNr+1))
    GvNewTapIP="192.168.20${GvNewTapIdx}.1"
    GvMenuUtilsContent[GvMenuUtilsCtxNr]="CreateTAP@${GvNewTapIP}"
    ((GvMenuUtilsCtxNr += 1))

    Lfn_MenuUtils GvResult  "Select" 7 4 "***** Active TAP Network Device Table (q: quit) *****"
    if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvMenuUtilsCtxNr-1]}" ]; then
        unset GvMenuUtilsCtxNr
        unset GvMenuUtilsContent
        echo "Trying to create the network device:  /dev/tap${GvNewTapIdx} - ${GvNewTapIP}/24 "
        GvSwStatus="$(dpkg --get-selections | grep uml-utilities)"
        if [ x"${GvSwStatus}" = x ]; then
            aptitude install uml-utilities
            GvSwStatus="$(dpkg --get-selections | grep uml-utilities)"
            if [ x"${GvSwStatus}" = x ]; then
                echo "JLL: Exit - Donot install uml-utilities for control tap"
                unset GvResult
                unset GvSwStatus
                unset GvNewTapIdx
                unset GvNewTapIP
                exit 0
            fi
        fi
        tunctl -t tap${GvNewTapIdx} -u $(whoami)
        ifconfig tap${GvNewTapIdx} ${GvNewTapIP} netmask 255.255.255.0 up
        continue
    fi

    for(( GvIdx=0; GvIdx < GvMenuUtilsCtxNr; GvIdx++ )) {
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvIdx]}" ]; then
            GvTapIPv4=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $2}' | awk -F '__' '{print $1}')
            GvTapMask=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $2}' | awk -F '__' '{print $2}')
            GvTapNetIf=$(echo ${GvMenuUtilsContent[GvIdx]} | awk -F '=' '{print $1}')
            break
        fi
    }

    unset GvMenuUtilsCtxNr
    unset GvMenuUtilsContent

    if [ x"${GvTapNetIf}" = x -o x"${GvTapIPv4}" = x -o x"${GvTapMask}" = x ]; then
        echo "Sorry to exit, Invaid Network interface @tap "
        exit 0
    fi
    break
done

clear
cat >&1 <<EOF
#####
## ===========#=============================
##            #
##  Virtual   #   +------+
##  Machine   #   | QEMU |
##  Layer     #   +-|----+
##            #     |
## ===========#=====|=======================
##            #     |
##  TCP/IP    #     |
##  Protocol  #   ${GvTapNetIf}=${GvTapIPv4}/${GvTapMask}
##  Stack     #     |
##            #     |
##            #   +-|------------+
## ===========#===| ??? iptables |==========
##            #   +-|------------+
##            #     |
##  Network   #     |
##  Device    #   ${GvNetIf}=${GvIPv4}/${GvMask}
##  Interface #
##            #
## ===========#=============================
##
## Execute if press any
EOF
read

## jll: All Source Tap IP come from tap network are translated to server mainly IP
GvNetwork=$(Fn_ConvertNetworkAddressFromIPv4AndMask ${GvIPv4} ${GvMask})
GvTapNetwork=$(Fn_ConvertNetworkAddressFromIPv4AndMask ${GvTapIPv4} ${GvTapMask})
GvRulesConf="$(Fn_atod ${GvMask})"
if [ x"${GvRulesConf}" = x -o ${GvRulesConf} -ge 32 ]; then
    echo "Sorry, Exit due to invalid Source Network Mask Address"
    exit 0
fi
GvRulesConf="${GvNetwork}/${GvRulesConf}"
GvTapRulesConf="$(Fn_atod ${GvTapMask})"
if [ x"${GvTapRulesConf}" = x -o ${GvTapRulesConf} -ge 32 ]; then
    echo "Sorry, Exit due to invalid Source Network Mask Address"
    exit 0
fi
GvTapRulesConf="${GvTapNetwork}/${GvTapRulesConf}"
GvPreventReconfig=$(iptables -t nat -nL | grep SNAT | grep -i "to:${GvIPv4}")
if [ x"${GvPreventReconfig}" = x ]; then
    echo 1 > /proc/sys/net/ipv4/ip_forward
    iptables -t nat -I POSTROUTING  -s ${GvTapRulesConf} -j SNAT --to-source ${GvIPv4}
    iptables -A FORWARD -s ${GvTapRulesConf} -j ACCEPT
    iptables -A FORWARD -d ${GvTapRulesConf} -j ACCEPT
    iptables -A FORWARD -s ${GvRulesConf} -j ACCEPT
    iptables -A FORWARD -d ${GvRulesConf} -j ACCEPT
else
    # SNAT       all  --  192.168.201.0/24       0.0.0.0/0            to:172.20.30.29
    GvPreventReconfig=$(echo "${GvPreventReconfig}" | grep "${GvTapRulesConf}")
    if [ x"${GvPreventReconfig}" = x ]; then
        echo 1 > /proc/sys/net/ipv4/ip_forward
        iptables -t nat -I POSTROUTING  -s ${GvTapRulesConf} -j SNAT --to-source ${GvIPv4}
        iptables -A FORWARD -s ${GvTapRulesConf} -j ACCEPT
        iptables -A FORWARD -d ${GvTapRulesConf} -j ACCEPT
        iptables -A FORWARD -s ${GvRulesConf} -j ACCEPT
        iptables -A FORWARD -d ${GvRulesConf} -j ACCEPT
    fi
fi

if [ x"${GvPreventReconfig}" = x ]; then
clear
cat >&1 <<EOF
#####
## ===========#=============================
##            #
##  Virtual   #   +------+
##  Machine   #   | QEMU |
##  Layer     #   +-|----+
##            #     |
## ===========#=====|=======================
##            #     |
##  TCP/IP    #     |
##  Protocol  #   ${GvTapNetIf}=${GvTapIPv4}/${GvTapMask}
##  Stack     #     |
##            #     | ${GvTapRulesConf}
##            # +---|----------------------+
##            # |   |
##            # | iptables -t nat -I POSTROUTING  -s ${GvTapRulesConf} -j SNAT --to-source ${GvIPv4}
## ===========#=| iptables -A FORWARD -s ${GvTapRulesConf} -j ACCEPT
##            # | iptables -A FORWARD -d ${GvTapRulesConf} -j ACCEPT
##            # | iptables -A FORWARD -s ${GvRulesConf} -j ACCEPT
##            # | iptables -A FORWARD -d ${GvRulesConf} -j ACCEPT
##            # |   |
##            # +---|----------------------+
##            #     | ${GvIPv4}
##  Network   #     |
##  Device    #   ${GvNetIf}=${GvIPv4}/${GvMask}
##  Interface #
##            #
## ===========#=============================
##
## Execute if press any
EOF
read
else
    echo "\"iptables -t nat -I POSTROUTING -s ${GvTapRulesConf} -j SNAT --to-source ${GvIPv4}\" has been set in iptables"
fi


echo " iptables -t nat -A PREROUTING -i eth0 -p tcp -s ${GvRulesConf} --dport 22000 -j DNAT --to-destination 192.168.201.2:22"

GvSshTarget="${GvTapIPv4%.*}.10:22"
GvSshSource="${GvRulesConf}"
GvSshPort=${GvTapNetIf#tap}
((GvSshPort+=22000))
GvPreventReconfig=$(iptables -t nat -nL | grep DNAT | grep "dpt:${GvSshPort}" | grep "to:${GvSshTarget}")
if [ x"${GvPreventReconfig}" = x ]; then
    echo "SSH-Session-Map: ${GvSshSource}:${GvSshPort} <-------> ${GvSshTarget}"
    echo "Mapping: iptables -t nat -A PREROUTING -i ${GvNetIf} -p tcp -s ${GvSshSource} --dport ${GvSshPort} -j DNAT --to-destination ${GvSshTarget}"
    iptables -t nat -A PREROUTING -i ${GvNetIf} -p tcp -s ${GvSshSource} --dport ${GvSshPort} -j DNAT --to-destination ${GvSshTarget}
fi

clear
cat >&1 <<EOF
#####
## ===========#=============================
##            #
##  Virtual   #   +------+
##  Machine   #   | QEMU |
##  Layer     #   +-|----+
##            # SSH-Server=${GvSshTarget}
##            #     |
## ===========#=====|=======================
##            #     |
##  TCP/IP    #     |
##  Protocol  #   ${GvTapNetIf}=${GvTapIPv4}/${GvTapMask}
##  Stack     #     |
##            #   +-|--------+
## ===========#===| iptables |==============
##            #   +-|--------+
##  Network   #     |
##  Device    #   ${GvNetIf}=${GvIPv4}/${GvMask}
##  Interface #     |
##            #     |
## ===========#=====|=======================
##                  |
##                  \\ 
##                   \\ 
##                    \\ 
##              SSH-Client=${GvSshSource}:${GvSshPort}
##
## Execute if press any
EOF
read

echo "Please set ip after run GUEST OS - linux:"
echo "user@linux:~# vi /etc/network/interface"
echo "..."
echo "# The primary network interface"
echo "auto eth0"
echo "iface eth0 inet static"
echo "address ${GvSshTarget%:*}"
echo "netmask 255.255.255.0"
echo "gateway ${GvTapIPv4}"
echo "dns-nameservers 211.138.156.66  211.138.151.161"
echo "dns-search www.baid.com"
echo ""
echo ">>>>>>>>>>>>>>>>>>> Thank you <<<<<<<<<<<<<<<<<<<"

exit 0
