#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

-----------------------------------------------------
Property    Account:          E-Mail
-----------------------------------------------------
 Copyright   x13015851932      lin_jie_long@126.com
 Free        linjielong2009    493164984@qq.com  
 Free        qq1624646454      1624646454@qq.com

-----------------------------------------------------





-----------------------------------------------------
.jllrepoconf
  this file will be sourced and used by jll.repo.sh
  in order to handle all git repositories sync or 
  other operations registed in Environment
  GitRepositoryTable 
-----------------------------------------------------
#!/bin/bash
#copyright(c) 2016-2100, jielong_lin, All rights reserved.
declare -a GitRepositoryTable=(
    "git@code.csdn.net:x13015851932/jllutils.git"
    "git@code.csdn.net:x13015851932/jllserver.git"
    "git@code.csdn.net:x13015851932/vicc.git"
    "git@code.csdn.net:x13015851932/microsoftutils.git"
    "git@code.csdn.net:x13015851932/networkvpn.git"
    "git@code.csdn.net:x13015851932/virtualization.git"
    "git@code.csdn.net:x13015851932/studybooks.git"
    "git@code.csdn.net:x13015851932/joyfulputty.git"
    "git@code.csdn.net:x13015851932/jllcodelibrary.git"
    "git@code.csdn.net:x13015851932/2k16-dream-idea.git"
    "git@code.csdn.net:x13015851932/philipstv_csdn.git"
    "git@code.csdn.net:x13015851932/jllrepository.git"
)









>>>>>>> GIT USAGE <<<<<<<

git-pull - Fetch from and merge with another repository or a local branch
           从另一个仓库或本地分支获取并合并
           jll: 从远程仓库或本地的另一个分支获取最新的信息到本地当前分支
     SYNOPSIS
           git pull [options] [<repository> [<refspec>...]]

           git pull origin master
           本地分支是master
           远程分支是origin

git-push - Update remote refs along with associated objects
           远程引用和相关对象一起同步
           jll: 将本地当前分支的最新信息同步到远程仓库
      SYNOPSIS
           git push [--all | --mirror | --tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
                  [--repo=<repository>] [-f | --force] [-v | --verbose] [-u | --set-upstream]
                  [<repository> [<refspec>...]]


           git push -u origin master
           本地分支master,远程仓库是origin
           -u的含义:一般只有同时存在多个远程仓库时才会用到-u,即--set-upstream.每个git branch可以有个对应的upstream.
           假设你有两个upstream,分别叫作server1和server2,本地master branch的upstream是server1上的master,那么当你不带
           参数直接输入git pull或git push时,默认是对server1进行pull/push.如果你成功地运行"git push -u server2 master",
           那么除了本地brach会被push到server2之外,还会把server2设置成upstream.

=================================================

1. 生成公钥
 
首先检查本机公钥：
 $ cd ~/.ssh
 
如果提示：No such file or directory 说明你是第一次使用git。如果不是第一次使用，请执行下面的操作,清理原有ssh密钥。
 $ mkdir key_backup
$ cp id_rsa* key_backup
$ rm id_rsa*
 
生成新的密钥：
 $ ssh-keygen -t rsa -C “您的邮箱地址”
 
在回车中会提示你输入一个密码，这个密码会在你提交项目时使用，如果为空的话提交项目时则不用输入。
 
您可以在你本机系统盘下，您的用户文件夹里发现一个.ssh文件，其中的id_rsa.pub文件里储存的即为刚刚生成的ssh密钥。
 
2. 添加公钥
 
登录CODE平台，进入用户“账户设置”，点击右侧栏的“ssh公钥管理”，点击“添加公钥”，将刚刚生成的公钥填写到“公钥”栏，并为它起一个名称，保存即可。
 
注意：复制公钥时不要复制多余的空格，否则可能添加不成功。



------------------------------

初始化项目设置向导
 
Git设置： 
git config --global user.name "Your Name Here"

# 如果已有设置，不设置也可以! 
# 设置Git提交时的默认用户名，推荐使用本站用户名 UserAccount：
 

git config --global user.email "your_email@example.com"
 
# 如果已有设置，不设置也可以! 
# 设置Git提交时的默认邮箱，推荐使用本站注册邮箱：lin_jie_long@126.com
 
初始化为仅包含空README.MD文件的空项目： 
touch README.md
 
git init
 
git add README.md
 
git commit -m "first commit"
 
git remote add origin git@code.csdn.net:UserAccount/xxx.git
 
git push -u origin master
 
用已经存在的项目初始化项目： 
git remote add origin git@code.csdn.net:UserAccount/xxx.git
 
git push -u origin master


--------------------------------------------
# Initialize the csdn git resposity environment
 ./to_csdn.sh

# Delete a file in local and remote resposities:
 git rm -f README.md
 git status
 git status -s
 git commit -m "delete README.md
 git push origin master

# Sync the local with remote
 git push -u origin master


# submit the changed files to local and remote resposities:
 git status -s
 git add -A
 git commit -m "YOUR Log"
 git push origin master

Enter passphrase for key '/home/jielong.lin/.ssh/id_rsa':
password is " jllXXXX "





EOF

