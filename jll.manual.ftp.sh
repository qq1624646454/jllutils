#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ftp.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-07-17 15:38:33
#   ModifiedTime: 2019-08-15 14:21:23

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

wget -nH -m -–restrict-file-names=nocontrol --ftp-user=reach --ftp-password=reach2019 ftp://ftp.reachxm.com/open/RD/

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
