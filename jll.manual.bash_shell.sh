#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.bash_shell.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-12-12 01:13:31
#   ModifiedTime: 2020-02-18 10:30:18

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







#==============================================================================================
# Get some symbol information from the blocks in file 
# started with CLEAR_VARS and end with BUILD_EXECUTABLE
#==============================================================================================

kws=\$(grep -En "^[ "\$'\\t'"]{0,}include[ "$'\\t'"]{1,}\\\\$\\(" AndrX.mk | \\
      sed -e "s/:[ "\$'\\t'"]\\\\{0,\\\\}include[ "\$'\\t'"]\\\\{1,\\\\}\\\$(/:/g" -e 's/)//g')


echo "-------------"
echo "\${kws}"
echo "-------------"
kw_clear_vars=
kw_build_executable=
for kw in \${kws}; do
    if [ x"\${kw_clear_vars}" = x ]; then
        kw_clear_vars=\${kw##*:}
        if [ x"\${kw_clear_vars}" = x"CLEAR_VARS" ]; then
            kw_clear_vars=\${kw%%:*}
        fi
    else
        kw_build_executable=\${kw##*:}
        if [ x"\${kw_build_executable}" = x"BUILD_EXECUTABLE" ]; then
            kw_build_executable=\${kw%%:*}
            echo "HIT: {\${kw_clear_vars}:\${kw_build_executable}}"
            sed -n "\${kw_clear_vars},\${kw_build_executable}p" AndrX.mk \\
              | grep -E "^[ "$'\\t'"]{0,}LOCAL_SRC_FILE"
        fi
        kw_clear_vars=
        kw_build_executable=
    fi
done

echo '----------------'
sed -n "1,2p" AndrX.mk


EOF



