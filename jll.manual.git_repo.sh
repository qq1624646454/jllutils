#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

***************************************************
** How to Use git & repo in Philips TV Project
***************************************************



***************************************************
** How to Use git & repo in Philips TV Project
***************************************************

##
## Switch to another U+ version for Asta M
##
\$${AC}${Fyellow} repo forall -c 'git checkout QM16XE_U_R0.6.0.14'${AC}


##
## Lookup the tag version from the current project
##
\$${AC}${Fyellow} cd frameworks/av ${AC}
\$${AC}${Fyellow} git tag -l QM16* ${AC}
\$${AC}${Fyellow} cd - ${AC}


## 
## The -d/--detach option can be used to switch specified 
## projects back to the manifest revision. This option is
## especially helpful if the project is currently on a topic
## branch, but the manifest revision is temporarily needed.
##
## However, any staged or working directory changes will be retained.
## If you have mucked up your working directory, and need to get it
## back in order  I would do this
##
\$${AC}${Fyellow} repo sync -d ${AC}
\$${AC}${Fyellow} repo forall -c 'git reset --hard HEAD' ${AC}\
# Remove all working directory (and staged) changes.
\$${AC}${Fyellow} repo forall -c 'git clean -dfx' ${AC}# Clean untracked files


## Loop up the commit detail for the only file
## For Example:
##       device/tpvision/common/plf/mediaplayer\$
##       device/tpvision/common/plf/mediaplayer\$ git log -p av/comps/drm/Android.mk 
##
\$${AC}${Fyellow} git log -p filename ${AC}


## Ignore list
##
\$${AC}${Fyellow} vim .gitignore ${Fgreen}
desktop.ini
${Fpink}:w${AC}

##
## Push your changes into master repository"
##
\$${AC}${Fyellow} repo info . ${Fgreen}
Project: ${Fred}platform/vendor/widevine${Fgreen}
Mount path: /home/jielong.lin/aosp_6.0.1_r10_selinux/vendor/widevine
Current revision: ${Fseablue}tpvision/androidm_mprep_selinux${Fgreen}
Local Branches: 0
\$${Fyellow} git push  ssh://gerrit-master/${Fred}platform/vendor/widevine${Fyellow} \\
                HEAD:refs/for/${Fseablue}tpvision/androidm_mprep_selinux${AC}


##
## Lookup the Server from where the data is downloaded
##
\$${AC}${Fyellow} ssh gerrit ${AC}
\$${AC}${Fyellow} ssh gerrit-master ${AC}



##
## Repo sync and then compile error
##
# please switch to another source server inblrgit004.tpvision.com



##
## line feed character in comment by git commit -m 
##
\$${AC}${Fyellow} git commit -m '
  line1
  line2
'${AC}
\$${AC}${Fyellow} git commit --amend${Fgreen} 
  line1
  line2
${AC}



*******************
** Install Git
*******************
${AC}${Fyellow}
aptitude show git
aptitude install git
aptitude install git-svn
aptitude install git-doc
aptitude install git-email
aptitude install git-gui
aptitude install gitk 
aptitude install gitweb
${AC}


${AC}${Bred} ERROR ${AC}
=====================================
Agent admitted failure to sign using 
the key. Permission denied 
(publickey,keyboard-interactive). 
=====================================
\$${AC}${Fyellow} cd ~ ${AC}
\$${AC}${Fyellow} ssh-add ${AC}

EOF

