#!/bin/bash
# Copyright(c) 2016-2100   jielong.lin   All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

if [ ! -e "${JLLPATH}/jll.git.patch.sh" ]; then
    echo "JLL: Sorry due to lack of \"${JLLPATH}/jll.git.patch.sh\""
    exit 0
fi

##################################################
#  jielong.lin: Customized Functions 
##################################################

function Fn_GetAllChangePath()
{
repo forall -c 'LvFlags=$(git status -s | grep -E \
"*\.cpp$|*\.c$|*\.java$|*\.h$|*\.hpp$|*.\mk$|Makefile|makefile|*\.rc$");\
if [ x"${LvFlags}" != x ]; then \
    echo "$(pwd)"; \
fi'
}

GvAllChangePathList="$(Fn_GetAllChangePath)"
for GvCP in ${GvAllChangePathList}; do
    echo
#    echo ">>>>> JLL.S$(date +%Y%m%d%H): Git Patch @${GvCP} <<<<<" 
    cd ${GvCP}
#echo "   # jll.git.patch.sh"
    echo "${GvCP}"
    git status -s | grep -E "*\.cpp$|*\.c$|*\.java$|*\.h$|*\.hpp$|*.\mk$|Makefile|makefile|*\.rc$"
#    echo ">>>>> JLL.E$(date +%Y%m%d%H): Git Patch @${GvCP} <<<<<"
    echo
done

#################################################################################

