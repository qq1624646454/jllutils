#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.github.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-12 09:24:44
#   ModifiedTime: 2017-11-25 20:09:09

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


more >&1 <<EOF

All projects for qq1624646454 and linjielong
    update @2017-11-25
=============================================================================================

  git@github.com:qq1624646454/jllutils.git
  https://github.com/qq1624646454/jllutils.git

  git@github.com:qq1624646454/vicc_installer.git
  git@github.com:qq1624646454/JoyfulPuTTY.git 
  git@github.com:qq1624646454/vpn_n2n.git

    git@github.com:qq1624646454/philipstv_tpv.git
    git@github.com:qq1624646454/music_sheet_guitar.git
    git@github.com:qq1624646454/software_for_win7.git
    git@github.com:qq1624646454/programming_study.git
    git@github.com:qq1624646454/StudyStudio.git
    git@github.com:qq1624646454/players.git


  git@github.com:linjielong/linux.git

    git@github.com:linjielong/git_repository_utils4win32.git
    git@github.com:linjielong/codes4jll.git
    git@github.com:linjielong/PreStudyNews.git
    git@github.com:linjielong/CodeFlowchart4RelaxBrainpower.git
    git@github.com:linjielong/iDSS.git




=============================================================================================
github project to use or developping

${Fseablue} How to select HTTPS or SSH for Clone or Download, such as:${AC}
${Fseablue}      https://github.com/qq1624646454/jllutils.git ${AC}
${Fseablue}      git@github.com:qq1624646454/jllutils.git ${AC}
${Fseablue}  -------------------------------------------------------------------------- ${AC}
${Fseablue}  | (1).Using https without providing any user-name and user-password or   | ${AC}
${Fseablue}  |     ~/.ssh/id_rsa. But in further, any change is submitted to github   | ${AC}
${Fseablue}  |     are required by user-name and user-password.                       | ${AC}
${Fseablue}  | (2).Using ssh with providing ~/.ssh/id_rsa, maybe and the password     | ${AC}
${Fseablue}  |     associated with ~/.ssh/id_rsa. This case is mostly for developer.  | ${AC}
${Fseablue}  -------------------------------------------------------------------------- ${AC}

SUGGESTION FOR jielong.lin which is a common user and then is also a developer

1).Using https to download the project:
${Fyellow}jl@S:~/github$ git clone https://github.com/qq1624646454/jllutils.git${AC}
Cloning into 'jllutils'...
remote: Counting objects: 203, done.
remote: Compressing objects: 100% (164/164), done.
remote: Total 203 (delta 37), reused 203 (delta 37), pack-reused 0
Receiving objects: 100% (203/203), 5.31 MiB | 1.46 MiB/s, done.
Resolving deltas: 100% (37/37), done.

2).Change .git for push over ssh, namely using ~/.ssh/id_rsa
jl@S:~/github$ ${Fyellow}cd jllutils${AC}
jl@S:~/github/jllutils$
jl@S:~/github/jllutils$ ${Fyellow}git remote show${AC}
origin
jl@S:~/github/jllutils$
jl@S:~/github/jllutils$
jl@S:~/github/jllutils$ ${Fyellow}git remote show origin${AC}
* remote origin
  Fetch URL: https://github.com/qq1624646454/jllutils.git
  Push  URL: https://github.com/qq1624646454/jllutils.git
  HEAD branch: master
  Remote branch:
    master tracked
  Local branch configured for 'git pull':
    master merges with remote master
  Local ref configured for 'git push':
    master pushes to master (up to date)

jl@S:~/github/jllutils$
jl@S:~/github/jllutils$ ${Fyellow}./jll.sshconf.sh${AC}
  ...<Or ${Fgreen}git remote set-url --push origin YOUR_GIT_URL${AC}>

3).Now commit your change by 'git push -u origin master' will use SSH with ~/.ssh/id_rsa



${Fseablue}=============================================================================== ${AC}

   |                      |                   |
   |---------commit -a --------------------->|_|
   |                      |                   |
   |----- add (-u)a ---->|_|----- commit --->|_|
   |                      |                   |
   |                      |                   |------- push --->|_|
   |                      |                   |                  |
.............         ...............   ..............      ..............
. workspace .         . index/stage .   .  local     .      .  remote    .
.           .         .             .   . repository .      . repository .
.............         ...............   ..............      ..............
   |                      |                   |                  |
  |_|<---------------------- pull or rebase ---------------------|
   |                      |                   |                  |
   |                      |                  |_|<--- fetch ------| 
  |_|<---- checkout HEAD ---------------------|
   |                      |                   |              
  |_|<---- checkout ------|                   |
   |                      |                   |
   |-------- diff HEAD -----------------------|
   |--- diff -------------|                   |
   |                      |                   |


${Fseablue}====================================================================${AC}
${Fseablue}  没有解决，建议重新建立项目 (注意今后提交的文件不要超过50M) ${AC}
${Fseablue}  ---------------------------------------------------------- ${AC}
${Fseablue}  |  The Books folder which contains the large files have  | ${AC}
${Fseablue}  |  been removed. The Error will be met when any changes  | ${AC}
${Fseablue}  |  are committed by git push                             | ${AC}
${Fseablue}  ---------------------------------------------------------- ${AC}
...
Compressing objects: 100% (27/27), done.
Writing objects: 100% (27/27), 399.01 MiB | 2.98 MiB/s, done.
Total 27 (delta 8), reused 0 (delta 0)
remote: Resolving deltas: 100% (8/8), completed with 1 local object.
remote: warning: File Books/Head First Java(中文版).pdf is 57.15 MB; this is larger than GitHub's recomm
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs
remote: error: Trace: 9ca0db6112b313bc03dcdda2f206cfa0
remote: error: See http://git.io/iEPt8g for more information.
remote: error: File Books/深入理解Android(卷2).pdf is 175.20 MB; this exceeds GitHub's file size limit o
remote: error: File Books/深度探索Linux操作系统 系统构建和原理解析.pdf is 168.25 MB; this exceeds GitHub
To git@github.com:qq1624646454/philipstv_tpv.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'git@github.com:qq1624646454/philipstv_tpv.git'
jielong.lin@TpvServer:~/github/philipstv_tpv$
jielong.lin@TpvServer:~/github/philipstv_tpv$
${Fyellow}---------------------------${AC}
${Fyellow}分析：${AC}
${Fyellow}    超过50M的文件，提交时会被警告，而超过100M的文件，会被拒绝提交 ${AC}

${Fgreen}(1).查看.git大小,它确实挺大的, index/stage可能很大，包含了超过50MB文件和超过100MB文件${AC}
jl@S:~/github/philipstv_tpv$ ${Fgreen}du -h -d 1 ${AC}
575M    ./.git
117M    ./DRM_OpenSource
767M    .
${Fgreen}(2).查看workspace和index/stage状态：${AC}





==========================================================================================
GitHub is only free to support for the public project, 
so I only release some final projects into GitHub.

Usage: create a new repository on the command line
    echo "# vicc" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git remote add origin git@github.com:qq1624646454/vicc.git
    git push -u origin master

Usage: push an existing repository from the command line
    git remote add origin git@github.com:qq1624646454/vicc.git
    git push -u origin master



>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   vicc - release platform
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    git clone git@github.com:qq1624646454/vicc.git




>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   vicc_installer - release platform
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    git clone git@github.com:qq1624646454/vicc_installer.git





EOF

