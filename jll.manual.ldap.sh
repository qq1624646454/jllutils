#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ldap.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-23 19:44:07
#   ModifiedTime: 2020-12-28 20:45:18

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
${Bblue}${Fgreen} Prepare${AC}
${Fyellow}apt-get install build-essential libssl-dev -y ${AC}

${Bblue}${Fgreen} Download & Unpacking ${AC}
${Fyellow}wget http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz${AC}
${Fyellow}wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.31.tgz${AC}
${Fyellow}tar -zvxf db-5.1.29.NC.tar.gz -C ./ ${AC}
${Fyellow}tar -zvxf openldap-2.4.31.tgz -C ./ ${AC}

${Bblue}${Fgreen} Building  ( gcc 4.7+ ) ${AC}
${Fyellow}cd db-5.1.29.NC/build_unix/ ${AC}
${Fyellow}../dist/configure --prefix=/usr/share/BerkeleyDB ${AC}
${Fyellow}make & make install ${AC}



${Bblue}${Fgreen} Starting ${AC}
${Fyellow}vim env-for-openldap${AC}
export BERKELEYDB_HOME=/usr/share/BerkeleyDB
export CPPFLAGS="-I\${BERKELEYDB_HOME}/include"
export LDFLAGS="-L\${BERKELEYDB_HOME}/lib"
export LD_LIBRARY_PATH="\${BERKELEYDB_HOME}/lib"

export LDAP_HOME="/usr/share/OpenLDAP"
export PATH="\${PATH}:\${BERKELEYDB_HOME}/bin:\${LDAP_HOME}/bin:\${LDAP_HOME}/sbin:\${LDAP_HOME}/libexec"

${Fyellow}source env-for-openldap${AC}

modify slapd.conf

${Fyellow}ldapadd -x -D "cn=root,dc=reachxm,dc=com" -W -f test.ldif ${AC}
Enter LDAP Password:
adding new entry "dc=reachxm,dc=com"

adding new entry "cn=root,dc=reachxm,dc=com"

adding new entry "ou=itsection,dc=reachxm,dc=com"

adding new entry "cn=sean,ou=itsection,dc=reachxm,dc=com"





${Bblue}${Fgreen} Startup followwing by system startup ${AC}
${Fyellow}vim openldap${AC}
export BERKELEYDB_HOME=/usr/share/BerkeleyDB
export CPPFLAGS="-I\${BERKELEYDB_HOME}/include"
export LDFLAGS="-L\${BERKELEYDB_HOME}/lib"
export LD_LIBRARY_PATH="\${BERKELEYDB_HOME}/lib"

export LDAP_HOME="/usr/share/OpenLDAP"
export PATH="\${PATH}:\${BERKELEYDB_HOME}/bin:\${LDAP_HOME}/bin:\${LDAP_HOME}/sbin:\${LDAP_HOME}/libexec"

if [ -x "/usr/share/OpenLDAP/libexec/slapd" ]; then
#    /usr/share/OpenLDAP/libexec/slapd -d 256
    /usr/share/OpenLDAP/libexec/slapd
fi

${Fyellow}ln -sv /usr/share/OpenLDAP/libexec/openldap /etc/init.d/${AC}
${Fyellow}update-rc.d openldap defaults 27${AC}
${Fyellow}service openldap stop${AC}
${Fyellow}service openldap start${AC}


usage: slapd options
        -4              IPv4 only
        -6              IPv6 only
        -T {acl|add|auth|cat|dn|index|passwd|test}
                        Run in Tool mode
        -c cookie       Sync cookie of consumer
        -d level        Debug level
        -f filename     Configuration file
        -F dir  Configuration directory
        -g group        Group (id or name) to run as
        -h URLs         List of URLs to serve
        -l facility     Syslog facility (default: LOCAL4)
        -n serverName   Service name
        -o <opt>[=val] generic means to specify options; supported options:
                slp[={on|off|(attrs)}] enable/disable SLP using (attrs)
        -r directory    Sandbox directory to chroot to
        -s level        Syslog level
        -u user         User (id or name) to run as
        -V              print version info (-VV exit afterwards, -VVV print
                        info about static overlays and backends)

${Bblue}${Fgreen} OpenLDAP Logging Configuration ${AC}
${Fyellow}/usr/share/OpenLDAP/libexec/slapd -d ? ${AC}
Installed log subsystems:

        Any                            (-1, 0xffffffff)
        Trace                          (1, 0x1)
        Packets                        (2, 0x2)
        Args                           (4, 0x4)
        Conns                          (8, 0x8)
        BER                            (16, 0x10)
        Filter                         (32, 0x20)
        Config                         (64, 0x40)
        ACL                            (128, 0x80)
        Stats                          (256, 0x100)
        Stats2                         (512, 0x200)
        Shell                          (1024, 0x400)
        Parse                          (2048, 0x800)
        Sync                           (16384, 0x4000)
        None                           (32768, 0x8000)

NOTE: custom log subsystems may be later installed by specific code




${Bblue}${Fgreen} Resource Associated with OpenLDAP ${AC}

OpenLDAP的相关配置文件信息
      /etc/openldap/slapd.conf：OpenLDAP的主配置文件，记录根域信息，管理员名称，密码，日志，权限等
      /etc/openldap/slapd.d/*：这下面是/etc/openldap/slapd.conf配置信息生成的文件，每修改一次配置信息，这里的东西就要重新生成
      /etc/openldap/schema/*：OpenLDAP的schema存放的地方
      /var/lib/ldap/*：OpenLDAP的数据文件
      /usr/share/openldap-servers/slapd.conf.obsolete 模板配置文件
      /usr/share/openldap-servers/DB_CONFIG.example 模板数据库配置文件

 OpenLDAP/var/openldap-data/__db.001
?? OpenLDAP/var/openldap-data/__db.002
?? OpenLDAP/var/openldap-data/__db.003
?? OpenLDAP/var/openldap-data/__db.004
?? OpenLDAP/var/openldap-data/__db.005
?? OpenLDAP/var/openldap-data/__db.006
?? OpenLDAP/var/openldap-data/alock
?? OpenLDAP/var/openldap-data/dn2id.bdb
?? OpenLDAP/var/openldap-data/id2entry.bdb
?? OpenLDAP/var/openldap-data/log.0000000001
?? OpenLDAP/var/run/



${Bblue}${Fgreen}OpenLDAP Listening Ports: ${AC}
 389 (cleartext by default)
 636 (ciphertext)

${Fyellow}netstat -anp | grep slapd${AC}
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:389             0.0.0.0:*               LISTEN      19656/slapd
tcp6       0      0 :::389                  :::*                    LISTEN      19656/slapd

Proto RefCnt Flags       Type       State         I-Node   PID/Program name    Path
unix  2      [ ]         DGRAM                    285590    19656/slapd


${Fyellow}netstat -ntplu | grep -i :389${AC}
tcp        0      0 0.0.0.0:389             0.0.0.0:*               LISTEN      2031/slapd
tcp6       0      0 :::389                  :::*                    LISTEN      2031/slapd

core.schema:

cosine.schema:1436:#    top OBJECT-CLASS
cosine.schema-1437-#        MUST CONTAIN {
cosine.schema-1438-#            objectClass}
cosine.schema-1439-#    ::= {objectClass 0}
cosine.schema-1440-#



${Fyellow}GUI${AC}
phpldapadmin : PHP
LDAP Account Manager (LAM) : PHP
Web2LDAP : Python3
LDAPadmin : windows

EOF

