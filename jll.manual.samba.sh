#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.samba.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-02 14:39:02
#   ModifiedTime: 2018-11-25 11:01:36

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}${Fblack} For Ubuntu 12.04, 14.04 ${AC}
root@S# ${Fseablue} aptitude install samba ${AC}

root@S# ${Fseablue} smbpasswd -a YOUR_ACCOUNT_USERNAME ${AC}

root@S# ${Fseablue} vim /etc/samba/smb.conf ${AC}
...
244 # Un-comment the following (and tweak the other settings below to suit)
245 # to enable the default home directory shares. This will share each
246 # user's home director as \\server\username
247 ${Fgreen}[homes]${AC}
248 ${Fgreen}   comment = Home Directories${AC}
249 ${Fgreen}   browseable = yes${AC}
...
252 # next parameter to 'no' if you want to be able to write to them.
253 ${Fgreen}   read only = no${AC}
...
256 # create files with group=rw permissions, set next parameter to 0775.
257 ${Fgreen}   create mask = 0700${AC}
...
260 # create dirs. with group=rw permissions, set next parameter to 0775.
261 ${Fgreen}   directory mask = 0700${AC}
...
268 # This might need tweaking when using external authentication schemes
269 ${Fgreen}   valid users = %S${AC}
270
271 ${Fgreen}# Disable show all files started with .${AC}
272 ${Fgreen}   veto files=/.*/${AC}
273
...
root@S# ${Fseablue} service smbd restart${AC}

${Fred} IF Error message is 'stop: Unknown instance:' when service smbd stop${AC}
${Fred} Please check your configurate file '/etc/samba/smb.conf'${AC}


${Bred}                                       ${AC}
${Bred}${Fyellow} Another configure is as follows       ${AC}
${Bred}                                       ${AC}
[jllim]
  comment = jllim for windows7
  path = /root/Desktop
  browseable = yes
  read only = no
  create mask = 0700
  directory mask = 0700
  valid users = root 
  veto files = /.*/

${Fred}Suggestion: install winbind for using hostname to replace ip ${AC}
${Fred}apt-get install winbind${AC}
${Fred}cp -rvf /etc/nsswitch.conf /etc/nsswitch.conf.orig${AC}
${Fred}vim /etc/nsswitch.conf${AC}
...
hosts:   files mdns4_minimal [NOTFOUND=return] dns ${Fred}wins${AC}
...
${Fred}hostname${AC}
ubuntu

${Fred}open link as \\\\ubuntu\\jllim ${AC}


${Fred}How to remove and purge samba${AC}
 aptitude purge samba
 aptitude search samba
 dpkg --configure --pending
 apt-get remove samba
 dpkg -P samba samba-common samba-common-bin samba-dsdb-modules samba-liba samba-vfs-modules


${Fred} vim /var/log/samba/log.smbd ${AC}
${Fred} Unable to connect to CUPS server localhost:631 - Bad file descriptor ${AC}
 Please add the below configuration before Share Definitions in /etc/samba/smb.conf
185
186 printing = bsd
187 printcap name = /dev/null
188
189 #======================= Share Definitions ======================= 



${Fred} IF login failure, please check the share fold from /etc/samba/smb.conf ${AC}

EOF

