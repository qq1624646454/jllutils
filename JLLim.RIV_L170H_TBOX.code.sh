#!/bin/bash
# Copyright(c) 2016-2100.  JLLim.  All rights reserved.
#
#   FileName:     JLLim.RIV_L170H_TBOX.code.sh
#   Author:       jielong lin 
#   Email:        jielong.lin@qq.com
#   DateTime:     2020-01-13 16:39:21
#   ModifiedTime: 2020-05-07 20:42:49

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


function CODE_Download_By_repo()
{
    if [ x"$1" = x ]; then
        echo
        echo "JLLim: ERROR because not confirm which code project"
        echo "JLLim:     Please input project name as follows:"
        echo "JLLim:         reachxm.com"
        echo "JLLim:         itrackstar.com"
        echo "JLLim:         xmlenz.com"
        echo "JLLim:         yaxon.com"
        echo "JLLim:         yutong.com"
        echo
        exit 0
    fi

    _GitRepoTool=

    if [ x"$1" = x"reachxm.com" -o x"$1" = x"itrackstar.com" ]; then
        if [ x"${_GitRepoTool}" = x -a -e ./git-repo/repo ]; then
            mkdir -pv $1/L170H-TBOX
            cd $1/L170H-TBOX
            _GitRepoTool=../../git-repo
        fi
 
        if [ x"${_GitRepoTool}" = x -a -e ../git-repo/repo ]; then
            mkdir -pv L170H-TBOX
            cd L170H-TBOX
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
            mkdir -pv $1/L170H-TBOX
            cd $1/L170H-TBOX
            _GitRepoTool=../../git-repo
        fi

        _GerritProjectName=
        _GerritManifestBranch="master"
        if [ x"$1" = x"reachxm.com" -o x"$1" = x"itrackstar.com" ]; then
            _GerritProjectName="L170H-TBOX"
            _GerritManifestBranch="master"
            echo "


"  |  \
            ${_GitRepoTool}/repo init \
                -u ssh://gerrit29418.reachxm.com/${_GerritProjectName}/platform/manifest \
                -b ${_GerritManifestBranch} --config-name --repo-url=$(pwd)/${_GitRepoTool}
            ${_GitRepoTool}/repo sync

            #Switch to tbox from remotes/origin/tbox
            ${_GitRepoTool}/repo forall -c 'git checkout -b tbox remotes/origin/tbox'
        fi
    else
        echo "JLLim| Not support for $1"
    fi

    cd - >/dev/null

    unset _GitRepoTool
}


CODE_Download_By_repo "$1"

