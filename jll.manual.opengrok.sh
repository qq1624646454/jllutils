#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.opengrok.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-19 22:49:52
#   ModifiedTime: 2020-12-20 23:10:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

# opengrok-1.15.11
# 
# JDK 11+
# Tomcat8
#

#1.install jdk 11+
tar -zvxf jdk-11.0.9_linux-x64_bin.tar.gz -C /usr/share/java/

/usr/share/java/jdk-11.0.9/bin/jlink --module-path jmods --add-modules java.desktop --output /usr/share/java/jdk-11.0.9/jre

#2.install tomcat8
tar -zvxf apache-tomcat-8.5.60.tar.gz -C /usr/share/

vim /usr/share/apache-tomcat-8.5.60/bin/startup.sh
  ...
+ JAVA_HOME=/usr/share/java/jdk-11.0.9/bin/java
+ JRE_HOME=\${JAVA_HOME}/jre
+ PATH=\${JAVA_HOME}/bin:\${PATH}
+ TOMCAT_HOME=/usr/share/apache-tomcat-8.5.60

  exec "\$PRGDIR"/"\$EXECUTABLE" start "\$@"

vim /usr/share/apache-tomcat-8.5.60/bin/shutdown.sh
  ...
+ JAVA_HOME=/usr/share/java/jdk-11.0.9/bin/java
+ JRE_HOME=\${JAVA_HOME}/jre
+ PATH=\${JAVA_HOME}/bin:\${PATH}
+ TOMCAT_HOME=/usr/share/apache-tomcat-8.5.60

  exec "\$PRGDIR"/"\$EXECUTABLE" stop -force "\$@"

vim /etc/init.d/tomcat8
  DESC="web server"
  NAME=tomcat8

  case "\$1" in
    start)
      #log_daemon_msg "Starting \$DESC" "\$NAME"
      if [ -e /usr/share/apache-tomcat-8.5.60/bin/startup.sh ]; then
          /usr/share/apache-tomcat-8.5.60/bin/startup.sh
      fi
      ;;
    stop|graceful-stop)
      #log_daemon_msg "Stopping \$DESC" "\$NAME"
      if [ -e /usr/share/apache-tomcat-8.5.60/bin/shutdown.sh ]; then
        /usr/share/apache-tomcat-8.5.60/bin/shutdown.sh
      fi
      ;;
    status)
      ;;  
    reload|force-reload|graceful)
      ;;  
    restart)
      if [ -e /usr/share/apache-tomcat-8.5.60/bin/shutdown.sh ]; then
        /usr/share/apache-tomcat-8.5.60/bin/shutdown.sh
      fi
      if [ -e /usr/share/apache-tomcat-8.5.60/bin/startup.sh ]; then
        /usr/share/apache-tomcat-8.5.60/bin/startup.sh
      fi
      ;;
  esac

  exit 0

update-rc.d tomcat8 defaults


#3.install universal_ctags and opengrok
wget https://github.com/oracle/opengrok/releases/download/1.5.11/opengrok-1.5.11.tar.gz
tar -zvxf opengrok-1.5.11.tar.gz -C /usr/share/ 
cd /user/share/opengrok-1.5.11

apt-get install -y automake autoconf
cd ctags/
./autogen.sh
./configure
make
make install
/usr/local/bin/ctags --version
cd - 2>/dev/null

cd /user/share/opengrok-1.5.11/tools/
python3 -m pip install opengrok_tools.tar.gz

#4.environment for every project

export OPENGROK_APP_SERVER=Tomcat

#Specify the source.war target directory, namely \${OPENGROK_DISTRIBUTION_BASE}/source.war
export OPENGROK_DISTRIBUTION_BASE=\${PROJECT_TOPDIR}/opengrok-dist/lib

export OPENGROK_WEBAPP_CONTEXT=/\${PROJECT_NAME}

#
#--- Begin of either 1 or 2 to select ---
#
#1.specify the path to webapps, such as PATH-TO/webapps
export OPENGROK_WAR_TARGET_TOMCAT=
export OPENGROK_WAR_TARGET=
#2.specified the path to the parent of webapps
export OPENGROK_TOMCAT_BASE=\${TOMCAT_BASE}
#--- End of either 1 or 2 to select ---


export OPENGROK_WEBAPP_CFGADDR=http://localhost:\${TOMCAT_PORT}\${OPENGROK_WEBAPP_CONTEXT}

export OPENGROK_INSTANCE_BASE=\${PROJECT_TOPDIR}\${OPENGROK_WEBAPP_CONTEXT}

export OPENGROK_SRC_ROOT=\${OPENGROK_INSTANCE_BASE}/src

export OPENGROK_DATA_ROOT=\${OPENGROK_INSTANCE_BASE}/data

export OPENGROK_CTAGS=/usr/local/bin/ctags

export OPENGROK_RENAMED_FILES_HISTORY=on
export OPENGROK_VERBOSE=true
export OPENGROK_PROGRESS=true
export OPENGROK_FLUSH_RAM_BUFFER_SIZE="-m 512"
export OPENGROK_IGNORE_PATTERNS="-i f:.gitignore -i f:.gitattributes -i f:.travis.yml -i d:git-repo"
alias  jllim-opengrok="\${OPENGROK_DISTRIBUTION_BASE}/../bin/OpenGrok"
export jllim_opengrok="\${OPENGROK_DISTRIBUTION_BASE}/../bin/OpenGrok"



EOF

