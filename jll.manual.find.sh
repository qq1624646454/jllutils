#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.find.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-12-12 01:10:42
#   ModifiedTime: 2019-12-12 13:18:04

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


    _tmp1=\$(cd ..;pwd)
    _tmp2=\$(find \${_tmp} -maxdepth 3 -a \\(    -name "out" \\
                                           -o -name ".*" \\
                                           -o -path "\${_tmp}/patch" \\
                                           -o -name "lost+found" \\
                                         \\)  -prune \\
                                     -o -type d \\
                                     -a \\(    -name "apps_proc" \\
                                           -o -name "modem_proc" \\
                                        \\) -print  \\
    ) #| sed "1d")
    echo \${_tmp2}


    find apps_proc \\( -name 'poky' -o -name '.*' -o -name 'kernel' \\) -prune -o -type f -print \\
    | xargs grep -w -i '0x0024' -C 3 --color 2>/dev/null




EOF




