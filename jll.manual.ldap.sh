#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ldap.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-23 19:44:07
#   ModifiedTime: 2021-02-04 15:02:59

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
${Fyellow}apt-get install build-essential libssl-dev libsasl2-dev  -y ${AC}


${Bblue}${Fgreen} Download & Unpacking ${AC}
${Fyellow}wget http://download.oracle.com/berkeley-db/db-5.1.29.NC.tar.gz${AC}
${Fyellow}wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.31.tgz${AC}
${Fyellow}tar -zvxf db-5.1.29.NC.tar.gz -C ./ ${AC}
${Fyellow}tar -zvxf openldap-2.4.31.tgz -C ./ ${AC}

${Bblue}${Fgreen} Building BerkeleyDB ( gcc 4.7+ ) ${AC}
${Fyellow}cd db-5.1.29.NC/build_unix/ ${AC}
${Fyellow}../dist/configure --prefix=/usr/share/BerkeleyDB ${AC}
${Fyellow}make & make install ${AC}
${Fyellow}cd - >/dev/null ${AC}

${Bblue}${Fgreen} Building OpenLDAP ( gcc 4.7+ ) ${AC}
${Fyellow}vim env-for-openldap${AC}
export BERKELEYDB_HOME=/usr/share/BerkeleyDB
export CPPFLAGS="-I\${BERKELEYDB_HOME}/include"
export LDFLAGS="-L\${BERKELEYDB_HOME}/lib"
export LD_LIBRARY_PATH="\${BERKELEYDB_HOME}/lib"

export LDAP_HOME="/usr/share/OpenLDAP"
export PATH="\${PATH}:\${BERKELEYDB_HOME}/bin:\${LDAP_HOME}/bin:\${LDAP_HOME}/sbin:\${LDAP_HOME}/libexec"

${Fyellow}source env-for-openldap${AC}

${Fyellow}cd openldap-2.4.31 ${AC}
${Fyellow}./configure --prefix=\${LDAP_HOME} # /usr/share/OpenLDAP ${AC}
${Fyellow}make depend${AC}
${Fyellow}make${AC}
${Fyellow}make install${AC}
${Fyellow}cd - >/dev/null ${AC}
${Fyellow}cp -rf env-for-openldap \${LDAP_HOME}/libexec/ ${AC}



${Fred}${Fseablue}/usr/share/OpenLDAP:  OpenLDAP Server and Client Programs${AC}

[Server]
/usr/share/OpenLDAP/libexec/
    slapd :  OpenLDAP Server Program
    env-for-openldap :  Environment Various definition

[Server]
/usr/share/OpenLDAP/sbin/
    *  are linked to /usr/share/OpenLDAP/libexec/slapd

[Client]
/usr/share/OpenLDAP/bin/
    ldapadd : linked to ldapmodify
    ldapmodify :
    ldapsearch :
    ldapdelete :
    ldapwhoami :
    ldapcompare :
    ldapexop :
    ldapmodrdn :
    ldappasswd :
    ldapurl :

${Fred}${Fseablue}/usr/share/BerkeleyDB:  OpenLDAP Server Database${AC}


${Fred}  ${AC}


${Bred}${Fseablue}                                       ${AC}
${Bred}${Fseablue} Initialize                            ${AC}
${Bred}${Fseablue}                                       ${AC}
${Bblue}${Fgreen} Prepare${AC}

${Bblue}${Fgreen} Building OpenLDAP ( gcc 4.7+ ) ${AC}
${Fred} ${AC}

${Fred}配置OpenLDAP有两种方法，一种是修改slapd.conf实现配置，一种是修改数据库实现配置${AC}
${Fred}配置OpenLDAP有两种方法，一种是修改slapd.conf实现配置，一种是修改数据库实现配置${AC}
${Fred}[1]修改slapd.conf完成配置${AC}
${Fyellow}vim \${LDAP_HOME}/etc/openldap/slapd.conf${AC}
  ...
  include		/usr/share/OpenLDAP/etc/openldap/schema/core.schema
+ include		/usr/share/OpenLDAP/etc/openldap/schema/cosine.schema
+ include		/usr/share/OpenLDAP/etc/openldap/schema/inetorgperson.schema
  ...
+ #suffix		"dc=my-domain,dc=com"
+ suffix		"dc=reachxm,dc=com"
+ #rootdn		"cn=Manager,dc=my-domain,dc=com"
  ${Fred}服务管理员可以对目录树进行更删改查等管理操作，以下指定管理员用户名${AC}
+ rootdn		"cn=root,dc=reachxm,dc=com"
+ #rootpw		secret
+ #JLLim: slappasswd -s 123456
+ #       {SSHA}w59E+EGqCcMhdTVGlzMeCXDsUqAFD+EU
+ rootpw		123456
  ...
+ # JLLim logging is tracked
+ loglevel		256
+ logfile		/usr/share/OpenLDAP/var/slapd.log

${Fred}验证管理员密码,ldapwhoami不带参数时返回为anonymous,-D绑定为管理员,-W提示密码输入,-x使用密码${AC}
${Fyellow}ldapwhoami -x -D cn=root,dc=reachxm,dc=com -W ${AC}
Enter LDAP Password:
dn:cn=root,dc=reachxm,dc=com


${Fred}在另一台ldap客户机上查询${AC}
${Fyellow}/usr/share/OpenLDAP/bin/ldapwhoami -x -w 123456 -D "cn=root,dc=reachxm,dc=com" -H ldap://172.16.10.197 ${AC}



${Fred}[2]修改数据库完成配置${AC}



${Bblue}${Fgreen} Start to run slapd followwing by system startup ${AC}
${Bblue}${Fgreen}     slapd is OpenLDAP Server                    ${AC}
${Fyellow}cp -rf /etc/init.d/skeleton /etc/init.d/openldap${AC}
${Fyellow}vim /etc/init.d/openldap${AC}
  ...
  DESC="slapd is associated with OpenLDAP Server"
  NAME=slapd
+ EXECPATH=/usr/share/OpenLDAP
  DAEMON_ARGS=""
- PIDFILE=/var/run/\$NAME.pid
  ...
+ [ -x "\${EXECPATH}/libexec/env-for-openldap" ] || exit 0 
+ . \${EXECPATH}/libexec/env-for-openldap

- [ -r /etc/default/\$NAME ] && . /etc/default/\$NAME
- . /lib/init/vars.sh

  ...
  #JLLim: Remove "--pidfile \$PIDFILE" from all line of start-stop-daemon
  ...

${Fyellow}update-rc.d openldap defaults 27${AC} # Install the startup service to rc 1,2,3,4,5

${Fyellow}service openldap start${AC} # Start to run openldap server named slapd
${Fyellow}service openldap stop${AC}  # Stop to run openldap server  named slapd

${Bblue}${Fgreen} Start to run slapd by manual - OpenLDAP Server ${AC}

${Fyellow}source /usr/share/OpenLDAP/libexec/env-for-openldap${AC}
${Fyellow}/usr/share/OpenLDAP/libexec/slapd -d 256 ${AC} # start slapd with debug log on console

${Fyellow}killall slapd                            ${AC} # stop slapd by killing the process




${Bblue}${Fgreen} Import Data during slapd running${AC}
${Fyellow}vim test.ldif${AC}
dn: dc=reachxm,dc=com
dc: reachxm
o: ReachAIoT.Inc
objectClass: dcObject
objectClass: organization

dn: cn=root,dc=reachxm,dc=com
cn: root
objectClass: organizationalRole

dn: ou=itsection,dc=reachxm,dc=com
ou: itsection
objectClass: organizationalUnit

dn: cn=sean,ou=itsection,dc=reachxm,dc=com
ou: itsection
cn: sean
sn: zhouxiao
objectClass: inetOrgPerson
objectClass: organizationalPerson

${Fyellow}ldapadd -x -D "cn=root,dc=reachxm,dc=com" -W -f test.ldif ${AC}
Enter LDAP Password: ${Fred}123456${AC}
adding new entry "dc=reachxm,dc=com"

adding new entry "cn=root,dc=reachxm,dc=com"

adding new entry "ou=itsection,dc=reachxm,dc=com"

adding new entry "cn=sean,ou=itsection,dc=reachxm,dc=com"





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
        Stats                          (256, 0x100)  #JLLim: recommend
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



${Bblue}${Fgreen} OpenLDAP Management Commands ${AC}
ldapsearch: 搜索OpenLDAP目录树条目
ldapadd: 通过LDIF格式，添加目录树条目
ldapdelete: 删除OpenLDAP目录树条目
ldapmodify: 修改OpenLDAP目录树条目
ldapwhoami: 检验OpenLDAP用户的身份
ldapmodrdn: 修改OpenLDAP目录树DN条目
ldapcompare: 判断DN值和指定参数值是否属于同一个条目
ldappasswd: 修改OpenLDAP目录树用户条目实现密码重置
slaptest: 验证slapd.conf文件或cn=配置目录(slapd.d)
slapindex: 创建OpenLDAP目录树索引，提高查询效率
slapcat: 将数据条目转换为OpenLDAP的LDIF文件

<Command> ? #show the help detail


${Fyellow}ldapadd ?${AC}
#ldapadd is linked to ldapmodify
Add or modify entries from an LDAP server

usage: ldapadd [options]
        The list of desired operations are read from stdin or from the file
        specified by "-f file".
Add or modify options:
  -a         add values (default)
  -c         continuous operation mode (do not stop on errors)
  -E [!]ext=extparam    modify extensions (! indicate s criticality)
  -f file    read operations from 'file'
  -M         enable Manage DSA IT control (-MM to make critical)
  -P version protocol version (default: 3)
  -S file    write skipped modifications to 'file'
Common options:
  -d level   set LDAP debugging level to 'level'
  -D binddn  bind DN
             ${Fseablue}指定一个DN，代表整个树的唯一识别名称${AC}
  -e [!]<ext>[=<extparam>] general extensions (! indicates criticality)
             [!]assert=<filter>     (RFC 4528; a RFC 4515 Filter string)
             [!]authzid=<authzid>   (RFC 4370; "dn:<dn>" or "u:<user>")
             [!]chaining[=<resolveBehavior>[/<continuationBehavior>]]
                     one of "chainingPreferred", "chainingRequired",
                     "referralsPreferred", "referralsRequired"
             [!]manageDSAit         (RFC 3296)
             [!]noop
             ppolicy
             [!]postread[=<attrs>]  (RFC 4527; comma-separated attr list)
             [!]preread[=<attrs>]   (RFC 4527; comma-separated attr list)
             [!]relax
             [!]sessiontracking
             abandon, cancel, ignore (SIGINT sends abandon/cancel,
             or ignores response; if critical, doesn't wait for SIGINT.
             not really controls)
  -h host    LDAP server
  -H URI     LDAP Uniform Resource Identifier(s)
  -I         use SASL Interactive mode
  -n         show what would be done but don't actually do it
  -N         do not use reverse DNS to canonicalize SASL host name
  -O props   SASL security properties
  -o <opt>[=<optparam>] general options
             nettimeout=<timeout> (in seconds, or "none" or "max")
             ldif-wrap=<width> (in columns, or "no" for no wrapping)
  -p port    port on LDAP server
  -Q         use SASL Quiet mode
  -R realm   SASL realm
  -U authcid SASL authentication identity
  -v         run in verbose mode (diagnostics to standard output)
  -V         print version info (-VV only)
  -w passwd  bind password (for simple authentication)
  -W         prompt for bind password
             ${Fseablue}查询提示输入密码，也可通过-w password实现自动输入密码${AC}
  -x         Simple authentication
             ${Fseablue}简认认证，不使用任何加密算法${AC}
  -X authzid SASL authorization identity ("dn:<dn>" or "u:<user>")
  -y file    Read password from file
  -Y mech    SASL mechanism
  -Z         Start TLS request (-ZZ to require successful response)



${Bred}${Fwhite}root@BS-010197:.# cat <<EOFL | ldapmodify -Y EXTERNAL -H ldapi:///${AC}
dn: olcDatabase={0}config,cn=config
changetype: modify
delete: olcRootDN

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootDN
olcRootDN: cn=Amin,cn=config

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: 654321
EOFL

${Fred}ISSUE is what about ldapadd: not compiled with SASL support${AC}
${Fgreen}Check whether ldapwhoami is linked against libsasl2${AC}
root@BS-010197:/usr/share/OpenLDAP/bin# ldd ldapwhoami
        linux-vdso.so.1 =>  (0x00007ffce351e000)
        libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007f1d8290f000)
        libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007f1d82532000)
        libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f1d82317000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1d81f4e000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f1d81d4a000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f1d82b6e000)
${Fyellow}aptitude install -y libsasl2-dev${AC} #re-build then re-install

${Fred}ISSUE is what about ldap_sasl_interactive_bind_s: Can't contact LDAP server (-1) ${AC}




关键字	英文全称			含义
dc	    Domain Component	域名的部分，其格式是将完整的域名分成几部分，如域名为example.com变成dc=example,dc=com
uid		User Id		 用户ID，如“tom”
ou	Organization Unit	 组织单位，类似于Linux文件系统中的子目录，它是一个容器对象，组织单位可以包含其他各种对象（包括其他组织单元），如“market”
cn	Common Name		 公共名称，如“Thomas Johansson”
sn	Surname		 姓，如“Johansson”
dn	Distinguished Name	 惟一辨别名，类似于Linux文件系统中的绝对路径，每个对象都有一个惟一的名称，如“uid= tom,ou=market,dc=example,dc=com”，在一个目录树中DN总是惟一的
rdn		Relative dn		相对辨别名，类似于文件系统中的相对路径，它是与目录树结构无关的部分，如“uid=tom”或“cn= Thomas Johansson”
c	Country		国家，如“CN”或“US”等。
o	Organization	组织名，如“Example, Inc.”


EOF

