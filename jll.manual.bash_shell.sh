#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.bash_shell.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-12-12 01:13:31
#   ModifiedTime: 2019-12-12 01:15:16

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

declare -a _lstPatchs=(
    "xxx"
    "yyy"
)
_nrLstPaths=\${#_lstPatchs[@]}

declare -a _lstAllVarious=(
    _lstPatchs
    _nrLstPaths
    _prjPath

    _tmp
    _tmp2
    _tmp3
    _i
    _j
    _k
)
_nrLstAllVarious=\${#_lstAllVarious[@]}

function FN_EXIT_DestroyAllVarious()
{
    for((__i=0; __i<_nrLstAllVarious; __i++)) {
        [ x"\$(eval echo \${_lstAllVarious[__i]})" != x ] \\
            && unset \$(eval echo \${_lstAllVarious[__i]})
    }

    [ x"\${_lstAllVarious}" != x ] && unset _lstAllVarious
    [ x"\${_nrLstAllVarious}" != x ] && unset _nrLstAllVarious
}





EOF



