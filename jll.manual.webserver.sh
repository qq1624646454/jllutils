#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.webserver.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-09-03 10:42:18
#   ModifiedTime: 2020-11-24 11:57:53

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bgreen}${Fblack}                                      ${AC}
${Bgreen}${Fblack} Apache2 Installed Ubuntu 14.04 LTS   ${AC}
${Bgreen}${Fblack}           with access authorization  ${AC}

${Bgreen}${Fblack}1.Configurate the authorized directory @/etc/apache2/apache2.conf ${AC}
<Directory "/usr/local/www">
   Options Indexes FollowSymLinks
   AllowOverride AuthConfig
   Order allow,deny
   Allow from all
</Directory>
${Bgreen}${Fblack}2.Set the authorization rule @/usr/local/www ${AC}
AuthName "passwd, sir!"
AuthType Basic
AuthUserFile /usr/local/share/apache2/.htpasswd
require valid-user

${Bgreen}${Fblack}3.Generate the authorization password @/usr/local/share/apache2 ${AC}
${Bgreen}${Fblack}    Install htpasswd    ${AC}
root@BS# apt search htpasswd
Sorting... Done
Full Text Search... Done
${Fgreen}apache2-utils${AC}/trusty-security,trusty-updates 2.4.7-1ubuntu4.22 amd64
  Apache HTTP Server (utility programs for web servers)

${Fgreen}libapache-htpasswd-perl${AC}/trusty,now 1.8-1.1 all [installed]
  Manage Unix crypt-style password file

${Fgreen}lighttpd${AC}/trusty-security,trusty-updates 1.4.33-1+nmu2ubuntu2.1 amd64
  fast webserver with minimal memory footprint

${Fgreen}nanoweb${AC}/trusty 2.2.9-0ubuntu1 all
  HTTP server written in PHP

root@BS# apt install apache2-utils -y
...
root@BS#

${Bgreen}${Fblack}  htpasswd -c /usr/local/share/apache2/.htpasswd  <UserName> #new accout ${AC}

${Bgreen}${Fblack}  htpasswd -m /usr/local/share/apache2/.htpasswd  <UserName> #modify accout ${AC}

${Bgreen}${Fblack}apache2:Could not reliably determine the server’s fully qualified domain name${AC}
${Fgreen}vim /etc/apache2/apache2.conf${AC} #append the follows:
ServerName localhost:80




${Bgreen}${Fblack}                                                                       ${AC}
${Bgreen}${Fblack} Support zh in html                                                    ${AC}
${Bgreen}${Fblack} <meta http-equiv="Content-Type" content="text/html; charset=utf-8">   ${AC}
${Bgreen}${Fblack}                                                                       ${AC}


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

