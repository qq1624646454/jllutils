#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.tomcat.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-07 12:43:03
#   ModifiedTime: 2020-12-07 12:58:55

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

add-apt-repository ppa:openjdk-r/ppa
apt-get update
aptitude search jdk
apt-get install -y openjdk-8-jdk
update-alternatives --config java
update-alternatives --config javac
java -version

wget https://mirrors.bfsu.edu.cn/apache/tomcat/tomcat-8/v8.5.60/bin/apache-tomcat-8.5.60.tar.gz

tar -zvxf apache-tomcat-8.5.60.tar.gz -C /usr/lib/
vim /usr/lib/apache-tomcat-8.5.60/bin/startup.sh
 ...
 60 #JLLim.S reach 20201207
 61 JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
 62 JRE_HOME=\${JAVA_HOME}/jre
 63 PATH=\${JAVA_HOME}/bin:\${PATH}
 64 CLASSPATH=.:\${JAVA_HOME}/lib/dt.jar:\${JAVA_HOME}/lib/tools.jar
 65 TOMCAT_HOME=/usr/lib/apache-tomcat-8.5.60
 66 #JLLim.E reach 20201207
 67
 68 exec "\$PRGDIR"/"\$EXECUTABLE" start "\$@"

#Startup manual 
/usr/lib/apache-tomcat-8.5.60/bin/startup.sh #call catalina.sh

#Startup by service
ln -sv /usr/lib/apache-tomcat-8.5.60/bin/catalina.sh /etc/init.d/tomcat8
service tomcat8 start
service tomcat8 stop

#Testing
web-browser open: 127.0.0.1:8080



EOF

