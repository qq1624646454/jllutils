#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLFILE="$(which $0)"
JLLFILE="$(basename $0)"
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

GvDate=$(date +%Y%m%d%H%M%S)

function Fn_Usage()
{
cat >&1 <<EOF

  Usage:

      # Hint how to use 
      ${JLLFILE} [help]

      # initialize every git repositories via git clone according to .repoconf 
      ${JLLFILE} init

      # repo sync from remote git repository,
      # equals to repo forall -c 'git reset --hard HEAD;git clean -dfx;git pull -u origin master'
      ${JLLFILE} sync 

      # traversal every git repositories to run the speicified command
      ${JLLFILE} forall -c '<YOUR_COMMAND>'  

EOF
}
echo

GvChanges="$(git status -s)"
if [ x"${GvChanges}" != x ]; then
    git add -A
    GvChanges="$(git status -s)"
    git commit -m \
"
The below changes is committed @ $(date +%Y-%m-%d\ %H:%M:%S)
${GvChanges}
"
fi
read -n 1 -p \
  "\"git push ...\" for merging from local(master) to remote(origin) if press [y], or skip: " _sel 
echo
if [ x"${_sel}" = x"y" ]; then
    git push -u origin master
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
            --abbrev-commit --date=relative | head -n 8
fi

