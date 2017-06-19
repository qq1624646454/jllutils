#!/bin/bash
#Copyright(c) 2016-2100,  jielong_lin,  All rights reserved.
#

#git push ssh://${GvCONF_HOST}/${LvProject} HEAD:refs/for/${LvCurrentRevision}
GvCONF_HOST=gerrit-master

#User@${GvCONF_EmailSuffix}
GvCONF_EmailSuffix=tpv-tech.com

GvCONF_TAG_Pattern=QM152E_R


#The below variables are set by __SSHCONF_GetCommiter
GvCONF_Committer_Author=
GvCONF_Committer_Email=

function __SSHCONF_GetCommiter()
{
    #Example For:
    #------------------------------
    #Host url
    #HostName 172.20.30.2
    #User jielong.lin 
    #Port 29420
    #IdentityFile ~/.ssh/id_rsa
    if [ ! -e "${HOME}/.ssh/config" ]; then
        GvCONF_Committer_Author=$(git config --global user.name)
        GvCONF_Committer_Email=$(git config --global user.email)
        if [ x"${GvCONF_Committer_Author}" != x -a x"${GvCONF_Committer_Email}" != x ]; then
            echo
            echo "JLL: using origin 'git config --global user.name and user.email':"
            echo "-----------------------------------------------------------"
            echo "JLL: committer author = ${GvCONF_Committer_Author}" 
            echo "JLL: committer email = ${GvCONF_Committer_Email}"
            echo 
        else
            echo
            echo "JLL: failed to use origin 'git config --global user.name and user.email'"
            echo "JLL: please set git config for committer by manual"
            echo
        fi
    else
        declare -a __HOST_Table
        OldIFS=${IFS}
        IFS=$'\n'
        GvI=0
        for GvLine  in $(grep -n -E "^Host " ${HOME}/.ssh/config); do
            __HOST_Table[GvI++]=${GvLine} 
        done 
        IFS=${OldIFS}
        if [ ${GvI} -lt 1 ]; then
            echo
            echo "JLL: Sorry to exit due to none HOST in ${HOME}/.ssh/config"
            echo
            unset __HOST_Table
            exit 0
        fi
        declare -a GvHitHostTable
        declare -a GvHitUserTable
        IFS=$'\n'
        GvK=0
        for GvLine in $(grep --color -n -E "^User " ${HOME}/.ssh/config); do
            echo "JLL: Probing ${GvLine}"
            GvIdx=${GvLine%%:*}
            # Search the line number of the Host 
            for((GvJ=0; GvJ<GvI; GvJ++)) {
                GvIsMatch=0
                if [ ${GvIdx} -lt ${__HOST_Table[GvJ]%%:*} ]; then
                    GvIsMatch=1
                else 
                    # GvIdx belong to the tail item
                    if [ $((GvJ+1)) -eq ${GvI} ]; then
                       echo "JLL: reach to Tail Item"
                       GvIsMatch=1
                       GvJ=$((GvJ+1))
                    fi
                fi

                if [ ${GvIsMatch} -eq 1 ]; then
                    GvIsHit=0
                    for((GvN=0;GvN<GvK;GvN++)) {
                        # check if same
                        if [ x"${GvHitHostTable[GvN]}" = x"${__HOST_Table[GvJ-1]##*Host }" ]; then
                           GvIsHit=1;
                           break;
                        fi
                    }
                    if [ ${GvIsHit} -eq 0 ]; then
                        echo "JLL: Hit=${__HOST_Table[GvJ-1]##*Host }"
                        GvHitHostTable[GvK]=${__HOST_Table[GvJ-1]##*Host }
                        GvHitUserTable[GvK++]=${GvLine##*User }
                    fi
                    break;
                fi
            }
        done
        IFS=${OldIFS}
        unset __HOST_Table
        echo
        echo "======================================="
        echo "JLL: Hit-Total is $GvK"
        echo "======================================="
        echo

        for((i=0;i<${GvK};i++)) {
            echo "JLL: Check if \"$(echo ${GvHitHostTable[i]})\"==\"${GvCONF_HOST}\" "
            if [ x"$(echo ${GvHitHostTable[i]})" = x"${GvCONF_HOST}" ]; then
                GvCONF_Committer_Author=$(echo ${GvHitUserTable[i]})
                GvCONF_Committer_Email=${GvCONF_Committer_Author}@${GvCONF_EmailSuffix}
                break;
            fi
        }
        unset GvHitHostTable
        unset GvHitUserTable

        if [ x"${GvCONF_Committer_Author}" != x -a x"${GvCONF_Committer_Email}" != x ]; then
            echo
            echo "JLL: using ${HOME}/.ssh/config for setting committer:"
            echo "-----------------------------------------------------------"
            echo "JLL: committer author = ${GvCONF_Committer_Author}" 
            echo "JLL: committer email = ${GvCONF_Committer_Email}"
            echo 
        else
            echo
            echo "JLL: failed to use ${HOME}/.ssh/config for setting committer"
            echo "JLL: please set git config for committer by manual"
            echo
        fi
    fi
}


__ssh_package=.__ssh_R$(date +%Y_%m_%d__%H_%M_%S)
function __SSHCONF_Switching_Start__jielong()
{
    echo
    if [ -e "${HOME}/.ssh" ]; then
        echo "JLL: ~/.ssh will be moved to ${__ssh_package}"
        mv -fv ${HOME}/.ssh  ${HOME}/${__ssh_package}
        echo
    fi
    mkdir -pv ${HOME}/.ssh
    chmod 0777 ${HOME}/.ssh
    echo "JLL: Generate ~/.ssh/id_rsa belong to jielong.lin@tpv-tech.com"
cat >${HOME}/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA30E5aVhLJYIp3exNWMIjKFTKd25oOxdw25oBJE4bDxS5yCsE
IJOhNrlPGKzyo22q3tIpiuZg4Ld6l9n2BxNbSND2sezhr4TnikVPPgCZdcGmUGho
OGkVM2CqTiEL2kL9qDS9vEOxg818nHhbiVuF7MVO0eij/Yk17/b+iDgSsmHJ5zcw
DMdA4+jauXERyAzdfEzHbmmKbR6L2TIkMPqYFieFHpS7zGxssR0tPxqTKd7I9reI
2b8rK2yTwCRnaWKTuKP+uOfLYrg0fdx/N88/X8sC6Vfw/qnaoPXoahW1cWDXH1G9
K7Gn+mZxKqGSOZlybcPL+ZNknKZytkRZqc3WRQIDAQABAoIBAGZq9JyIPckSQoSl
cAJE5X4OD+fkRXq+US7dIqL2FeHAP049taIAN9f0AP4v8QvaNqYLwbUP5OeSJHJf
MkeisKDiBBoxsoMjtFixXR3zhnMICHUgwJcIVgqA0QAQlvBlBRrSPyyL3Xa6oOzj
JhMIYpLxHSyczgZ0mMLiC3iQSLt913rdehD1y6aseinLyUuwembvxMZw2FIrSqy9
pKi50Pp2dWQ3rq4M11K7GTe9wfqvIIWVVvnYlawV5SNLUXlK5G8LFS4N/tUN+nqk
MCS7ooeeBKn9/UDjg7l5gDX/VqsCLBvCEO9mg8VT+jkUpE3nbEgO6gBsZ70mBnY9
H1D/iu0CgYEA9y3Ve2bsdmUiDRiNdEOR2WiGtAQOdPeEW6cX/9ldwo+Dff9ZRjXO
eTRjcDHUKmaHGmrrqyZnARAWrWZ9aVIGrPFHFyRAf/oApfJQYDHRtQ285rzKD3FQ
4HIV3TtYfO7gf756xtyYXLSQvNaXEjTbYw+mlZTpBnXWKFnl7LwpwncCgYEA5zjT
BbbgiIjxN56S0Ri8MCWRgeTwdmSIgz/m6+k0YEGu+H8GKmDvSmb7w2nxVuL1FhKQ
BvQe8Kaxnsfu5xiKGNjJ2cSzlR86Bp3h+oVQun7fcAUf704B35DPu1nuM4IyN1zn
gllsbGN10Eg7ZdSiucWcYbsqLMCGvgH6dux5wCMCgYEA9w7v350bYqdpJo/Q61GS
WSzZ3tpjHNQ9jmJwYYEA7zQE6Q4uTDgBvTH45i5X811xUp1mGzaSJATRtdXIKlob
ZAbx2JaahY/7z+JoJg4FnqMxmas/h7nqbbx6UBs+MfmNmQFptJTPEXJFbQpMC52b
XuNIzR/+3j8vpDtezoWwc7cCgYBvszfeTtZxnxZItEZg1P40lDGS+rJfv3ljTn+T
//jZd2G7kkG8P0/aNZ3ybT+1pbaYjycc9Nntj9nGxvdWlLhCAJiipy/KHme9wo/k
onq5XYk7aH5g8OJeympQK8WzBHaV4D/G7MRAKFxF3l8zdmGWNSyy2eQp8mglandA
9ERs2QKBgQCoYfcDBFi+bnr0USxBO2ysXOhkkzLzigos7WEeW+R56zmgqGiiw/o7
vot6BuT0GQnWnhFGh/uEM5+b0Y4vfDKxDXXb4j5Cn6wSMC+Xyn/5XKTJAMleZZg9
M1KJDNJyY9xEVITOo4KFxVTdmPWeuW8x+KRgpOT3Ws1OzBoSZXBo0g==
-----END RSA PRIVATE KEY-----
EOF
    chmod 0400 ${HOME}/.ssh/id_rsa
cat >${HOME}/.ssh/config<<EOF

Host         gerrit-XM
Hostname     172.20.30.2
Port         29419
User         jielong.lin
IdentityFile ~/.ssh/id_rsa

Host         gerrit
Hostname     inblrgit001.tpvision.com
Port         29418
User         jielong.lin
IdentityFile ~/.ssh/id_rsa 

Host         gerrit-master
Hostname     inblrgit001.tpvision.com
Port         29418
User         jielong.lin
IdentityFile ~/.ssh/id_rsa

Host url
HostName 172.20.30.2
User jielong.lin 
Port 29420
IdentityFile ~/.ssh/id_rsa

Host url-tpemaster
HostName 172.16.112.71
User jielong.lin 
Port 29418
IdentityFile ~/.ssh/id_rsa

Host         url_LatAm
Hostname     172.16.112.71
Port         29418
User         jielong.lin
IdentityFile ~/.ssh/id_rsa



EOF
    chmod 0720 ${HOME}/.ssh/config
    echo
}

function __SSHCONF_Switching_End()
{
    if [ -e "${HOME}/${__ssh_package}" ]; then
        if [ -e "${HOME}/.ssh" ]; then
            rm -rvf ${HOME}/.ssh
        fi
        mv -vf ${HOME}/${__ssh_package}  ${HOME}/.ssh
        echo "JLL: Finish restoring the original ssh configuration."
    else
        echo "JLL: Nothing to do for restoring the original ssh configuration."
    fi
}





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

    # Check private ssh key
    GvRescuePath=${HOME}/.ssh.for_____release.R$(date +%Y%m%d%H%M%S)
    if [ -e "${HOME}/.ssh" ]; then
        mv -f ${HOME}/.ssh  ${GvRescuePath}
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


cd ${GvRootPath}
git push -f -u origin master
git log --graph \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
        --abbrev-commit \
        --date=relative | head -n 8
cd - >/dev/null

echo
if [ -e "${HOME}/.ssh" -a -e "${GvRescuePath}" ]; then
    rm -rf ${HOME}/.ssh
    mv -f ${GvRescuePath} ${HOME}/.ssh
fi
echo
unset GvRescuePath
unset GvRootPath

