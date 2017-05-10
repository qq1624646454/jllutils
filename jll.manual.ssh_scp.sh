#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

cat >&1 << EOF


###########################################
#   SSH
###########################################
(1).Debug ssh session detail
YourSystem:~$ ssh -vvv test@192.168.1.10
(2).Ping and Telnet successfully, but ssh signing failure
Should check if the MTU of the specified network interface
such as tun device, its default by 1400, but some sign failure
due to its MTU is too big, and change it to 1200 so that sign
successfully.
(3).Can't signing in by root
Please change "PermitRootLogin without-password" to "PermitRootLogin yes"
in /etc/ssh/sshd_config or /etc/ssh/ssh_config


###########################################
#   SCP
###########################################
              ---->
scp -r [Source]  [Target]

[Source] or [Target]
    USER@IP:PATH 



======================================
winscp: can't signing in by root
--------------------------------------
vim /etc/ssh/sshd_config
# Authentication:
...
PermitRootLogin yes #PermitRootLogin without-password
...

EOF


