#!/bin/bash
#

JLLOrig="$(which $0)"
JLLPATH="$(dirname ${JLLOrig})"
JLLNAME="$(basename ${JLLOrig})"

unset JLLOrig

cd ${JLLPATH}

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




## Usage:
##     Lfn_Sys_GetEachUpperLevelPath <oPaths>
## Details:
##     Get the each level path towards upper 
## Parameter:
##     oPaths - output each level paths 
## Example:
##     Lfn_Sys_GetEachUpperLevelPath oPaths 
##     OldIFS=$IFS
##     IFS=:
##     for My_Path in $My_Paths; do
##         echo "--> $My_Path"
##     done
##     IFS=$OldIFS
##
function Lfn_Sys_GetEachUpperLevelPath()
{
    if [ -z "$1" ]; then
        echo
        echo "JLL.Error @ Lfn_Sys_GetEachUpperLevelPath()"
        echo
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
        echo
        echo "JLL.Error @ echo \"${LvGadoulPaths}\" | sed \"s/\ /\\\\\ /g\""
        echo
        exit 0
    fi

    eval $1="${LvGadoulPaths}"
}




## Usage:
##     Lfn_Sys_GetSameLevelPath <oPaths> <iKeywordString>
## Details:
##     Get the path on the same level path with <iKeywordString> from the parent path
##     based on the current path
## Parameter:
##     oPaths - output the specified path
## Example:
##     Lfn_Sys_GetSameLevelPath  oResult ".repo frameworks dalvik libnativehelper"
##     if [ ! -z "${oResult}" ]; then
##         echo "${oResult}"
##     fi
##
## Note: Error as follows
##      Lfn_Sys_GetSameLevelPath  GvRootPath ".git" | tee -a  log.txt
##
function Lfn_Sys_GetSameLevelPath()
{
    if [ $# -ne 2 -o -z "$2" ]; then
        echo
        echo "JLL.Error @ Lfn_Sys_GetSameLevelPath()" 
        echo
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


function FN_GIT_COMMIT_ALL()
{
    Lfn_Sys_GetSameLevelPath  __LvRootPath ".git"
    if [ ! -e "${__LvRootPath}" ]; then
        echo
        echo  "FN_GIT_COMMIT_ALL: Path=\"${__LvRootPath}\"" 
        echo  "Error-Exit: Cannot find Git Root Path" 
        echo
        exit 0
    fi
    echo
    cd ${__LvRootPath}
    git config branch.master.remote origin
    git config branch.master.merge refs/heads/master

    __LvCommDetail="`git status -s`"
    echo ${__LvCommDetail}
    git add -A
    git commit -m "
=========================================================================
 Submit the below CHANGES by $(basename $0) @$(date +%Y-%m-%d\ %H:%M:%S)
-------------------------------------------------------------------------
${__LvCommDetail}
"
    cd - >/dev/null
}


function FN_GIT_PUSH_ALL()
{
    Lfn_Sys_GetSameLevelPath  __LvRootPath ".git"
    if [ ! -e "${__LvRootPath}" ]; then
        echo
        echo  "FN_GIT_PUSH_ALL: Path=\"${__LvRootPath}\"" 
        echo  "Error-Exit: Cannot find Git Root Path" 
        echo
        exit 0
    fi
 
    # Check private ssh key
    __LvRescuePath=${HOME}/.ssh.for_____release.R$(date +%Y%m%d%H%M%S)
    if [ -e "${HOME}/.ssh" ]; then
        mv -f ${HOME}/.ssh  ${__LvRescuePath}
    fi
    mkdir -p ${HOME}/.ssh
cat >${HOME}/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,AECFEEC72412B35880117D37FF07B0A4

MvkHWhuzT0Moy46Q8wwvc5aturk3o4A1ksBa5vIERtLniRh0NDtdWkUAK0drDMeo
jWH0qJXEZgZIuMuFq/8CzWqW9QkqJy1vvbi+iM9Y1jx3txS1KqsPWdOAG4+uwg6Z
8ap29WnBbrubimFDhNOLtwM7VfkpqfRyYCR4dvJ5pJqKP9BikgIYtKUSys9+3N40
AjXt+W3K8h1FalbaX2oumd9YHz+VQqQLYNRRQYFSHGLAzmohu3z4o0W5C9wAYnMw
0CsSS6hJ2yXuIkc/PaICuWz4ucamBmPVS+avrsIh9Ld8XfKzqh7LJR+Tah5YkQrm
u/N9icrfKNOatYpF70UpVzXUVfia9wYMyv7XQEe+YpiFHT9hVuHznyCMaLPA/u5j
Nrdt/R9c4AsGH6gr0Y1ptwoNdJIRd7VSD9pzY0N71974yNwtgvfP6C3e0r1W76Gd
yy1BhOuOkkzZ92fn3QxMpIMUtiOimYx7Z2vdc+pEOHGPfil1UVl9FAHwvnRNS7db
1n92XU6W0X6eqEGoh81BBA9nffIKPSmiB65QEZju3wdRd12pgtg4wP5zXSv9twkl
nz5YL/HqQpihIJhy9EnmaQNM2uEEeEOOi9ayRyXfiDK47t0GbN/tD3CbeSjsBwo3
B/XVA4elZhcC0DUWnR7D6hMnNKdM205iuj+4ryFpuoCQsB61aMW77wS3OGUm1hCE
OMytW3luSzouy8Q4JUCzwoG8AU3LRw5oyxpDqFLjECQN9MPMZFP8uPCBgb3q0ieS
w1VOY0GHMEDObMBbidqwfH+3geIgaVa8F0oJKtAthJT3Q18UUOSiOmllCnkU3Y7z
6DgMsAc3gFshbhKjz0FA9R4xyszkCrO9R0u1kqDdxEXbVPEBgsZMn5AQ99qvdZw+
H4V+KYf3W9wN9DVZ3h879o/tBzQJ37GROz+h7Qlr7C8v70Dl0YmtdAmSZ3/YVVi7
KGHzSfUFUdMJ2z6dbgaQhZyALNb11v70ecCW6rEHz0h5GTnCCXjmkwiocmMWdJjq
GcPRF8X64rONnXXZ9wbii6j6JRrfxgcOKV6JXdoTPBanY2/qS1sWhd/TaVLmr9Sc
USESU4BY5Z2Nejnxlwe+owww9Y51toFXGdJCoVjN+e2hg9sLxXPzY8nYzDfBhMxL
xjupuSgw1pH24nhmMwCq6YHPURs+T8LWDX/ezE9DgxWGHH/guqQJj6yGcrdlrLAp
xwNFBUsOcz8BVusdmLCwjGaYZNK19Z4ZEB7lGcGr2rEsPIBW6C+HK5BoYs5ddN+k
eDLMO2kdr8XYOtZXQAjNHoZsNkGQIu6Y0BKGnvmCqk7Hyklxqh6ewx0bdPBDD3LG
YHMm0ylVKWwYGMkjyPuQ/UJg0btpmo8vCH/cHu5jT9ZCQADF0zsqAWKrpsROgT2I
WiUNmjTbWRn5/tR2/DUDU1D1tLCDyeueg+UzIvnaPwv0/3p9cwzRI/5X/tRu2/R2
dQ6ChDltBUasfFbnFVLhIPX0G7TtH8fGuOrc601t161JhOKz03xgWpSGEBTsQcdh
QRBhky1pkCPEdJmCYcfm9rZFFh90J6eMX978BRC4ENtK9qtejVFCJBgi4nyaJefN
-----END RSA PRIVATE KEY-----
EOF
    chmod 0500 ${HOME}/.ssh/id_rsa

    cd ${__LvRootPath}
    git push -f -u origin master
#    git log --graph \
#            --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
#            --abbrev-commit \
#            --date=relative | head -n 8
    git log --graph --abbrev-commit --date=relative | head -n 9
    cd - >/dev/null
    echo
    if [ -e "${HOME}/.ssh" -a -e "${__LvRescuePath}" ]; then
        rm -rf ${HOME}/.ssh
        mv -f ${__LvRescuePath} ${HOME}/.ssh
    fi
    echo
    unset __LvRescuePath
    unset __LvRootPath 
}

function FN_GIT_CLEAN_RESET_ALL()
{
    Lfn_Sys_GetSameLevelPath  __LvRootPath ".git"
    if [ ! -e "${__LvRootPath}" ]; then
        echo
        echo  "FN_GIT_CLEAN_RESET_ALL: Path=\"${__LvRootPath}\"" 
        echo  "Error-Exit: Cannot find Git Root Path" 
        echo
        exit 0
    fi
    echo
    cd ${__LvRootPath}
    git config branch.master.remote origin
    git config branch.master.merge refs/heads/master

    if [ x"$(git status -s)" != x ]; then
        echo
        read -p "JLL: RESET code if press [y], or not:  " GvChoice
        echo
        if [ x"${GvChoice}" = x"y" ]; then
            git clean -dfx
            git reset --hard HEAD
        fi
    fi
}

function FN_GIT_PULL_ALL()
{
    Lfn_Sys_GetSameLevelPath  __LvRootPath ".git"
    if [ ! -e "${__LvRootPath}" ]; then
        echo
        echo  "FN_GIT_PULL_ALL: Path=\"${__LvRootPath}\"" 
        echo  "Error-Exit: Cannot find Git Root Path" 
        echo
        exit 0
    fi
 
    # Check private ssh key
    __LvRescuePath=${HOME}/.ssh.for_____release.R$(date +%Y%m%d%H%M%S)
    if [ -e "${HOME}/.ssh" ]; then
        mv -f ${HOME}/.ssh  ${__LvRescuePath}
    fi
    mkdir -p ${HOME}/.ssh
cat >${HOME}/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
Proc-Type: 4,ENCRYPTED
DEK-Info: AES-128-CBC,AECFEEC72412B35880117D37FF07B0A4

MvkHWhuzT0Moy46Q8wwvc5aturk3o4A1ksBa5vIERtLniRh0NDtdWkUAK0drDMeo
jWH0qJXEZgZIuMuFq/8CzWqW9QkqJy1vvbi+iM9Y1jx3txS1KqsPWdOAG4+uwg6Z
8ap29WnBbrubimFDhNOLtwM7VfkpqfRyYCR4dvJ5pJqKP9BikgIYtKUSys9+3N40
AjXt+W3K8h1FalbaX2oumd9YHz+VQqQLYNRRQYFSHGLAzmohu3z4o0W5C9wAYnMw
0CsSS6hJ2yXuIkc/PaICuWz4ucamBmPVS+avrsIh9Ld8XfKzqh7LJR+Tah5YkQrm
u/N9icrfKNOatYpF70UpVzXUVfia9wYMyv7XQEe+YpiFHT9hVuHznyCMaLPA/u5j
Nrdt/R9c4AsGH6gr0Y1ptwoNdJIRd7VSD9pzY0N71974yNwtgvfP6C3e0r1W76Gd
yy1BhOuOkkzZ92fn3QxMpIMUtiOimYx7Z2vdc+pEOHGPfil1UVl9FAHwvnRNS7db
1n92XU6W0X6eqEGoh81BBA9nffIKPSmiB65QEZju3wdRd12pgtg4wP5zXSv9twkl
nz5YL/HqQpihIJhy9EnmaQNM2uEEeEOOi9ayRyXfiDK47t0GbN/tD3CbeSjsBwo3
B/XVA4elZhcC0DUWnR7D6hMnNKdM205iuj+4ryFpuoCQsB61aMW77wS3OGUm1hCE
OMytW3luSzouy8Q4JUCzwoG8AU3LRw5oyxpDqFLjECQN9MPMZFP8uPCBgb3q0ieS
w1VOY0GHMEDObMBbidqwfH+3geIgaVa8F0oJKtAthJT3Q18UUOSiOmllCnkU3Y7z
6DgMsAc3gFshbhKjz0FA9R4xyszkCrO9R0u1kqDdxEXbVPEBgsZMn5AQ99qvdZw+
H4V+KYf3W9wN9DVZ3h879o/tBzQJ37GROz+h7Qlr7C8v70Dl0YmtdAmSZ3/YVVi7
KGHzSfUFUdMJ2z6dbgaQhZyALNb11v70ecCW6rEHz0h5GTnCCXjmkwiocmMWdJjq
GcPRF8X64rONnXXZ9wbii6j6JRrfxgcOKV6JXdoTPBanY2/qS1sWhd/TaVLmr9Sc
USESU4BY5Z2Nejnxlwe+owww9Y51toFXGdJCoVjN+e2hg9sLxXPzY8nYzDfBhMxL
xjupuSgw1pH24nhmMwCq6YHPURs+T8LWDX/ezE9DgxWGHH/guqQJj6yGcrdlrLAp
xwNFBUsOcz8BVusdmLCwjGaYZNK19Z4ZEB7lGcGr2rEsPIBW6C+HK5BoYs5ddN+k
eDLMO2kdr8XYOtZXQAjNHoZsNkGQIu6Y0BKGnvmCqk7Hyklxqh6ewx0bdPBDD3LG
YHMm0ylVKWwYGMkjyPuQ/UJg0btpmo8vCH/cHu5jT9ZCQADF0zsqAWKrpsROgT2I
WiUNmjTbWRn5/tR2/DUDU1D1tLCDyeueg+UzIvnaPwv0/3p9cwzRI/5X/tRu2/R2
dQ6ChDltBUasfFbnFVLhIPX0G7TtH8fGuOrc601t161JhOKz03xgWpSGEBTsQcdh
QRBhky1pkCPEdJmCYcfm9rZFFh90J6eMX978BRC4ENtK9qtejVFCJBgi4nyaJefN
-----END RSA PRIVATE KEY-----
EOF
    chmod 0500 ${HOME}/.ssh/id_rsa

    cd ${__LvRootPath}
    git pull -u origin master
    echo
#    git log --graph \
#            --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
#            --abbrev-commit \
#            --date=relative | head -n 8
    git log --graph --abbrev-commit --date=relative | head -n 9
    cd - >/dev/null

    echo
    if [ -e "${HOME}/.ssh" -a -e "${__LvRescuePath}" ]; then
        rm -rf ${HOME}/.ssh
        mv -f ${__LvRescuePath} ${HOME}/.ssh
    fi
    echo
    unset __LvRescuePath
    unset __LvRootPath 
}



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
        "^[")
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






#-----------------------
# The Main Entry Point
#-----------------------

function Fn_Help_Usage()
{

cat >&1 << EOF

[DESCRIPTION]
    Help user to learn about more usage of ${JLLNAME} 

[USAGE-DETAILS] 

    ${JLLNAME} [help]
        Offer user for that how to use this command.

    ${JLLNAME} -c=xxx 
        The shell "xxx" will be created, and be installed to jllutils 

    ${JLLNAME} -d=xxx 
        The shell "xxx" will be deteled, and be uninstalled from jllutils 

    ${JLLNAME} -l
        List all files in jllutils path

EOF

}


GvChoice=y
GvChoiceID=0
while [ x"${GvChoice}" = x"y" ]; do
cat >&1 <<EOF

--------------- Menu -----------------------------
[ChoiceID]  [Content]
  1           Create Or Modify a shell script tool to the runtime environment
  2           Delete the shell script tool from the runtime environment
  3           List all the existed shell script tools in the runtime environemnt	
  4           Edit "BashShellLibrary"
  5           Git Pull jllutils into the latest version 
  6           Git Push the change of jllutils into the remote git reposity 
  7           Modify the jllutils via menu selector 
  q           Quit no matter what

EOF
read -p "[YourChoiceID]   " GvChoiceID
if [ x"${GvChoiceID}" = x"q" ]; then
    exit 0
fi
if [ x"${GvChoiceID}" = x"1" ]; then
    GvChoice=n
fi
if [ x"${GvChoiceID}" = x"2" ]; then
    GvChoice=n
fi
if [ x"${GvChoiceID}" = x"3" ]; then
    GvChoice=y
    echo ""
    ls ${JLLPATH} | more 
#    GvNameList=$(ls ${JLLPATH})
#    if [ ! -z "${GvNameList}" ]; then
#        for GvName in ${GvNameList}; do
#            GvName="${GvName##${JLLPATH}}"
           #GvName1="${GvName##/jll.}"
           #GvName1="${GvName1%%.sh}"
           #GvName2="${GvName##/}"
           #echo "  ${GvName1} : ${GvName2}"
#            echo "  ${GvName}"
#        done
#    fi
    echo ""
fi
if [ x"${GvChoiceID}" = x"4" ]; then
    GvChoice=y
    echo ""
    vim ${JLLPATH}/BashShellLibrary
    exit 0 
fi
if [ x"${GvChoiceID}" = x"5" ]; then
    GvChoice=y
    echo
    FN_GIT_CLEAN_RESET_ALL
    FN_GIT_PULL_ALL
    exit 0 
fi
if [ x"${GvChoiceID}" = x"6" ]; then
    GvChoice=y
    echo
    FN_GIT_COMMIT_ALL
    FN_GIT_PUSH_ALL
    exit 0 
fi

if [ x"${GvChoiceID}" = x"7" ]; then
    GvChoice=y
    echo ""
    declare -i GvPageUnit=10
    declare -a GvAllMenuUtilsContent
    declare -i GvAllMenuUtilsContentCount=0
    for GvUnits in $(cd ${JLLPATH}; ls ${JLLPATH}); do
        if [ x"${GvUnits}" = x"${JLLNAME}" ]; then
            continue
        fi
        GvAllMenuUtilsContent[GvAllMenuUtilsContentCount++]="${GvUnits}"
    done

    GvPageIdx=0
    GvPageCount=$((GvAllMenuUtilsContentCount/GvPageUnit)) 
    while [ ${GvAllMenuUtilsContentCount} -gt 0 ]; do
        # Loading the specified page to display
        declare -a GvMenuUtilsContent
        for(( GvIdx=$((GvPageUnit*GvPageIdx)); GvIdx < GvAllMenuUtilsContentCount; GvIdx++ )) {
            if [ ${GvIdx} -lt $((GvPageUnit*GvPageIdx+GvPageUnit)) ]; then
                GvMenuUtilsContent[GvIdx-$((GvPageUnit*GvPageIdx))]="${GvAllMenuUtilsContent[${GvIdx}]}"
            else
                break
            fi
        }
        if [ ${GvIdx} -ne ${GvAllMenuUtilsContentCount} ]; then
            GvMenuUtilsContent[GvIdx-$((GvPageUnit*GvPageIdx))]="NextPage.$((GvPageIdx+1))"
        fi
        Lfn_MenuUtils GvResult  "Select" 7 4 "***** JllUtils Menu Selector For Modification (q: quit) *****"
        unset GvMenuUtilsContent
        if [ x"${GvResult}" = x"NextPage.$((GvPageIdx+1))" ]; then
            GvPageIdx=$((GvPageIdx+1))
            continue
        fi
        break
    done
    unset GvAllMenuUtilsContent

    if [ ! -e "${JLLPATH}/${GvResult}" ]; then
        echo "JLL: Sorry, Donot exist \"${JLLPATH}/${GvResult}\" "
        exit 0
    else
        echo " \"${JLLPATH}/${GvResult}\" exist, do you edit it ? [y]     "
        read -n 1 -s GvChoice
        if [ x"${GvChoice}" = x"y" ]; then
            vi ${JLLPATH}/${GvResult}
        fi
    fi
    echo " \"commit the latest modification by git\" if press [y]     "
    read -n 1 -s GvChoice
    if [ x"${GvChoice}" = x"y" ]; then
        FN_GIT_COMMIT_ALL
        FN_GIT_PUSH_ALL
    fi
    exit 0 
fi





done 

if [ x"${GvChoiceID}" = x"1" ]; then
    cd ${GvJLLPATH}
    while [ 1 -eq 1 ]; do 
        echo ""
        echo "Exit if press [q]"
        read -p "Shell-Script-Name:  " GvHitFile
        if [ x"${GvHitFile}" = x"q" ]; then
            exit 0
        fi
        if [ x"${GvHitFile}" = x ]; then
            continue 
        fi
        break
    done
    if [ ! -e "${JLLPATH}/${GvHitFile}" ]; then
        vi ${JLLPATH}/${GvHitFile}
        chmod 0777 ${JLLPATH}/${GvHitFile}
    else
        echo " \"${JLLPATH}/${GvHitFile}\" exist, do you edit it ? [y]     "
        read -n 1 -s GvChoice
        if [ x"${GvChoice}" = x"y" ]; then
            vi ${JLLPATH}/${GvHitFile}
        fi
    fi
    cd -
    echo " \"commit the latest modification by git\" if press [y]     "
    read -n 1 -s GvChoice
    if [ x"${GvChoice}" = x"y" ]; then
        FN_GIT_COMMIT_ALL
        FN_GIT_PUSH_ALL
    fi
    exit 0
fi

if [ x"${GvChoiceID}" = x"2" ]; then
    cd ${JLLPATH}
    while [ 1 -eq 1 ]; do 
        echo ""
        ls ${JLLPATH} | more
        echo ""
        echo "Deleting the specified shell script now ... But exit if press [q]"
        read -p "Shell-Script-Name:  " GvHitFile
        if [ x"${GvHitFile}" = x"q" ]; then
            exit 0
        fi
        if [ x"${GvHitFile}" = x ]; then
            continue 
        fi
        if [ ! -e "${JLLPATH}/${GvHitFile}" ]; then
            echo "Do not exist the specfied shell script: \"$GvHitFile\", Please try it again"
            continue
        fi
        if [ x"${GvHitFile}" = x"${JLLNAME}" ]; then
            echo "Don't delete the \"${JLLNAME}\""
            continue
        fi
        echo " \"${JLLPATH}/${GvHitFile}\" exist, do you delete it ? [y]     "
        read -n 1 -s GvChoice
        if [ x"${GvChoice}" = x"y" ]; then
            rm -rvf "${JLLPATH}/${GvHitFile}"
        fi
        exit 0 
    done
fi

exit 0

