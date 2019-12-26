#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ftp.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-07-17 15:38:33
#   ModifiedTime: 2019-12-26 15:05:37

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

root@REACHXM82:/ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor# ftp
ftp> help lcd
lcd             change local working directory
ftp> help binary
binary          set binary transfer type
ftp> help mput
mput            send multiple files
ftp> help mget
mget            get multiple files
ftp> help bye
bye             terminate ftp session and exit
ftp>
ftp> bye
root@REACHXM82:/ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor#

##
## ftp upload  without interact
##
root@REACHXM82:/ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor#
root@REACHXM82:/ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor# ftp -i -n <<!
> open ftp.reachxm.com
> user linjielong ib***e
> cd /img/L170L/uvrm2m.com/
> lcd /ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor
> binary
> mput readme
> bye
> !
Local directory now /ibbyte1024MB/projects/gerrit.reachxm.com/L170L/uvrm2m.com/apps_proc/vendor

######## Upload file for example, noted it only can be file rather than folder #######################
# upload QMSCT_L170HQA2.4K_Wisec.1_Q2.0_R0.0.a0_R20191226.0.zip to ftp.reachxm.com/img/QA/L170H/
# from /ibbyte512MB/projects/svn/Mangov2/branches/L170HQL2_Wisec.1/images_by_reachxm/L170HQL2.4K_Wisec.1_Q2.0_R0.0.a0_20191226.13_D/FactoryImage
ftp -i -n <<!
open ftp.reachxm.com
user linjielong ibbyte
cd /img/QA/L170H/
lcd /ibbyte512MB/projects/svn/Mangov2/branches/L170HQL2_Wisec.1/images_by_reachxm/L170HQL2.4K_Wisec.1_Q2.0_R0.0.a0_20191226.13_D/FactoryImage
binary
mput QMSCT_L170HQA2.4K_Wisec.1_Q2.0_R0.0.a0_R20191226.0.zip
bye
!




wget -nH  -m  --restrict-file-names=nocontrol --ftp-user=linjielong --ftp-password=ib***e ftp://ftp.reachxm.com/open/RD/

EOF


echo -e "root@S:.# \033[31mftp ftp.reachxm.com\033[0m"
more >&1<<EOF
Connected to ftp.reachxm.com.
220 Serv-U FTP Server v15.1 ready...
EOF
echo -e "Name (ftp.reachxm.com:root): \033[31msale\033[0m"
more >&1<<EOF
331 User name okay, need password.
EOF
echo -e "Password: \033[31mYOUR_PASSWORD\033[0m"
more >&1<<EOF
230 User logged in, proceed.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp>
EOF

echo -e "ftp> \033[31m!ls\033[0m"
echo -e "ftp> \033[31mls\033[0m"
more >&1<<EOF
200 PORT command successful.
150 Opening ASCII mode data connection for /bin/ls.
drwxrwxrwx   1 user     group           0 Jul 17 14:25 nanjingtianze
226 Transfer complete. 70 bytes transferred. 0.07 KB/sec.
EOF
echo -e "ftp> \033[31mcd nanjingtianze\033[0m"
more >&1<<EOF
250 Directory changed to /nanjingtianze
EOF
echo -e "ftp> \033[31mls\033[0m"
more >&1<<EOF
200 PORT command successful.
150 Opening ASCII mode data connection for /bin/ls.
drwxrwxrwx   1 user     group           0 Jul 17 14:25 .
drwxrwxrwx   1 user     group           0 Jul 17 14:25 ..
-rw-rw-rw-   1 user     group    14660528 May 31 11:03 HardwareData.rar
-rw-rw-rw-   1 user     group    2567225908 May 31 16:10 SoftwareData.zip
226 Transfer complete. 265 bytes transferred. 0.26 KB/sec.
EOF
echo -e "ftp> \033[31mget SoftwareData.zip\033[0m"
more >&1<<EOF
local: SoftwareData.zip remote: SoftwareData.zip
200 PORT command successful.
150 Opening BINARY mode data connection for SoftwareData.zip (2567225908 Bytes).
226 Transfer complete. 2,567,225,908 bytes transferred. 11,493.93 KB/sec.
2567225908 bytes received in 218.31 secs (11483.7 kB/s)
ftp> 
EOF
