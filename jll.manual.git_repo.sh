#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

*******************
** How to Use
*******************

##
## Switch to another U+ version for Asta M
##
$ repo forall -c 'git checkout QM16XE_U_R0.6.0.14'


##
## Lookup the tag version from the current project
##
$ cd frameworks/av
$ git tag -l QM16*
$ cd -


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
$ repo sync -d
$ repo forall -c 'git reset --hard HEAD' # Remove all working directory (and staged) changes.
$ repo forall -c 'git clean -dfx'        # Clean untracked files


## Loop up the commit detail for the only file
## For Example:
##       device/tpvision/common/plf/mediaplayer\$
##       device/tpvision/common/plf/mediaplayer\$ git log -p av/comps/drm/Android.mk 
##
$ git log -p filename


## Ignore list
##
$ vim .gitignore
desktop.ini
:w

EOF

echo  -e "##"
echo  -e "## Push your changes into master repository"
echo  -e "##"
echo  -e "$ repo info ."
echo  -e "Project: \033[0m\033[35m\033[47mplatform/vendor/widevine\033[0m"
echo  -e "Mount path: /home/jielong.lin/aosp_6.0.1_r10_selinux/vendor/widevine"
echo  -e "Current revision: \033[0m\033[31m\033[43mtpvision/androidm_mprep_selinux\033[0m"
echo  -e "Local Branches: 0"
echo  -e "$ git push  ssh://gerrit-master/\033[0m\033[35m\033[47mplatform/vendor/widevine\033[0m HEAD:refs/for/\033[0m\033[31m\033[43mtpvision/androidm_mprep_selinux\033[0m" 
echo

more >&1 <<EOF

    ##
    ## Lookup the Server from where the data is downloaded
    ##
    ssh gerrit
    ssh gerrit-master 



    ##
    ## Repo sync and then compile error
    ##
    please switch to another source server inblrgit004.tpvision.com


*******************
** Install Git
*******************
    aptitude show git
    aptitude install git
    aptitude install git-svn
    aptitude install git-doc
    aptitude install git-email
    aptitude install git-gui
    aptitude install gitk 
    aptitude install gitweb



ERROR
=====================================
Agent admitted failure to sign using 
the key. Permission denied 
(publickey,keyboard-interactive). 
=====================================
$ cd ~
$ ssh-add

EOF

