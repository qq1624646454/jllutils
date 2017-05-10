#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.github.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-12 09:24:44
#   ModifiedTime: 2017-05-10 20:22:49

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1 <<EOF


=============================================================================================
github project to use or developping

  How to select HTTPS or SSH for Clone or Download, such as:
      https://github.com/qq1624646454/jllutils.git
      git@github.com:qq1624646454/jllutils.git
  ----------------------------------------------------------------------------------------
  | (1).Using https without providing any user-name and user-password or ~/.ssh/id_rsa.  |
  |     But in further, any change is submitted to github are required by user-name and  | 
  |     user-password.                                                                   |
  | (2).Using ssh with providing ~/.ssh/id_rsa, maybe and the password associated with   |
  |     ~/.ssh/id_rsa. This case is mostly for developer.                                |
  ---------------------------------------------------------------------------------------- 

SUGGESTION FOR jielong.lin which is a common user and then is also a developer

  1).Using https to download the project:

jielong.lin@TpvServer:~/github$ git clone https://github.com/qq1624646454/jllutils.git
Cloning into 'jllutils'...
remote: Counting objects: 203, done.
remote: Compressing objects: 100% (164/164), done.
remote: Total 203 (delta 37), reused 203 (delta 37), pack-reused 0
Receiving objects: 100% (203/203), 5.31 MiB | 1.46 MiB/s, done.
Resolving deltas: 100% (37/37), done.


  2).Change .git for push over ssh, namely using ~/.ssh/id_rsa
jielong.lin@TpvServer:~/github$ cd jllutils
jielong.lin@TpvServer:~/github/jllutils$
jielong.lin@TpvServer:~/github/jllutils$ git remote show
origin
jielong.lin@TpvServer:~/github/jllutils$
jielong.lin@TpvServer:~/github/jllutils$
jielong.lin@TpvServer:~/github/jllutils$ git remote show origin
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

jielong.lin@TpvServer:~/github/jllutils$
jielong.lin@TpvServer:~/github/jllutils$ ./jll.sshconf.sh
  <Or git remote set-url --push origin YOUR_GIT_URL>
  ...

  3).Now commit your change by 'git push -u origin master' will use SSH with ~/.ssh/id_rsa







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

