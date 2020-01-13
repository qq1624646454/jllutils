#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     JLLim.L170H.code.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-01-13 16:39:21
#   ModifiedTime: 2020-01-13 17:09:46

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


function CODE_Download_master_By_repo()
{
    if [ x"$1" = x ]; then
        echo
        echo "JLLim: ERROR because not confirm which code project"
        echo "JLLim:     Please input project name as follows:"
        echo "JLLim:         L170H"
        echo "JLLim:         L170L"
        echo "JLLim:         lora_endnode"
        echo
        exit 0
    fi

    _GitRepoTool=

    if [ x"${_GitRepoTool}" = x -a -e ./git-repo/repo ]; then
        mkdir -pv $1/master
        cd $1/master
        _GitRepoTool=../../git-repo
    fi
 
    if [ x"${_GitRepoTool}" = x -a -e ../git-repo/repo ]; then
        mkdir -pv master
        cd master 
        _GitRepoTool=../../git-repo
    fi

    if [ x"${_GitRepoTool}" = x -a -e ../../git-repo/repo ]; then
        _GitRepoTool=../../git-repo
    fi

    if [ x"${_GitRepoTool}" = x -a -e ../../../git-repo/repo ]; then
        _GitRepoTool=../../../git-repo
    fi

    if [ x"${_GitRepoTool}" = x ]; then
        git clone  https://mirrors.tuna.tsinghua.edu.cn/git/git-repo
        mkdir -pv $1/master
        cd $1/master
        _GitRepoTool=../../git-repo
    fi
    

    ${_GitRepoTool}/repo init -u ssh://gerrit29418.reachxm.com/$1/platform/manifest \
                    -b master --config-name --repo-url=$(pwd)/${_GitRepoTool}
    ${_GitRepoTool}/repo sync

    #Switch to master from remotes/origin/master
    ${_GitRepoTool}/repo forall -c 'git checkout -b master remotes/origin/master'

    cd - >/dev/null

    unset _GitRepoTool
}


CODE_Download_master_By_repo "$1"

