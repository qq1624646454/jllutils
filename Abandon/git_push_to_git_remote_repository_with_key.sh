#!/bin/bash
#Copyright(c) 2016-2100,  jielong_lin,  All rights reserved.
#

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


Lfn_Sys_GetSameLevelPath  GvRootPath ".git"
if [ ! -e "${GvRootPath}" ]; then
    echo
    echo  "Path=\"${GvRootPath}\"" 
    echo  "Error-Exit: Cannot find Git Root Path" 
    echo
    exit 0
fi
echo

cd ${GvRootPath}
git config branch.master.remote origin
git config branch.master.merge refs/heads/master

GvCommDetail="`git status -s`"
echo ${GvCommDetail}
git add -A
git commit -m "
Submit the below CHANGES by $(basename $0) @$(date +%Y-%m-%d\ %H:%M:%S)
${GvCommDetail} 
"

cd - >/dev/null

#####
#####  MAIN
#####
if [ x"$(which realpath)" = x ]; then
    echo
    echo "JLL.IDE: Please install \"realpath\" first"
    echo
    exit 0
fi

    # Check private ssh key
    GvRescuePath=$(realpath ~)/.ssh.for_____release.R$(date +%Y%m%d%H%M%S)
    if [ -e "$(realpath ~)/.ssh" ]; then
        mv -f $(realpath ~)/.ssh  ${GvRescuePath}
    fi
    mkdir -p $(realpath ~)/.ssh
cat >$(realpath ~)/.ssh/id_rsa <<EOF
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
    chmod 0500 $(realpath ~)/.ssh/id_rsa


cd ${GvRootPath}
git push -f -u origin master
git log --graph \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
        --abbrev-commit \
        --date=relative | head -n 8
cd - >/dev/null

echo
if [ -e "$(realpath ~)/.ssh" -a -e "${GvRescuePath}" ]; then
    rm -rf $(realpath ~)/.ssh
    mv -f ${GvRescuePath} $(realpath ~)/.ssh
fi
echo
unset GvRescuePath
unset GvRootPath

