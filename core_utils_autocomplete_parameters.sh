#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     core_utils_autocomplete_parameters.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-04-28 15:42:49
#   ModifiedTime: 2017-04-28 16:55:56
#
# Abbreviation: cuap
# source core_utils_autocomplete_parameters.sh in ~/.bashrc

JLLPATH="$(which core_utils_autocomplete_parameters.sh)"
JLLPATH="$(dirname ${JLLPATH})"


#
# jll.query.git_log_with_grep.sh [--author=<USER_NAME>] [PATTERN]
#
function _____cuap__query_git_log_with_grep()
{
    local cur prev opts
    # clean up completed cache
    COMPREPLY=()
    # the word to the current cursor
    cur="${COMP_WORDS[COMP_CWORD]}"    
    # the previous word to the current cursor 
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # argument list
    opts="--author= help"

    if [[ ${cur} == * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )     
        return 0     
    fi    
}










declare -a registed_table=(
    #Function                      #ShellFile
    "_____cuap__query_git_log_with_grep"  "jll.query.git_log_with_grep.sh"
)

GvRegTableCount=${#registed_table[@]}/2
for((i=0; i<GvRegTableCount; i+=2)){
    if [ -e "${JLLPATH}/${registed_table[i+1]}" ]; then
        complete -F ${registed_table[i]} ${registed_table[i+1]}
    else
        echo "JLL: Error because ${JLLPATH}/${registed_table[i+1]} is not present"
    fi
}

