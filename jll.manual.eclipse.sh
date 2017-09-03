#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.eclipse.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-09-03 16:14:29
#   ModifiedTime: 2017-09-03 17:41:54

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}${Fblack}                                                           ${AC}
${Bgreen}${Fblack}  ${AC} Install and Setup Eclipse EE
${Bgreen}${Fblack}                                                           ${AC}


${Fseablue}wget -c -t0 -T3 http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/helios/SR2/eclipse-jee-helios-SR2-linux-gtk-x86_64.tar.gz${AC}

${Fseablue}mv download.php\?file\=%2Ftechnology%2Fepp%2Fdownloads%2Frelease%2Fhelios%2FSR2%2Feclipse-jee-helios-SR2-linux-gtk-x86_64.tar.gz  eclipse-jee-helios-SR2-linux-gtk-x86_64.tar.gz${AC}

${Fseablue}mkdir -pv /fight4honor/eclipse${AC}
${Fseablue}tar -zvxf eclipse-jee-helios-SR2-linux-gtk-x86_64.tar.gz -C /fight4honor/eclipse${AC}
${Fseablue}cd /fight4honor/eclipse/eclipse-jee-helios-SR2-linux-gtk-x86_64${AC}


${Fseablue}mkdir -pv /fight4honor/eclipse/jdk; cd /fight4honor/eclipse/jdk${AC}
${Fgreen}Downloading jdk-8u144-linux-x64.tar.gz from the below linker:${AC}
    http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
${Fseablue}tar -zxvf jdk-8u144-linux-x64.tar.gz${AC}

${Fseablue}aptitude install tomcat7${AC}

EOF

