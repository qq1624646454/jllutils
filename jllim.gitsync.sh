#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jllim.gitsync.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-08-22 09:40:29
#   ModifiedTime: 2019-08-22 10:16:36

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

echo
echo "JLLim: Waiting for connecting to server on git@gerrit.reachxm.com"
_lstGitProj=$(sshpass -p git ssh git@gerrit.reachxm.com \
              "ls -l /home/git/RD/TeamDevlopment/Study | grep -E '^d'" 2>/dev/null)
echo

#_lstGitProj=$(ls -l | grep -E '^d' 2>/dev/null)

if [ x"${_lstGitProj}" = x ]; then
echo
echo "JLLim: Not found any git project in gerrit.reachxm.com:/home/git/RD/TeamDevlopment/Study"
echo
exit 0
fi

declare -a lstGitProj
declare -i   nGitProj=0   #${#lstGitProj[@]}


OIFS=${IFS}
IFS=$'\n'
for _gitProj in ${_lstGitProj}; do
    _gitProj=$(echo "${_gitProj}" | awk -F ' ' '{print $9}' 2>/dev/null)
    if [ x"${_gitProj}" = x ]; then
        continue;
    fi
    lstGitProj[nGitProj++]=${_gitProj}
done
IFS=${OIFS}

#sshpass -p git git clone git@gerrit.reachxm.com:/home/git/RD/TeamDevlopment/Study/laiyy

for ((i=0;i<nGitProj;i++)) {
    if [ -e "$(pwd)/${lstGitProj[i]}" ]; then
        cd $(pwd)/${lstGitProj[i]}
        sshpass -p git git pull origin master
        cd - >/dev/null
    else
        sshpass -p git git clone git@gerrit.reachxm.com:/home/git/RD/TeamDevlopment/Study/${lstGitProj[i]}
    fi
}


