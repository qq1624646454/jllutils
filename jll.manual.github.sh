#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.github.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-12 09:24:44
#   ModifiedTime: 2016-11-12 09:32:53

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


cat >&1 <<EOF

GitHub is only free to support for the public project, 
so I only release some final projects into GitHub.

Usage: create a new repository on the command line
    echo "# vicc" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git remote add origin git@github.com:qq1624646454/vicc.git
    git push -u origin master

Usage: push an existing repository from the command line
    git remote add origin git@github.com:qq1624646454/vicc.git
    git push -u origin master



>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   vicc - release platform
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    git clone git@github.com:qq1624646454/vicc.git




>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   vicc_installer - release platform
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    git clone git@github.com:qq1624646454/vicc_installer.git





EOF

