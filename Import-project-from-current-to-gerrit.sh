#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     Import-project-from-current-to-gerrit.sh 
#   Author:       JLLim
#   Email:        493164984@qq.com
#   DateTime:     2020-10-20 23:55:22
#   ModifiedTime: 2021-02-01 16:50:03

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

gerrit_passwd_for_root=


echo
echo "Usage:  $0 [ <ProjectName> [RemoteRepository to be created] ]"
echo
echo "        <ProjectName>/<RemoteRepository> will be created in gerrit"
echo
echo "        $0 M50 products/evb  # M50/products/evb in gerrit"
echo


_MyProject=$1
if [ x"${_MyProject}" = x ]; then
    echo
#    ssh gerrit29418.reachxm.com gerrit ls-projects \
#            | grep -w "Projects" 2>/dev/null
    echo
    read -p "JLLim: [Please name Your Project, such as LAR01,L170,...]  " _MyProject
    echo
    if [ x"${_MyProject}" = x ]; then
        echo "JLLim: Your Project is not named, then exit..."
        echo
        echo "Usage:  $0 [ <ProjectName> [RemoteRepository to be created] ]"
        echo
        echo "        <ProjectName>/<RemoteRepository> will be created in gerrit"
        echo
        echo "        $0 M50 products/evb  # M50/products/evb in gerrit"
        echo
        exit 0
    fi
fi

_RemoteRepository=$2  #such as products/evb will be mapped to ${_MyProject}/products/evb
if [ x"${_RemoteRepository}" = x ]; then
    echo
    read -p "JLLim: [Please name remote repository for ${_MyProject}, such as products/evb]  " \
        _RemoteRepository
    echo
    if [ x"${_RemoteRepository}" = x ]; then
        echo "JLLim: remote repository is not named, then exit..."
        echo
        echo "Usage:  $0 [ <ProjectName> [RemoteRepository to be created] ]"
        echo
        echo "        <ProjectName>/<RemoteRepository> will be created in gerrit"
        echo
        echo "        $0 M50 products/evb  # M50/products/evb in gerrit"
        echo
        exit 0
    fi
fi

_MyLocalProject=$(ls * 2>/dev/null)
if [ x"${_MyLocalProject}" = x ]; then
    echo
    echo "JLLim: none in the current path, then exit..."
    echo
    exit 0
fi
if [ -e "$(pwd)/.git" ]; then
    echo
    echo "JLLim: .git exist in the current path, then exit..."
    echo
    exit 0
fi


_RemoteRepository=${_MyProject}/${_RemoteRepository}
echo
read -n 1 -p "JLLim: [Import to new repository:\"${_RemoteRepository}\" if y, or not]  " \
     _MyY
echo
if [ x"${_MyY}" != x"y" ]; then
    echo
    echo "JLLim: not import then exit..."
    echo
    exit 0
fi

echo
echo "JLLim: matching Your new Project: ${_RemoteRepository}, please waiting..."
lsprojects=$(ssh -o StrictHostKeyChecking=no gerrit29418.reachxm.com gerrit ls-projects)
echo "${lsprojects}"
echo
isProject=$(echo ${lsprojects} | grep -w "${_RemoteRepository}" 2>/dev/null)
if [ x"${isProject}" = x ]; then
    echo
    echo "JLLim: creating new Project: ${_RemoteRepository}, please waiting..."
    echo

    #sshpass -p [corp-id-5]2018 \
    while [ 1 ]; do
        echo
        if [ x"${gerrit_passwd_for_root}" = x ]; then
            echo "JLLim: Please input gerrit password for root account: "
            read gerrit_passwd_for_root
            echo
            if [ x"${gerrit_passwd_for_root}" = x ]; then
                continue
            fi
        fi

        sshpass -p ${gerrit_passwd_for_root} \
        ssh -o StrictHostKeyChecking=no root@gerrit.reachxm.com \
        "cd /home/gerrit/gerrit_site/git; \
         mkdir -p  ${_RemoteRepository}.git; \
         cp -rf product-template.git/*  ${_RemoteRepository}.git/ ; \
         chown gerrit:gerrit -R ${_RemoteRepository}.git; \
         ls -l | grep ${_RemoteRepository}"

         echo
         if [ $? = 0 ]; then
             break 
         fi
         gerrit_passwd_for_root=
    done

    ssh -o StrictHostKeyChecking=no gerrit29418.reachxm.com gerrit flush-caches --all

#    ssh gerrit29418.reachxm.com gerrit create-project "${_RemoteRepository}"
#    ssh gerrit29418.reachxm.com gerrit set-project-parent --parent "${_MyRightsProject}" \
#                                       "${_RemoteRepository}"
    echo
fi

echo
echo "JLLim: re-matching Your new Project: ${_RemoteRepository}, please waiting..."
lsprojects=$(ssh -o StrictHostKeyChecking=no gerrit29418.reachxm.com gerrit ls-projects)
echo "${lsprojects}"
echo
isProject=$(echo ${lsprojects} | grep -w "${_RemoteRepository}" 2>/dev/null)
if [ x"${isProject}" = x ]; then
    echo
    echo "JLLim: Not found the project @${_RemoteRepository}"
    echo
cat >&1<<EOF

JLLim: Just failed to run the below commands:
       sshpass -p ${gerrit_passwd_for_root} \\
           ssh -o StrictHostKeyChecking=no root@gerrit.reachxm.com \\
               "cd /home/gerrit/gerrit_site/git; \\
                mkdir -p  ${_RemoteRepository}.git; \\
                cp -rf product-template.git/*  ${_RemoteRepository}.git/; \\
                chown gerrit:gerrit -R ${_RemoteRepository}.git; \\
                ls -l | grep ${_RemoteRepository}"
       ssh  -o StrictHostKeyChecking=no gerrit29418.reachxm.com gerrit flush-caches --all

JLLim: Further check the caused root-reason
       please first ssh login the remote system then try it again by the follows:
           sshpass -p ${gerrit_passwd_for_root} ssh root@gerrit.reachxm.com

EOF

    exit 0
fi

if [ -e "$(pwd)/.gitignore" ]; then
    _isUpdate=$(cat .gitignore | grep "${0#./}" 2>/dev/null)
    if [ x"${_isUpdate}" = x ]; then
        echo "${0#./}" >> .gitignore
    fi

    _isUpdate=$(cat .gitignore | grep "sync.sh" 2>/dev/null)
    if [ x"${_isUpdate}" = x ]; then
         echo "sync.sh" >> .gitignore
    fi
else
    echo "${0#./}" > .gitignore
fi
echo

git init
git add -A
git commit -m "Create and Import the new product ${_RemoteRepository}"
git remote add origin "ssh://gerrit29418.reachxm.com/${_RemoteRepository}"
git push origin master

echo
_RightsGroup=${_RemoteRepository##*/}-group-${_MyProject}

read -n 1 -p "JLLim: [Create the group named \"${_RightsGroup}\"  if y, or not]  " _MyY_
echo
if [ x"${_MyY_}" = x"y" ]; then
    echo "JLLim: Creating the new group named \"${_RightsGroup}\""
    ssh -o StrictHostKeyChecking=no gerrit29418.reachxm.com gerrit create-group "${_RightsGroup}"
    echo
fi
echo
echo "JLLim: Please configure ${_RightsGroup} into ${_RemoteRepository}..."
echo


