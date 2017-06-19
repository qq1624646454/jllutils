#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

function __Get_URL_From_GIT()
{
    __FetchURL=$(git remote show origin | grep -Ei '^[ \t]{0,}Fetch[ \t]{1,}URL:')
    __PushURL=$(git remote show origin | grep -Ei '^[ \t]{0,}Push[ \t]{1,}URL:')

    echo "__FetchURL=${__FetchURL##*URL: }"
    echo "__PushURL=${__PushURL##*URL: }"
}

__Get_URL_From_GIT
exit 0

if [ x"$1" = x"push" -o x"$1" = x"pull" ]; then
    [ -e "${HOME}/.ssh/id_rsa" ] && __isSSHKey=1 || __isSSHKey=0
    if [ ${__isSSHKey} -eq 1 ]; then
more >&1<<EOF

  GIT Remote Transaction require to using SSH-Key: 
    ${Fseablue}~/.ssh/id_rsa if press ${Fyellow}[y]${AC};
    ${Fseablue}exit if press ${Fyellow}[q]${AC};
    ${Fseablue}next to select other SSH-Key if press ${Fyellow}[Other-Any]${AC};
EOF
        read -n 1 __MyChoice
    else
more >&1<<EOF

  GIT Remote Transaction require to using SSH-Key: 
    ${Fseablue}~/.ssh/id_rsa if press ${Fyellow}[y]${AC};
    ${Fseablue}exit if press ${Fyellow}[q]${AC};
    ${Fseablue}next to select other SSH-Key if press ${Fyellow}[Other-Any]${AC};
EOF
        read -n 1 __MyChoice
 
    fi

fi
exit 0
case x"$1" in
x"push")
    if [ x"$(git status -s)" != x ]; then
        git add -A
        git commit -m "update by $(basename $0) @ $(date +%Y-%m-%d\ %H:%M:%S)"
    fi
    git push -u origin master
    git log --graph \
            --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
            --abbrev-commit \
            --date=relative | head -n 8
    echo
;;
x"pull")
    if [ x"$(git status -s)" != x ]; then
        read -p "JLL-GIT-REPO: Remove all Changes via 'git clean -dfx;git reset --hard HEAD' if press [y], or skip:   " GvChoice
        if [ x"${GvChoice}" = x"y" ]; then
            git clean -dfx;
            git reset --hard HEAD;
        fi
    fi
    git pull -u origin master
    git log --graph \
        --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
        --abbrev-commit \
        --date=relative | head -n 8
    echo
;;
*)
cat >&1 <<EOF

   USAGE:

     $(basename $0) [help]

     # If change is checked by 'git status -s', the follows will be run:
     # 'git add -A'
     # 'git commit -m "update by $(basename $0) @Date"'
     # 'git push -u origin master'
     $(basename $0) push

     # If change is checked by 'git status -s', the follows will be run: 
     # 'git clean -dfx;git reset --hard HEAD' if approve to cleanup all changes
     # 'git pull -u origin master' is always run
     $(basename $0) pull

EOF
;;
esac

exit 0

