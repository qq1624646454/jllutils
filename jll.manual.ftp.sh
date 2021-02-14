#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ftp.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-07-17 15:38:33
#   ModifiedTime: 2020-03-10 01:06:41

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


root@ibbyte:~# lftp -u linjielong,i****e ftp.reachxm.com
lftp linjielong@ftp.reachxm.com:~> set ftp:use-feat no; set ftp:ssl-allow no; 
lftp linjielong@ftp.reachxm.com:~> ls
drwxrwxrwx   1 user     group           0 Mar  3 23:44 img
drwxrwxrwx   1 user     group           0 Dec 27 16:14 open
lftp linjielong@ftp.reachxm.com:/>




##
## Download test.txt to current local path from ftp.reachxm.com/open/RD/test.txt 
##
wget -nH  -m  --restrict-file-names=nocontrol --ftp-user=linjielong --ftp-password=ib***e ftp://ftp.reachxm.com/open/RD/test.txt


##
## Upload NON-HLOS.ubi to ftp.reachxm.com/img/QA/L170H/ without interact from current local path
##
ftp -i -n <<!
open ftp.reachxm.com
user linjielong  ib***e
cd /img/QA/L170H/
lcd ./
binary
mput NON-HLOS.ubi
bye
!




root@REACHXM82:.# ftp
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
root@REACHXM82:.#

##
## ftp upload  without interact
##
root@REACHXM82:.#
root@REACHXM82:.# ftp -i -n <<!
> open ftp.reachxm.com
> user linjielong ib***e
> cd /img/L170L/
> lcd ~/vendor
> binary
> mput readme
> bye
> !
Local directory now ~/vendor

######## Upload file for example, noted it only can be file rather than folder #######################
# upload QMSCT_L170HQA2.4K_Wisec.1_Q2.0_R0.0.a0_R20191226.0.zip to ftp.reachxm.com/img/QA/L170H/ from ~/FactoryImage
ftp -i -n <<!
open ftp.reachxm.com
user linjielong i****e
cd /img/QA/L170H/
lcd ~/FactoryImage
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
