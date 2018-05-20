#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

###
### folder
### |--- 1.file
### |--- 2.file
### |--- subfolder
### |    |--- 1.file
### |    |--- 2.file
###
### add all files under folder into cache (stage/index) of git repository
${Fseablue}git add folder${AC}
### remove all files under folder from cache (stage/index) of git repository, not include local
${Fseablue}git rm -r --cached folder${AC}



###
### sometimes, must use git rebase origin/2k17_mtk_archer_m_refdev 
### to hold the simple history records
###

# obtain the url from origin which is the remote object.
${Fseablue}git remote show origin${AC}
* remote origin
  Fetch URL: ssh://url/tpv/device/tpv/common/app/contentexplorer
  Push  URL: ssh://url/tpv/device/tpv/common/app/contentexplorer
  HEAD branch: MSAF_2k18_EU_HTV_M
  Remote branches:
    2k17_mtk_archer_m_refdev                tracked
    MSAF_2k18_EU_HTV_M                      tracked
    master                                  tracked

# lookup the url ip is xm server or tpe server
${Fseablue}ssh url${AC}
  ****    Welcome to Gerrit Code Review    ****

  Hi Jielong Lin, you have successfully connected over SSH.

  Unfortunately, interactive shells are disabled.
  To clone a hosted Git repository, use:

  git clone ssh://jielong.lin@172.20.30.2:29420/REPOSITORY_NAME.git

Connection to 172.20.30.2 closed.

# so far, 172.20.30.2 is xm server, try to fetch from xm server
${Fseablue}git rebase origin/2k17_mtk_archer_m_refdev ${AC}
...

# switch to tpe server for origin
${Fseablue}vim ~/.ssh/config ${AC}
Host url
HostName 172.16.112.71
User jielong.lin
Port 29418
IdentityFile ~/.ssh/id_rsa

${Fseablue}ssh url${AC}
  ****    Welcome to Gerrit Code Review    ****

  Hi Jielong Lin, you have successfully connected over SSH.

  Unfortunately, interactive shells are disabled.
  To clone a hosted Git repository, use:

  git clone ssh://jielong.lin@172.16.112.71:29418/REPOSITORY_NAME.git

Connection to 172.16.112.71 closed.

# try to fetch from tpe server
${Fseablue}git rebase origin/2k17_mtk_archer_m_devprod${AC}
...




${Bred}                                                                ${AC}
${Bred}  ${AC}$ ${Fyellow}git pull --rebase${AC}
${Bred}  ${AC}fatal: unable to access \\
${Bred}  ${AC}'https://github.com/linjielong/git_repository_utils4win32.git/': \\
${Bred}  ${AC}Failed to connect to github.com port 443: Timed out
${Bred}                                                                ${AC}
${Fgreen}you should set the proxy for git ${AC}
# if you are working in TPV office workspace, please set proxy for git to download
${Fseablue}git config --global http.proxy "172.20.30.1:3128"${AC}
${Fseablue}git config --global https.proxy "172.20.30.1:3128"${AC}

# if unset proxy
${Fseablue}git config --global --unset http.proxy${AC}
${Fseablue}git config --global --unset https.proxy${AC}



# git log help
# //PRETTY FORMAT
# %H: commit hash                %h: abbreviated commit hash
# %an: author name               %ae: author email
# %cn: committer name            %ce: committer email                %cr: committer date, relative
# %d: ref names (各个branch信息) %C(yellow): switch color to yellow     
# %s: subject                    %Cred: switch color to red          %Cgreen: switch color to green
# %Creset: reset color           %Cblue: switch color to blue        %n: newline 
#
# -(n):  only show last n committed records, n is a digit
# --committer=(who) / --author=(who): only show the records associated with committer/author 
# --since,--after: only show the records after the specified date
# --until, --before: only show the records before the specified date
# git log --pretty="%h - %s" --author="jielong.lin\|jll" --since="2016-01-02" --before="2017-05-01"
# git log -2  //only show last 2 records
# git log -2 -p //only show last 2 records and expand the different changes(展开差异变化)
# git log -2 --stat //only show last 2 records and statistic content
# git log --name-only //only show modified files
# git log --name-status //show add,del,modified files
# git log --relative-date //show the relative data to the current, such as 2 weeks ago
#
# --: tell git log about the later parameter is the path format, such as
#       git log -- foo.py bar.py  //show the records associated with foo.py bar.py files.
#
# -S"hello": if you wanna know when the "hello" is added to the code file and committed, -S"hello" can
#            help you to filter and find out the relative records.
#              git log -S"hello" 
#
${Byellow}${Fblue}# customiaze the log format for jielong.lin${AC}
git log \\
  --pretty=format:'%Cred%h%Creset  %Cgreen%ce%Creset %Cblue(%cr)%Creset  %C(yellow)%s%Creset' -8

git reflog
git reflog \\
  --pretty=format:'%Cred%h%Creset  %Cgreen%ce%Creset %Cblue(%cr)%Creset  %C(yellow)%s%Creset' -8



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
**
**  git git-doc git-email git-man git-svn gitweb
*******************
${Fyellow} aptitude show git ${AC}
${Fyellow} aptitude install git ${AC}
${Fyellow} aptitude install git-svn ${AC}
${Fyellow} aptitude install git-doc ${AC}
${Fyellow} aptitude install git-email ${AC}
${Fyellow} aptitude install gitweb ${AC}
${Fyellow} aptitude install git-man ${AC}
${Fyellow} git config --global push.default matching ${AC}
${Fyellow} git config --global push.default simple ${AC}
${Fyellow} git config --global user.name "Jielong Lin" ${AC}


\$${Bred} ERROR ${AC}
=====================================
Agent admitted failure to sign using 
the key. Permission denied 
(publickey,keyboard-interactive). 
=====================================
\$${Fyellow} cd ~ ${AC}
\$${Fyellow} ssh-add ${AC}






=====================================
git 撤消
=====================================

1. git add 添加 多余文件 
这样的错误是由于， 有的时候 可能 

git add . （空格+ 点） 表示当前目录所有文件，不小心就会提交其他文件

git add 如果添加了错误的文件的话

撤销操作 

git status 先看一下add 中的文件 
git reset HEAD 如果后面什么都不跟的话 就是上一次add 里面的全部撤销了 
git reset HEAD XXX/XXX/XXX.java 就是对某个文件进行撤销了

2. git commit 错误
如果不小心 弄错了 git add后 ， 又 git commit 了。 
先使用 
git log 查看节点 
commit xxxxxxxxxxxxxxxxxxxxxxxxxx 
Merge: 
Author: 
Date: 
然后 
git reset commit_id

over
PS：还没有 push 也就是 repo upload 的时候

git reset commit_id （回退到上一个 提交的节点 代码还是原来你修改的） 
git reset –hard commit_id （回退到上一个commit节点， 代码也发生了改变，变成上一次的）

3.如果要是 提交了以后，可以使用 git revert
还原已经提交的修改 
此次操作之前和之后的commit和history都会保留，并且把这次撤销作为一次最新的提交 
git revert HEAD 撤销前一次 commit 
git revert HEAD^ 撤销前前一次 commit 
git revert commit-id (撤销指定的版本，撤销也会作为一次提交进行保存） 
git revert是提交一个新的版本，将需要revert的版本的内容再反向修改回去，版本会递增，不影响之前提交的内容。



${Fred} Agent admitted failure to sign using the key  ${AC}
ssh-add ~/.ssh/id_rsa



${Fred} gitignore文件中的规则不起作用${AC}
原因是因为在Studio的git忽略目录中，新建的文件在git中会有缓存，如果某些文件已经被纳入了版本管理中，就算是在.gitignore中已经声明了忽略路径也是不起作用的，这时候我们就应该先把本地缓存删除，然后再进行git的push，这样就不会出现忽略的文件了。git清除本地缓存命令如下

git rm -r --cached .
git add .
git commit -m 'update .gitignore'

EOF

