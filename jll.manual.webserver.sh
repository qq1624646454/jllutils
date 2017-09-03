#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.webserver.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-09-03 10:42:18
#   ModifiedTime: 2017-09-03 10:46:23

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bgreen}${Fblack} Debian 8.3 apache2 ${AC}
${Fseablue}vim /etc/apache2/conf-enabled/eclipse.conf${AC} 
Alias /eclipse  /fight4honor/eclipse/eclipse-jee-helios-SR2-linux-gtk-x86_64/eclipse

<Directory /fight4honor/eclipse/eclipse-jee-helios-SR2-linux-gtk-x86_64/eclipse>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
	Require all granted
</Directory>

${Fseablue}service apache2 restart${AC}
${Fseablue}w3m http://127.0.0.1/eclipse${AC}

EOF

