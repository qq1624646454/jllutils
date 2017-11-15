#!/bin/bash
#Copyright(c) 2016-2100, jielong_lin,  All rights reserved.
#

#------------- Start Of UI Library ---------------

# 黑:Black
# 红:Red
# 绿:Green
# 黄:Yellow
# 蓝:Blue
# 粉红:Pink
# 海蓝:SeaBlue
# 白:White

___AccOff="\033[0m"

___FgBlack="\033[30m"
___FgRed="\033[31m"
___FgGreen="\033[32m"
___FgYellow="\033[33m"
___FgBlue="\033[34m"
___FgPink="\033[35m"
___FgSeaBule="\033[36m"
___FgWhite="\033[37m"

___BgBlack="\033[40m"
___BgRed="\033[41m"
___BgGreen="\033[42m"
___BgYellow="\033[43m"
___BgBlue="\033[44m"
___BgPink="\033[45m"
___BgSeaBule="\033[46m"
___BgWhite="\033[47m"



## _F_Cursor_EchoConfig [on|off] 
function _F_Cursor_EchoConfig()
{
    if [ -z "$1" ]; then
        exit 0
    fi
    if [ x"$1" = x"off" ]; then
        echo -e "${___AccOff}\033[?25l${___AccOff}"
    fi
    if [ x"$1" = x"on" ]; then
        echo -e "${___AccOff}\033[?25h${___AccOff}"
    fi
}

function _F_Cursor_Move()
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
    LvCmTargetLocation="${___AccOff}\033[$2;$1H${___AccOff}"
    echo -ne "${LvCmTargetLocation}"
}


function _F_Stdin_Read()
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
##    _F_MenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Product Type (q: quit) *****"
##    if [ x"${LvpcResult}" = x"${GvMenuUtilsContent[0]}" ]; then
##        LvpcOptionBuild=userdebug
##        echo "hit"
##    fi
##
function _F_MenuUtils()
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
            _F_Cursor_EchoConfig "off"
        fi
        clear
        LvRenderLine=${LvVisuY}
        if [ x"$5" != x ]; then # exist title
            _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
            echo "$5"
            LvRenderLine=$(( LvRenderLine + 1 ))
        fi
        if [ ${LvVisuCount} -gt 0 ]; then
            for (( LvVisuIdx=0 ; LvVisuIdx<LvVisuCount ; LvVisuIdx++ )) do
                if [ x"$2" = x"Select" ]; then
                    _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
                    if [ ${LvVisuFocus} -eq ${LvVisuIdx} ]; then
                        if [ ${LvVisuFocus} -ne ${LvVisuNextFocus} ]; then
                            # Cancel the focus item reversed style
                            echo -ne " |--- ${GvMenuUtilsContent[LvVisuIdx]}"
                            LvVisuFocus=99999 # lose the focus
                        else
                            # When Focus is the same to Next Focus, such as only exist one item
                            # Echo By Reversing its color
                            echo -ne " |--- ${___AccOff}\033[07m${GvMenuUtilsContent[LvVisuIdx]}${___AccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        fi
                    else
                        if [ ${LvVisuNextFocus} -eq ${LvVisuIdx} ]; then
                            # Echo By Reversing its color
                            echo -ne " |--- ${___AccOff}\033[07m${GvMenuUtilsContent[LvVisuIdx]}${___AccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        else
                            echo -ne " |--- ${GvMenuUtilsContent[LvVisuIdx]}"
                        fi
                    fi
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
                if [ x"$2" = x"Input" ]; then
                    _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
                    echo -ne " |--- ${GvMenuUtilsContent[LvVisuIdx]}"
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
            done
            ##
            ## Drive UI
            ##

            if [ x"$2" = x"Select" ]; then
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 4 ))"
                # echo "Focus:${LvVisuFocus} NextFocus:${LvVisuNextFocus} Count:${LvVisuCount}"
                echo "Focus:${LvVisuFocus} Count:${LvVisuCount}"
                _F_Stdin_Read LvCustuiData
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
                    _F_Cursor_EchoConfig "on"
                    break
                    ;;
                "q")
                    LvVisuFocus=99999
                    echo ""
                    echo "Exit: Quit due to your choice: q"
                    echo ""
                    _F_Cursor_EchoConfig "on"
                    exit 0
                    ;;
                *)
                    ;;
                esac
                _F_Cursor_EchoConfig "on"
            fi
            if [ x"$2" = x"Input" ]; then
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                echo "[Please Input A String (Dont repeat name with the above)]"
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
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
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                echo "[Please Input A String (Dont repeat name with the above)]"
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
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


##
##  declare -i ___PU=10
##  declare -a ___PMUC=(
##        "userdebug: It will enable the most debugging features for tracing the platform."
##        "user1:      It is offically release, and it only disable debugging features."
##        "user2:      It is offically release, and it only disable debugging features."
##        "user3:      It is offically release, and it only disable debugging features."
##        "user4:      It is offically release, and it only disable debugging features."
##        "user5:      It is offically release, and it only disable debugging features."
##        "user6:      It is offically release, and it only disable debugging features."
##        "user7:      It is offically release, and it only disable debugging features."
##        "user8:      It is offically release, and it only disable debugging features."
##        "user9:      It is offically release, and it only disable debugging features."
##  )
##  _F_PageMenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Product Type (q: quit) *****"
##  if [ x"${LvpcResult}" = x"${___PMUC[0]}" ]; then
##      LvpcOptionBuild=userdebug
##      echo "hit"
##  fi
##
function _F_PageMenuUtils()
{
    if [ $# -gt 5 ]; then
        exit 0
    fi

    # Check if parameter is digit and Converse it to a valid parameter
    echo "$3" | grep -E '[^0-9]' >/dev/null && LvPmuX="0" || LvPmuX="$3";
    if [ x"${LvPmuX}" = x"0" ]; then
        LvPmuX=1
    fi
    echo "$4" | grep -E '[^0-9]' >/dev/null && LvPmuY="0" || LvPmuY="$4";
    if [ x"${LvPmuY}" = x"0" ]; then
        LvPmuY=1
    fi

    # Check if parameter is a valid
    if [ x"$2" != x"Input" -a x"$2" != x"Select" ]; then
        exit 0
    fi

    LvPageMenuUtilsContentCount=${#___PMUC[@]}
    LvPageIdx=0
    LvPageCount=$((LvPageMenuUtilsContentCount/___PU)) 
    while [ ${LvPageMenuUtilsContentCount} -gt 0 ]; do
        # Loading the specified page to display
        declare -a GvMenuUtilsContent
        for(( LvIdx=$((___PU*LvPageIdx)); LvIdx < LvPageMenuUtilsContentCount; LvIdx++ )) {
            if [ ${LvIdx} -lt $((___PU*LvPageIdx+___PU)) ]; then
                GvMenuUtilsContent[LvIdx-$((___PU*LvPageIdx))]="${___PMUC[${LvIdx}]}"
            else
                break
            fi
        }
        if [ ${LvIdx} -ne ${LvPageMenuUtilsContentCount} ]; then
            GvMenuUtilsContent[LvIdx-$((___PU*LvPageIdx))]="NextPage.$((LvPageIdx+1))"
        fi
        _F_MenuUtils LvResult  "$2" $3 $4 "$5"
        unset GvMenuUtilsContent
        if [ x"${LvResult}" = x"NextPage.$((LvPageIdx+1))" ]; then
            LvPageIdx=$((LvPageIdx+1))
            continue
        fi
        break
    done
    eval $1=$(echo -e "${LvResult}" | sed "s:\ :\\\\ :g")
}


## _F_Stdin_GetDigit <oResult> [<prompt>]
##
## _F_Stdin_GetDigit  oResult  "hello world: "
## echo "Result: $oResult"
function _F_Stdin_GetDigit()
{
    if [ ! -z "$2" ]; then 
        LvSgdCmd='read -p "$2 " LvSgdNum'
    else 
        LvSgdCmd='read LvSgdNum'
    fi   

    LvSgdNum=""
    while [ -z "${LvSgdNum}" ]; do
        eval ${LvSgdCmd}   
        echo ${LvSgdNum} | grep -E '[^0-9]' >/dev/null && LvSgdNum="" || break; 
    done 

    eval $1="${LvSgdNum}"
}

#------------- End Of UI Library ---------------






#-------------------------------------
#  Entry     main 
#-------------------------------------
if [ x"$1" = x"-h" ]; then
cat >&1<<EOF

/ # jllim_L170H.sh

      ***** Actions (q: quit) *****
EOF

echo -e " ${___AccOff}${___FgSeaBule}${___BgRed}Flash.Kernel: ...${___AccOff}"
echo -e " ..."
echo -e " ..."
echo
echo
    exit 0
fi




i=0
declare -i ___PU=10
declare -a ___PMUC=(
    "test: test-1"
    "test: test-2"
    "test: test-3"
)
_F_PageMenuUtils ___res  "Select" 7 4 "***** Configure Under \"~/.ssh/\" (q: quit) *****"
if [ x"${___res}" = x"${___PMUC[i++]}" ]; then
    unset ___PU
    unset ___PMUC
    echo
    echo "JLLim: test-$i"
    echo
    exit 0
fi

if [ x"${___res}" = x"${___PMUC[i++]}" ]; then
    unset ___PU
    unset ___PMUC
    echo
    echo "JLLim: test-$i"
    echo
    exit 0
fi

if [ x"${___res}" = x"${___PMUC[i++]}" ]; then
    unset ___PU
    unset ___PMUC
    echo
    echo "JLLim: test-$i"
    echo
    exit 0
fi

if [ x"${___res}" = x"${___PMUC[i++]}" ]; then
    unset ___PU
    unset ___PMUC
    echo
    echo "JLLim: test-$i"
    echo
    exit 0
fi

[ x"${___PU}" != x ] && unset ___PU                  
[ x"${___PMUC}" != x"${___PMUC}" ] && unset ___PMUC

