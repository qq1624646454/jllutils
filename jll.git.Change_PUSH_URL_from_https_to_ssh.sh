#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.git.Change_PUSH_URL_from_https_to_ssh.sh 
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-10 20:12:45
#   ModifiedTime: 2017-05-10 20:25:30

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


    if [ ! -e "$(pwd)/.git/" ]; then
        echo
        echo "JLL: Exit because not present $(pwd)/.git"
        echo
        exit 0
    fi
    echo
    echo "JLL: current .git path is \"$(pwd)\""
    echo
    # Push  URL: https://github.com/qq1624646454/jllutils.git
    # Push  URL: git@github.com:qq1624646454/jllutils.git 
    __RawCTX=$(git remote show origin | grep -E "^[ ]{0,}Push[ ]{1,}URL:[ ]{0,}git")
    if [ x"${__RawCTX}" = x ]; then
      __RawCTX=$(git remote show origin | grep -E "^[ ]{0,}Push[ ]{1,}URL: ")
      __RawCTX=${__RawCTX#*URL:}
      __RawCTX=${__RawCTX/https:\/\//git@}
      __RawCTX=${__RawCTX/\//:}
      if [ x"${__RawCTX}" = x ]; then
        echo
        echo "JLL: Exit because not obtain git@URL for the current .git"
        echo
        unset __RawCTX
        exit 0
      fi
      echo
      git remote set-url --push origin ${__RawCTX}
    fi
    echo
    git remote show origin
    echo
    unset __RawCTX
    exit 0


