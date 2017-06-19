#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ssh.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-06-19 16:57:58
#   ModifiedTime: 2017-06-19 17:01:14

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

root@JllServer:~#
root@JllServer:~# ${Fyellow}ls ~/.ssh${AC}
root@JllServer:~#
root@JllServer:~# ${Fyellow}ssh-keygen -t rsa -b 4096 -C "jielong.lin@qq.com"${AC}
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): ${Fseablue}[Press enter]${AC}
Enter passphrase (empty for no passphrase):  ${Fseablue}[[Type a passphrase]${AC}
Enter same passphrase again: ${Fseablue}[Type a passphrase again]${AC}
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
44:71:d8:3d:be:33:39:1d:b5:ba:b0:f2:a4:cd:f8:68 jielong.lin@qq.com
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

EOF

