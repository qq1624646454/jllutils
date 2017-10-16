#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.webserver.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-09-03 10:42:18
#   ModifiedTime: 2017-10-16 16:33:08

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bgreen}${Fblack}                                      ${AC}
${Bgreen}${Fblack} Tomcat7 Installed Ubuntu 12.04.5 LTS ${AC}
${Bgreen}${Fblack}                                      ${AC}

 java -version
 ${Fseablue}java version "1.7.0_121"${AC}
 ${Fseablue}OpenJDK Runtime Environment (IcedTea 2.6.8) (7u121-2.6.8-1ubuntu0.12.04.3)${AC}
 ${Fseablue}OpenJDK 64-Bit Server VM (build 24.121-b00, mixed mode)${AC}

 echo \$JAVA_HOME
 ${Fseablue}/usr/lib/jvm/java-7-openjdk-amd64${AC}
 echo \$JRE_HOME
 ${Fseablue}/usr/lib/jvm/java-7-openjdk-amd64/jre${AC}
 echo \$CLASSPATH
 ${Fseablue}.:/usr/lib/jvm/java-7-openjdk-amd64/lib:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib${AC}

 sudo aptitude search tomcat
 sudo aptitude install tomcat7
 sudo aptitude install tomcat7-admin
 sudo aptitude install tomcat7-docs
 sudo aptitude install tomcat7-examples

 Tomcat7 was installed in the under path:
     /usr/share/

 service --status-all
 ${Fseablue} ... ${AC}
 ${Fseablue} [ - ]  tomcat7 ${AC}
 ${Fseablue} ... ${AC}


 ${Fseablue}FOR localhost${AC}
 w3m http://127.0.0.1:8080   

 ${Fseablue}FOR otherhost${AC}
 w3m http://172.20.30.29:8080 
 or using web browser to open URL=http://172.20.30.29:8080

 sudo service tomcat7 start
 sudo service tomcat7 stop



${Bgreen}${Fblack}                    ${AC}
${Bgreen}${Fblack} Debian 8.3 apache2 ${AC}
${Bgreen}${Fblack}                    ${AC}

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

