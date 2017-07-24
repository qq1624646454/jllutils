#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     core_utils_autocomplete_parameters.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-04-28 15:42:49
#   ModifiedTime: 2017-07-24 15:00:27
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


#
# jll.Git.sh [push|pull]
#
function _____cuap__Git()
{
    local cur prev opts
    # clean up completed cache
    COMPREPLY=()
    # the word to the current cursor
    cur="${COMP_WORDS[COMP_CWORD]}"
    # the previous word to the current cursor
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # argument list
    opts="push pull help"

    if [[ ${cur} == * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}


#
# jll.hi.android.drm.sh [drm-scheme] [keyword-regular-expression] 
#
function _____cuap__hi_android_drm()
{
    local cur prev opts
    # clean up completed cache
    COMPREPLY=()
    # the word to the current cursor
    cur="${COMP_WORDS[COMP_CWORD]}"
    # the previous word to the current cursor
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # argument list
    opts="pr playready wv widevine --help -h"

    if [[ ${cur} == * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}



#
# jll.symbol.sh -s=<Symbol> -f=<FileType> [-f=<FileType> ... ] [-m=<0|1>]
#
function _____cuap__symbol()
{
    local __command_first_parameters="-s= -f= -m="
    local cur prev opts
    # clean up completed cache
    COMPREPLY=()
    # the word to the current cursor
    cur="${COMP_WORDS[COMP_CWORD]}"
    # the previous word to the current cursor
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    case ${COMP_CWORD} in
    1)
        # load the first level parameters into auto-completed list
        COMPREPLY=( $(compgen -W "${__command_first_parameters}" -- ${cur}) )
        ;;
    *)
        ;;
    esac

}



#####################################################################
## START|  vicc - auto-complete functions
#####################################################################

#
# vicc -l          || vicc --list
# vicc -c          || vicc --create 
# vicc -d          || vicc --delete
# vicc -t <Symbol> || vicc --tag <Symbol>
# vicc -u          || vicc --update
# vicc --auto
#
function _____cuap__vicc()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    # COMP_CWORD is the system variable, it implies the current command keyword index.
    #    0: the first word
    case ${COMP_CWORD} in
    0) # Command name is typing by user, so nothing to do
        ;;
    1) # Command name has already been done, the first parameter can be started.
#        local __command_first_parameters=""
#        if [ x"$(echo ${cur} | grep -E '^-')" != x ]; then
#            __command_first_parameters=
#                "-l -list -c --create -d --delete -t --tag -u --update --auto"
#        fi
#        if [ x"${cur}" = x ]; then
#            __command_first_parameters="$(ls)"
#        fi
        # load the first level parameters into auto-completed list
        COMPREPLY=( $(compgen -W "-l --list -c --create" -- ${cur}) )
        ;;
    *)
        ;;
    esac
}
#####################################################################
## END|  vicc - auto-complete functions
#####################################################################









declare -a registed_table=(
    #Function                               #ShellFile
    "_____cuap__query_git_log_with_grep"    "jll.query.git_log_with_grep.sh"
    "_____cuap__Git"                        "jll.Git.sh"
    "_____cuap__hi_android_drm"             "jll.hi.android.drm.sh"
    "_____cuap__symbol"                     "jll.symbol.sh"

    # vicc is an independent utils differred from jllutils.
    "_____cuap__vicc"                       "vicc"
)

GvRegTableCount=${#registed_table[@]}
for((i=0; i<GvRegTableCount; i+=2)){
    if [ -e "${JLLPATH}/${registed_table[i+1]}" ]; then
        complete -F ${registed_table[i]} ${registed_table[i+1]}
        # echo "JLL: ${JLLPATH}/${registed_table[i+1]}"
    else
        if [ x"$(which ${registed_table[i+1]})" != x ]; then
            complete -F ${registed_table[i]} ${registed_table[i+1]}
        else
            echo "JLL: Error because not found ${registed_table[i+1]}"
        fi
    fi
}

