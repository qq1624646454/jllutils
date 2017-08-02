#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.samba.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-02 14:39:02
#   ModifiedTime: 2017-08-02 14:43:39

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}${Fblack} For Ubuntu 12.04 ${AC}
root@S# ${Fseablue} aptitude install samba ${AC}

root@S# ${Fseablue} vim /etc/samba/smb.conf ${AC}
...
244 # Un-comment the following (and tweak the other settings below to suit)
245 # to enable the default home directory shares. This will share each
246 # user's home director as \\server\username
247 ${Fgreen}[homes]${AC}
248 ${Fgreen}   comment = Home Directories${AC}
249 ${Fgreen}   browseable = yes${AC}
250
...
256 # create files with group=rw permissions, set next parameter to 0775.
257 ${Fgreen}   create mask = 0700${AC}
...
260 # create dirs. with group=rw permissions, set next parameter to 0775.
261 ${Fgreen}   directory mask = 0700${AC}
...
268 # This might need tweaking when using external authentication schemes
269 ${Fgreen}   valid users = %S${AC}
...

root@S# ${Fseablue} service smbd restart${AC}


${Fred} IF Error message is 'stop: Unknown instance:' when service smbd stop${AC}
${Fred} Please check your configurate file '/etc/samba/smb.conf'${AC}


EOF

