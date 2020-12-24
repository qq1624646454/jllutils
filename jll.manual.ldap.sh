#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ldap.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-23 19:44:07
#   ModifiedTime: 2020-12-24 21:56:13

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bred}${Fseablue}                                       ${AC}
${Bred}${Fseablue} Environment                           ${AC}
${Bred}${Fseablue}                                       ${AC}
https://segmentfault.com/a/1190000002607130?utm_source=sf-related

System   - ubuntu: 14.04 x86_64 ( /usr/share/BerkeleyDB, /usr/share/OpenLDAP )
OpenLDAP - slapd: 2.4.31
DataBase - berkeley-db: 5.1.29


${Bred}${Fseablue}                                       ${AC}
${Bred}${Fseablue} Install                               ${AC}
${Bred}${Fseablue}                                       ${AC}
${Fgreen} Prepare${AC}
 apt-get install build-essential libssl-dev -y

${Fgreen} Download & Unpacking ${AC}
 wget http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz
 wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.31.tgz
 tar -zvxf db-5.1.29.NC.tar.gz -C ./
 tar -zvxf openldap-2.4.31.tgz -C ./

${Fgreen} Building  ( gcc 4.7+ ) ${AC}
 cd db-5.1.29.NC/build_unix/
 ../dist/configure --prefix=/usr/share/BerkeleyDB
 make & make install



OpenLDAP的相关配置文件信息
      /etc/openldap/slapd.conf：OpenLDAP的主配置文件，记录根域信息，管理员名称，密码，日志，权限等
      /etc/openldap/slapd.d/*：这下面是/etc/openldap/slapd.conf配置信息生成的文件，每修改一次配置信息，这里的东西就要重新生成
      /etc/openldap/schema/*：OpenLDAP的schema存放的地方
      /var/lib/ldap/*：OpenLDAP的数据文件
      /usr/share/openldap-servers/slapd.conf.obsolete 模板配置文件
      /usr/share/openldap-servers/DB_CONFIG.example 模板数据库配置文件

 OpenLDAP监听的端口：
      默认监听端口：389（明文数据传输）
      加密监听端口：636（密文数据传输）



EOF

