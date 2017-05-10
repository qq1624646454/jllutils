#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.git_svn.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-12-15 13:23:18
#   ModifiedTime: 2016-12-15 15:28:53

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

使用git管理svn版本库
----------------------
git 1.5.3以后开始支持git-svn工具.

使用 git svn clone SVN-repository-url 实现从SVN版本库中创建一个GIT版本库，
速度是非常非常的慢.

还不如使用svn好一些.


>>> Install git-svn <<<
aptitude install git-svn
建议在安装完毕以后做如下配置：
vim ~/.gitconfig
--vim-start----------------
[user]
    name = jielong_lin
    email = jielong.lin@tpv-tech.com
[color]
    diff = auto
    status = auto
    branch = auto
[alias]
    st = status
    rb = svn rebase
    ci = commit -a
    co = checkout
--vim-end-------------------



>>> Initailize Repository <<<
git svn clone  -s svn-repository-url
# svn-repository-url: 使用svn版本库的URL.
# 如果要从trunk目录或某个branch目录里checkout，就需要把-s换成-T, -b等选项.
# 此命令比较慢，因为它默认同步所有历史版本.

>>> Workflow <<<
#1.开始开发之前，先做一次垃圾收集和压缩，最明显的作用就是减少磁盘空间的占用大小.
git  gc

#2.检查代码库状态
git status

#3.显示当前版本库上的所有分支branch
#svn一般有个远程分支叫做作trunk，和一个本地分支叫做master，master前面有个*号表示当前正处于这个分支.
git branch -a

#4.配置忽略文件列表，让git不对这些文件进行管控，类似svn propset svn:ignore
#忽略的文件，添加到 .git/info/exclude文件当中
#忽略的目录，添加到 .gitignore文件当中.
vim .gitignore
--vim-start-----------
log
tmp
--vim-end-------------

#5.开始开发修改前: 先创建一个新分支
#-b表示创建并切换当前master分支到一个新分支上．尽量保持master分支干净，以便可以创建新的干净的分支
git checkout -b new_branch

#6.开发修改后:
#查看改动的变化
git diff
git difftool

#7.开发修改后：
#如果对某个修改不满意，希望恢复原状
git checkout path/filename
相当于 svn revert

#8.git引入索引(index)机制，提交前，需要把要提交的文件加入到git索引当中,最后才能提交
git add path/filename1
git add path/filename2
git commit -m "提交记录"

#9.提交到svn,要将本地内容提交到远程svn当中，可先让当前分支和远程svn同步
git rebase
#将master分支的本地修改提交到svn
git svn dcommit


EOF

