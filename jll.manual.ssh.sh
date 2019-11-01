#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ssh.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-06-19 16:57:58
#   ModifiedTime: 2019-11-01 10:14:22

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

root@JllServer:~#
root@JllServer:~# ${Fyellow}ls ~/.ssh${AC}
root@JllServer:~#
root@JllServer:~# ${Fyellow}ssh-keygen -t rsa -b 4096 -C "JLLim@reachxm.com"${AC}
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): ${Fseablue}[Press enter]${AC}
Enter passphrase (empty for no passphrase):  ${Fseablue}[[Type a passphrase]${AC}
Enter same passphrase again: ${Fseablue}[Type a passphrase again]${AC}
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
44:71:d8:3d:be:33:39:1d:b5:ba:b0:f2:a4:cd:f8:68 JLLim@reachxm.com
The key's randomart image is:
+---[RSA 4096]----+
|        o+..     |
|       .... o   .|
|        .  . . ..|
|       .    . .. |
|        S    +.. |
|           .*..  |
|           .o+.  |
|         EB. .   |
|        .++=     |
+-----------------+
root@JllServer:~# ${Fyellow}ls ~/.ssh${AC}
id_rsa  id_rsa.pub
root@JllServer:~#
root@JllServer:~# ${Fyellow}vim ~/.ssh/config${AC}

Host           gerrit29418.reachxm.com
HostName       gerrit.reachxm.com
User           JLLim
Port           29418
IdentityFile    ~/.ssh/id_rsa

root@JllServer:~#
root@JllServer:~# ${Fyellow}ls ~/.ssh${AC}
config  id_rsa  id_rsa.pub
root@JllServer:~#
root@JllServer:~# ${Fgreen}#They are the same for the following two commands over ~/.ssh/config ${AC}
root@JllServer:~# ${Fyellow}ssh -p 29418 JLLim@gerrit.reachxm.com -i ~/.ssh/id_rsa gerrit ls-projects${AC}
All-Projects
All-Users
root@JllServer:~# ${Fyellow}ssh gerrit29418.reachxm.com gerrit ls-projects${AC}
All-Projects
All-Users
root@JllServer:~#

EOF

