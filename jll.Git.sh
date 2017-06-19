#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

# KeyName Url_with_SSH_rather_than_https 
__JLLCFG_SshKey_RootPath="${HOME}/.sshconf"
declare -a __JLLCFG_SshKey_URLs=(
  "qq1624646454@csdn_github"        "git@github.com:qq1624646454/jllutils.git"
  "qq1624646454@csdn_github"        "git@github.com:qq1624646454/vicc.git"
  "qq1624646454@csdn_github"        "git@github.com:qq1624646454/vicc_installer.git"
  "qq1624646454@csdn_github"        "git@github.com:qq1624646454/JoyfulPuTTY.git"
  "qq1624646454@csdn_github"        "git@github.com:qq1624646454/philipstv_tpv.git"
  "jielong.lin_nopassword@github"   "git@github.com:linjielong/iDSS.git"
)
if [ x"${__JLLCFG_SshKey_URLs}" = x ]; then
more >&1<<EOF

JLL-Exit: Not found ${Fred}'__JLLCFG_SshKey_URLs[]'${AC}
JLL-Exit: exit 0

EOF
    unset __JLLCFG_SshKey_RootPath
    exit 0
fi
__JLLCFG_NR_SshKey_URLs=${#__JLLCFG_SshKey_URLs[@]} 
if [ ${__JLLCFG_NR_SshKey_URLs} -lt 1 ]; then
more >&1<<EOF

JLL-Exit: ${Fred}'__JLLCFG_SshKey_URLs[]'${AC} is invalid because its count is 0.
JLL-Exit:  exit 0

EOF
    unset __JLLCFG_NR_SshKey_URLs
    unset __JLLCFG_SshKey_URLs
    unset __JLLCFG_SshKey_RootPath
    exit 0
fi


__ssh_package=.__ssh_R$(date +%Y_%m_%d__%H_%M_%S)
function __Fn_prepare_GIT()
{
    if [ x"$1" != x"push" -a x"$1" != x"pull" ]; then
more >&1<<EOF

JLL-Error: call prototype failure - ${Fred}__Fn_prepare_GIT "[push|pull]${AC}"
JLL-Exit:  exit 0

EOF
        [ x"${__JLLCFG_SshKey_URLs}" != x ] && unset __JLLCFG_SshKey_URLs
        exit 0
    fi

    if [ x"$1" = x"push" ]; then
        __URL=$(git remote show origin | grep -Ei '^[ \t]{0,}Push[ \t]{1,}URL:')
        __URL=${__URL##*URL: }
    fi
    if [ x"$1" = x"pull" ]; then
        __URL=$(git remote show origin | grep -Ei '^[ \t]{0,}Fetch[ \t]{1,}URL:')
        __URL=${__URL##*URL: }
    fi

    __is_HTTPS_URL=$(echo "${__URL}" | grep -Ei '^[ \t]{0,}https://')
    if [ x"${__is_HTTPS_URL}" = x ]; then #ssh url should use ssh key
        [ -e "${HOME}/.ssh/id_rsa" ] && __isSSHKey=1 || __isSSHKey=0
        __MyChoice="n"
        if [ ${__isSSHKey} -eq 1 ]; then
            [ x"${__isSSHKey}" != x ] && unset __isSSHKey
more >&1<<EOF

  GIT Remote Transaction require to using SSH-Key: 
    ${Fseablue}~/.ssh/id_rsa if press ${Fyellow}[y]${AC};
    ${Fseablue}exit if press ${Fyellow}[q]${AC};
    ${Fseablue}next to select other SSH-Key if press ${Fyellow}[Other-Any]${AC};
EOF
            read -n 1 __MyChoice
            if [ x"${__MyChoice}" = x"q" ]; then
                unset __MyChoice
                [ x"${__JLLCFG_SshKey_URLs}" != x ] && unset __JLLCFG_SshKey_URLs
                [ x"${__JLLCFG_NR_SshKey_URLs}" != x ] && unset __JLLCFG_NR_SshKey_URLs
                [ x"${__JLLCFG_SshKey_RootPath}" != x ] && unset __JLLCFG_SshKey_RootPath
                [ x"${__URL}" != x ] && unset __URL
                exit 0
            fi
        fi
        [ x"${__isSSHKey}" != x ] && unset __isSSHKey
        if [ x"${__MyChoice}" != x"y" ]; then
            unset __MyChoice
            __isMatch=${__JLLCFG_NR_SshKey_URLs}
            for((__i=0; __i<__JLLCFG_NR_SshKey_URLs; __i+=2)) {
                echo "JLL-Probing: \"${__JLLCFG_SshKey_URLs[__i+1]}\" = \"${__URL}\""
                if [ x"${__JLLCFG_SshKey_URLs[__i+1]}" = x"${__URL}" ]; then
                    echo "JLL-Hit: \"${__JLLCFG_SshKey_URLs[__i+1]}\" = \"${__URL}\""
                    __isMatch=${__i}
                    break;
                fi
            }
            [ x"${__URL}" != x ] && unset __URL
            if [ ${__isMatch} -ne ${__JLLCFG_NR_SshKey_URLs} -a \
                -e "${__JLLCFG_SshKey_RootPath}/${__JLLCFG_SshKey_URLs[__isMatch]}" ]; then
                echo "JLL-Using: ${__JLLCFG_SshKey_RootPath}/${__JLLCFG_SshKey_URLs[__isMatch]}"
                # Replace the ~/.ssh
                if [ -e "${HOME}/.ssh" ]; then
                    echo "JLL-SSHKey: \"~/.ssh\" is being moved to \"${__ssh_package}\""
                    mv -fv ${HOME}/.ssh  ${HOME}/${__ssh_package}
                    echo
                fi
                mkdir -pv ${HOME}/.ssh
                chmod 0777 ${HOME}/.ssh
more >&1<<EOF 
JLL-SSHKey: Setup \"${__JLLCFG_SshKey_RootPath}/${__JLLCFG_SshKey_URLs[__isMatch]}\" to \"~/.ssh\""
EOF
                cp -rvf ${__JLLCFG_SshKey_RootPath}/${__JLLCFG_SshKey_URLs[__isMatch]}/*  \
                        ${HOME}/.ssh/
                chmod -R 0500 ${HOME}/.ssh/*
                if [ -e "${HOME}/.ssh/config" ]; then
                    chmod +w ${HOME}/.ssh/config*
                fi
                [ x"${__JLLCFG_SshKey_URLs}" != x ] && unset __JLLCFG_SshKey_URLs
                [ x"${__JLLCFG_NR_SshKey_URLs}" != x ] && unset __JLLCFG_NR_SshKey_URLs
                [ x"${__JLLCFG_SshKey_RootPath}" != x ] && unset __JLLCFG_SshKey_RootPath
            else
                if [ -e "${HOME}/.ssh" ]; then
                    echo "JLL-SSHKey: \"~/.ssh\" is being moved to \"${__ssh_package}\""
                    mv -fv ${HOME}/.ssh  ${HOME}/${__ssh_package}
                    echo
                fi
                [ x"${__JLLCFG_SshKey_URLs}" != x ] && unset __JLLCFG_SshKey_URLs
                [ x"${__JLLCFG_NR_SshKey_URLs}" != x ] && unset __JLLCFG_NR_SshKey_URLs
                
                ___i=0
                declare -i GvPageUnit=10
                declare -a GvPageMenuUtilsContent
                echo
                echo "JLL-Probing: Collecting all the items from ${__JLLCFG_SshKey_RootPath}"
                __sshconf_list=$(ls -l "${__JLLCFG_SshKey_RootPath}" 2>/dev/null \
                                 | grep -E '^d' | awk -F ' ' '{print $9}')
                for __sshconf_item in ${__sshconf_list}; do
                    echo "JLL-Probing: $___i - ${__sshconf_item}" 
                    GvPageMenuUtilsContent[___i++]="sshkey use: ${__sshconf_item}"
                done
                [ x"${__sshconf_list}" != x ] && unset __sshconf_list
                GvPageMenuUtilsContent[___i]="Install: setup ssh keys then let jllutils over SSH"
                Lfn_PageMenuUtils __result  "Select" 7 4 \
                                  "***** Configure Under \"~/.ssh/\" (q: quit) *****"
                if [ x"${__result}" = x"${GvPageMenuUtilsContent[___i]}" ]; then
                    [ x"${__result}" != x ] && unset __result
                    [ x"${GvPageUnit}" != x ] && unset GvPageUnit 
                    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
                    if [ ! -e "${JLLPATH}/.sshconf/qq1624646454@csdn_github" ]; then
more >&1<<EOF
JLL-Exit: Not exist ${Fred}\"${JLLPATH}/.sshconf/qq1624646454@csdn_github\"${AC}
EOF
                        exit 0 
                    fi
                    [ -e "${__JLLCFG_SshKey_RootPath}" ] && rm -rf ${__JLLCFG_SshKey_RootPath}
                    cp -rf ${JLLPATH}/.sshconf ${__JLLCFG_SshKey_RootPath}
                    cp -rf ${JLLPATH}/.sshconf/qq1624646454@csdn_github ${HOME}/.ssh
                    chmod -R 0500 ${HOME}/.ssh/*
                    if [ -e "${HOME}/.ssh/config" ]; then
                        chmod +w ${HOME}/.ssh/config*
                    fi
                    echo
                    echo "JLL-GIT: Change for letting jllutils over SSH"
                    echo

                    if [ ! -e "${JLLPATH}/.git" ]; then
more >&1<<EOF
JLL-Exit: Not change for letting jllutils over SSH - Not exist ${Fred}\"${JLLPATH}/.git\"${AC}
EOF
                        rm -rf ${HOME}/.ssh
                        rm -rf ${__JLLCFG_SshKey_RootPath}
                        mv -fv ${__ssh_package} ${HOME}/.ssh
                        chmod -R 0500 ${HOME}/.ssh/*
                        if [ -e "${HOME}/.ssh/config" ]; then
                            chmod +w ${HOME}/.ssh/config*
                        fi
                        [ x"${__JLLCFG_SshKey_RootPath}" != x ] && unset __JLLCFG_SshKey_RootPath
                        exit 0
                    fi
                    # Push  URL: https://github.com/qq1624646454/jllutils.git
                    __RawCTX=$(cd ${JLLPATH} >/dev/null;\
                               git remote show origin \
                               | grep -E "^[ \t]{0,}Push[ \t]{1,}URL:[ \t]{0,}git")
                    if [ x"${__RawCTX}" = x ]; then
                        __RawCTX=$(cd ${JLLPATH} >/dev/null;\
                        git remote show origin | grep -E "^[ ]{0,}Push[ ]{1,}URL: ")
                        __RawCTX=${__RawCTX#*URL:}
                        __RawCTX=${__RawCTX/https:\/\//git@}
                        __RawCTX=${__RawCTX/\//:}
                        if [ x"${__RawCTX}" = x ]; then
more >&1<<EOF
JLL-Exit: Not obtain ${Fred}\"git@URL\"${AC} for the current .git
EOF
                            [ x"${__RawCTX}" != x ] && unset __RawCTX
                            [ x"${__JLLCFG_SshKey_RootPath}" != x ] \
                                && unset __JLLCFG_SshKey_RootPath
                            exit 0
                        fi
                        echo
                        cd ${JLLPATH}
                        git remote set-url --push origin ${__RawCTX}
                        echo
                        git remote show origin
                        cd - >/dev/null
                    else
                        cd ${JLLPATH}
                        git remote show origin
                        cd - >/dev/null
                    fi 
                fi
                [ x"${__JLLCFG_SshKey_RootPath}" != x ] && unset __JLLCFG_SshKey_RootPath

            fi
        fi
    fi

    ##__FetchURL=https://github.com/qq1624646454/jllutils.git
    ##__PushURL=git@github.com:qq1624646454/jllutils.git
    echo "__URL=${__URL} _is_HTTPS_URL=${__is_HTTPS_URL}"
    [ x"${__is_HTTPS_URL}" != x ] && unset __is_HTTPS_URL
}

__Fn_prepare_GIT push
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

