#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 21:11:31
#   ModifiedTime: 2017-11-15 11:43:02


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
        return 1
    fi
    if [ x"$1" = x"off" ]; then
        echo -e "${___AccOff}\033[?25l${___AccOff}"
    fi
    if [ x"$1" = x"on" ]; then
        echo -e "${___AccOff}\033[?25h${___AccOff}"
    fi
    return 0
}

function _F_Cursor_Move()
{
    if [ -z "$1" -o -z "$2" ]; then
        echo "Sorry,Exit due to the invalid usage" 
        return 1 
    fi

    echo $1 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        
        echo "Sorry,Return because the parameter1 isn't digit" 
        return 1
    fi

    echo $2 | grep -E '[^0-9]' >/dev/null && LvCmFlag="0" || LvCmFlag="1";
    if [ x"${LvCmFlag}" = x"0" ]; then
        echo "Sorry,Return because the parameter2 isn't digit" 
        return 1
    fi

    #'\c' or '-n' - dont break line
    LvCmTargetLocation="${___AccOff}\033[$2;$1H${___AccOff}"
    echo -ne "${LvCmTargetLocation}"

    return 0
}


function _F_Stdin_Read()
{
    if [ -z "$1" ]; then
        echo "Sorry, Exit due to the bad usage"
        return 1 
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
    return 0
}



##
##    declare -a __PMUC=(
##        "userdebug: It will enable the most debugging features for tracing the platform."
##        "user:      It is offically release, and it only disable debugging features."
##    )
##    _F_MenuUtils LvpcResult  "Select" 7 4 "***** PhilipsTV Product Type (q: quit) *****"
##    if [ x"${LvpcResult}" = x"${__PMUC[0]}" ]; then
##        LvpcOptionBuild=userdebug
##        echo "hit"
##    fi
##
function _F_MenuUtils()
{
    if [ $# -gt 5 ]; then
        return 1 
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
        return 1 
    fi

    #LvVisuCount=$[${#__PMUC[@]} / 2]
    LvVisuCount=$(( ${#__PMUC[@]} / 1 ))
    if [ x"$2" = x"Select" -a ${LvVisuCount} -lt 1 ]; then
        # Select Mode but none item to be selected
        echo "Sorry, Cant Run Select Mode Because of None items to be selected."
        return 1
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
            if [ x"$?" = x"1" ]; then
                return 1
            fi
        fi
        clear
        LvRenderLine=${LvVisuY}
        if [ x"$5" != x ]; then # exist title
            _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
            [ x"$?" != x"0" ] && return 1
            echo "$5"
            LvRenderLine=$(( LvRenderLine + 1 ))
        fi
        if [ ${LvVisuCount} -gt 0 ]; then
            for (( LvVisuIdx=0 ; LvVisuIdx<LvVisuCount ; LvVisuIdx++ )) do
                if [ x"$2" = x"Select" ]; then
                    _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
                    [ x"$?" != x"0" ] && return 1
                    if [ ${LvVisuFocus} -eq ${LvVisuIdx} ]; then
                        if [ ${LvVisuFocus} -ne ${LvVisuNextFocus} ]; then
                            # Cancel the focus item reversed style
                            echo -ne " |--- ${__PMUC[LvVisuIdx]}"
                            LvVisuFocus=99999 # lose the focus
                        else
                            # When Focus is the same to Next Focus, such as only exist one item
                            # Echo By Reversing its color
                            echo -ne " |--- ${___AccOff}\033[07m${__PMUC[LvVisuIdx]}${___AccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        fi
                    else
                        if [ ${LvVisuNextFocus} -eq ${LvVisuIdx} ]; then
                            # Echo By Reversing its color
                            echo -ne " |--- ${___AccOff}\033[07m${__PMUC[LvVisuIdx]}${___AccOff}"
                            LvVisuFocus=${LvVisuNextFocus}
                        else
                            echo -ne " |--- ${__PMUC[LvVisuIdx]}"
                        fi
                    fi
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
                if [ x"$2" = x"Input" ]; then
                    _F_Cursor_Move ${LvVisuX} ${LvRenderLine}
                    [ x"$?" != x"0" ] && return 1
                    echo -ne " |--- ${__PMUC[LvVisuIdx]}"
                    LvRenderLine=$(( LvRenderLine + 1 ))
                fi
            done
            ##
            ## Drive UI
            ##

            if [ x"$2" = x"Select" ]; then
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 4 ))"
                [ x"$?" != x"0" ] && return 1
                # echo "Focus:${LvVisuFocus} NextFocus:${LvVisuNextFocus} Count:${LvVisuCount}"
                echo "Focus:${LvVisuFocus} Count:${LvVisuCount}"
                _F_Stdin_Read LvCustuiData
                [ x"$?" != x"0" ] && return 1
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
                    if [ x"$?" = x"1" ]; then
                        return 1;
                    fi
                    break
                    ;;
                "q")
                    LvVisuFocus=99999
                    echo ""
                    echo "Exit: Quit due to your choice: q"
                    echo ""
                    _F_Cursor_EchoConfig "on"
                    return 1
                    ;;
                *)
                    ;;
                esac
                _F_Cursor_EchoConfig "on"
                if [ x"$?" = x"1" ]; then
                    return 1;
                fi
            fi
            if [ x"$2" = x"Input" ]; then
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                [ x"$?" != x"0" ] && return 1
                echo "[Please Input A String (Dont repeat name with the above)]"
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
                [ x"$?" != x"0" ] && return 1
                read LvVisuData
                if [ -z "${LvVisuData}" ]; then
                    echo ""
                    continue
                fi
                if [ x"${LvVisuData}" = x"q" ]; then
                    echo ""
                    echo "Exit: due to your choice: q"
                    echo ""
                    return 1 
                fi
                LvVisuIsLoop=0
                if [ ${LvVisuCount} -gt 0 ]; then
                    for (( LvVisuIdx=0 ; LvVisuIdx<LvVisuCount ; LvVisuIdx++ )) do
                        if [ x"${__PMUC[LvVisuIdx]}" = x"${LvVisuData}" ]; then
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
                return 1
            fi
            if [ x"$2" = x"Input" ]; then
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 1 ))"
                [ x"$?" != x"0" ] && return 1
                echo "[Please Input A String (Dont repeat name with the above)]"
                _F_Cursor_Move ${LvVisuX} "$(( LvRenderLine + 2 ))"
                [ x"$?" != x"0" ] && return 1
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
            eval $1=$(echo -e "${__PMUC[LvVisuFocus]}" | sed "s:\ :\\\\ :g")
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
        return 1 
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
        return 1 
    fi

    LvPageMenuUtilsContentCount=${#___PMUC[@]}
    LvPageIdx=0
    LvPageCount=$((LvPageMenuUtilsContentCount/___PU)) 
    while [ ${LvPageMenuUtilsContentCount} -gt 0 ]; do
        # Loading the specified page to display
        declare -a __PMUC
        for(( LvIdx=$((___PU*LvPageIdx)); LvIdx < LvPageMenuUtilsContentCount; LvIdx++ )) {
            if [ ${LvIdx} -lt $((___PU*LvPageIdx+___PU)) ]; then
                __PMUC[LvIdx-$((___PU*LvPageIdx))]="${___PMUC[${LvIdx}]}"
            else
                break
            fi
        }
        if [ ${LvIdx} -ne ${LvPageMenuUtilsContentCount} ]; then
            __PMUC[LvIdx-$((___PU*LvPageIdx))]="NextPage.$((LvPageIdx+1))"
        fi
        _F_MenuUtils LvResult  "$2" $3 $4 "$5"
        unset __PMUC
        [ x"$?" != x"0" ] && return 1
        if [ x"${LvResult}" = x"NextPage.$((LvPageIdx+1))" ]; then
            LvPageIdx=$((LvPageIdx+1))
            continue
        fi
        break
    done
    eval $1=$(echo -e "${LvResult}" | sed "s:\ :\\\\ :g")
    return 0
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



### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

function Reach_MDM9x07_BY_JLLim()
{
    if [ -e "$(pwd)/.Reachxm_MDM9x07_by_jllim" ]; then
        source $(pwd)/.Reachxm_MDM9x07_by_jllim
    else
       if [ -e "${HOME}/.Reachxm_MDM9x07_by_jllim" ]; then
           source ${HOME}/.Reachxm_MDM9x07_by_jllim
       else
           echo
           echo -e "JLLim: [0m[31mNot found .Reachxm_MDM9x07_by_jllim to specify project[0m"
           read -p "JLLim: Continue to create .Reachxm_MDM9x07_by_jllim if [y], or exit  " -n 1 _xx_choice_
           if [ x"${_xx_choice_}" != x"y" ]; then
               return 
           fi

cat >${HOME}/.Reachxm_MDM9x07_by_jllim<<EOF

## Project_Identifier
##   it is used for "source build/conf/set_bb_env_\${Project_Identifier}.sh"
##
## Project_Path
##   it references to the path of apps_proc in a project, for example:
##        /media/root/work/jllproject/trunk_L170H/apps_proc
## 

declare -a ___PMUC=(
  #Project_Identifier  #Project_Path
  "L170H = /media/root/work/jllproject/trunk_L170H/apps_proc"
  "L170XGHD = /media/root/work/jllproject/trunk_xghd/apps_proc"
  "L170YX = /media/root/work/jllproject/trunk_yx/apps_proc"
)


# Please not need to modify ___PU which is page unit lines
declare -i ___PU=10

EOF
           chmod +w ${HOME}/.Reachxm_MDM9x07_by_jllim
           vim ${HOME}/.Reachxm_MDM9x07_by_jllim
       fi
    fi
    jllProject=""
    jllRoot=""
    if [ x"${___PMUC}" != x ]; then
        [ x"${___PU}" = x ] && ___PU=10
        _F_PageMenuUtils _sel  "Select" 7 4 "***** Which Project Configuration (q: quit) *****"
        [ x"${___PMUC}" != x ] && unset ___PMUC
        [ x"${___PU}" != x ] && unset ___PU
        [ x"$?" != x"0" ] && return 1

        jllProject="${_sel%% = *}"
        jllRoot="${_sel#* = }"
    fi
    [ x"${___PMUC}" != x ] && unset ___PMUC
    [ x"${___PU}" != x ] && unset ___PU

    if [ x"${jllProject}" = x -o x"${jllRoot}" = x ]; then
        echo
        echo -e "JLLim: [0m[31mError, not found the valid Project_Identifier or Project_Path[0m"
        echo
        return 
    fi

    echo "JLLim: Project_Identifier=${jllProject}"
    echo "JLLim: Project_Path=${jllRoot}"

    while [ 1 -eq 1 ]; do
        declare -a ___PMUC=(
            "CodeTree: Enter"
            "Kernel:   Build"
            "Kernel:   Flash"
            "All:      Build"
            "All:      Flash"
            "All:      Update and reBuild"
            "Usage:    Help Information"
        )
        declare -i ___PU=10
        ___PMUCCnt=${#___PMUC[@]}
        _F_PageMenuUtils _sel  "Select" 7 4 \
            "***** ${jllProject} Action Menu (q: quit) *****"
        if [ x"$?" != x"0" ]; then
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            return 1;
        fi

        _resID=0

        # "CodeTree: Enter"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo

            declare -a ___PMUC=(
                "kernel path"
                "mcm-api path"
                "build path"
                "images path"
            )
            ___PU=10
            ___PMUCCnt=${#___PMUC[@]}
            _F_PageMenuUtils _sel  "Select" 7 4 \
                "***** ${jllProject} CodeTree MENU (q: quit no matter what) *****"
            _resID=0
            #kernel path
            if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
                clear
                [ x"${___PU}" != x ] && unset ___PU
                [ x"${___PMUC}" != x ] && unset ___PMUC
                [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
                jllTarget="${jllRoot}/kernel/msm-3.18"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #mcm-api path
            if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
                clear
                [ x"${___PU}" != x ] && unset ___PU
                [ x"${___PMUC}" != x ] && unset ___PMUC
                [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
                jllTarget="${jllRoot}/mcm-api"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #build path
            if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
                clear
                [ x"${___PU}" != x ] && unset ___PU
                [ x"${___PMUC}" != x ] && unset ___PMUC
                [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
                jllTarget="${jllRoot}/poky"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #images path
            if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
                clear
                [ x"${___PU}" != x ] && unset ___PU
                [ x"${___PMUC}" != x ] && unset ___PMUC
                [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
                jllTarget="${jllRoot}/poky/build/tmp-glibc/deploy/images"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            echo
            break; 
        fi

        #"Kernel:   Build"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            cd ${jllRoot}/poky
            source build/conf/set_bb_env_${jllProject}.sh
            mbuild linux-quic
            echo
            break;
        fi

        #"Kernel:   Flash"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img"
                break;
            fi
            cd ${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607
            adb reboot-bootloader
            fastboot devices
            fastboot flash boot mdm9607-boot.img
            fastboot reboot
            cd - >/dev/null 
            echo
            break;
        fi

        #"All:      Build"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            if [ 1 -eq 1 ]; then
                cd ${jllRoot}/poky
                source build/conf/set_bb_env_${jllProject}.sh
                buildclean
                build-9607-image
            else
                if [ ! -e "${jllRoot}/buildapp/build${jllProject}SHIP" ]; then
                    echo -e \
                    "JLLim: Not found ${Fred}${jllRoot}/buildapp/build${jllProject}SHIP${AC}"
                    break;
                fi
                cd ${jllRoot}/buildapp
                ./build${jllProject}SHIP app
            fi
            echo
            break;
        fi

        # "All:      Flash"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/appsboot.mbn" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/appsboot.mbn"
                break;
            fi
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img"
                break;
            fi
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-sysfs.ubi" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-sysfs.ubi"
                break;
            fi
            cd ${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607
            adb reboot-bootloader
            fastboot devices
            echo
            sleep 1
            echo
            fastboot flash aboot appsboot.mbn
            echo
            fastboot flash boot mdm9607-boot.img
            echo
            fastboot flash system mdm9607-sysfs.ubi
            echo
            fastboot reboot
            cd - >/dev/null 
            echo
            break;
        fi

        # "All:      Update and reBuild"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
            if [ ! -e "${jllRoot}/../.svn" ]; then
                echo -e "JLLim: Not found ${Fred}${jllRoot}/../.svn${AC}"
                break;
            fi
            cd ${jllRoot}/../
            if [ x"$(svn status)" != x ]; then
                echo -e "JLLim: Fount the changes as follows:"
                svn status
                echo
                read -p "JLLim: cleanup those changes if [y] or exit" -n 1 _my_choice_
                if [ x"${_my_choice_}" != x"y" ]; then
                    break;
                fi
                svn status | grep -e '^?' | xargs rm -rvf
                svn status | grep -e '^M' | xargs svn revert 
            fi
            echo "JLLim: Updating all to the latest version..."
            svn update
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            if [ 1 -eq 1 ]; then
                cd ${jllRoot}/poky
                source build/conf/set_bb_env_${jllProject}.sh
                buildclean
                build-9607-image
            else
                if [ ! -e "${jllRoot}/buildapp/build${jllProject}SHIP" ]; then
                    echo -e \
                    "JLLim: Not found ${Fred}${jllRoot}/buildapp/build${jllProject}SHIP${AC}"
                    break;
                fi
                cd ${jllRoot}/buildapp
                ./build${jllProject}SHIP app
            fi
            echo "JLLim: Okay"
            cd - >/dev/null
            echo
            break;
        fi

        # "Usage:    Help Information"
        if [ x"${_sel}" = x"${___PMUC[_resID++]}" ]; then
            clear
            [ x"${___PU}" != x ] && unset ___PU
            [ x"${___PMUC}" != x ] && unset ___PMUC
            [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
            echo
cat >&1<<EOF

//build app
cd ${jllRoot}/poky
source build/conf/set_bb_env_${jllProject}.sh

bitbake uarttest -c cleanall
bitbake uarttest 

#Output:
    apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/uarttest
#Push:
    cd apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/uarttest/0.0-r0/image/usr/bin
    adb push uarttest /usr/bin/

#Package to FileSystem:
    bitbake machine-image OR  build-9607-image 

//更好的内核编译方法：
//可以在apps_proc/poky/build/tmp-glibc/work-shared/mdm9607/kernel-source修改代码
//验证正确后，需要手动把代码同步 到apps_proc/kernel目录
使用以下命令编译 
# bitbake linux-quic -c compile -f   // 编译kernel
# bitbake linux-quic -c deploy -f    // 更新镜像


EOF
            break 
        fi
    done
    [ x"${___PU}" != x ] && unset ___PU
    [ x"${___PMUC}" != x ] && unset ___PMUC
    [ x"${___PMUCCnt}" != x ] && unset ___PMUCCnt
}
export -f Reach_MDM9x07_BY_JLLim
