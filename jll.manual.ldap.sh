#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ldap.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-12-23 19:44:07
#   ModifiedTime: 2021-02-05 12:01:37

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

Lightweight Directory Access Protocol，轻量级是相对于重量级X.500协议而言

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

${Fyellow}echo "\${LDAP_HOME}/libexec/env-for-openldap" >> \${HOME}/.bashrc ${AC}

${Fblue}#Let openldap server named slapd is started followwing by system startup, ${AC}
${Fblue}#and it can be controlled by service ${AC}
${Fyellow}cp -rvf /etc/init.d/skeleton  /etc/init.d/slapd_openldap
${Fyellow}vim /etc/init.d/slapd${AC}
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

${Fyellow}update-rc.d slapd defaults 27${AC} # Install the startup service to rc 1,2,3,4,5

${Fyellow}service slapd start${AC} # Start to run openldap server named slapd
${Fyellow}service slapd stop${AC}  # Stop to run openldap server  named slapd



${Bblue}${Fgreen}                                                     ${AC}
${Bblue}${Fgreen} OpenLDAP Server and Client + BerkeleyDB Deployment  ${AC}
${Bblue}${Fgreen}                                                     ${AC}

${Bblue}${Fgreen} /usr/share/OpenLDAP:  OpenLDAP Server and Client Programs${AC}

[Server Program]
${Fseablue}/usr/share/OpenLDAP/libexec/ ${AC}
    slapd :  OpenLDAP Server Program which it is started up followwing by system startup.
    env-for-openldap :  Environment Various file which is sourced automatically when login stage.

[Server Program]
${Fseablue}/usr/share/OpenLDAP/sbin/ ${AC}
    * : are linked to /usr/share/OpenLDAP/libexec/slapd

[Server Backend Database Program]
${Fseablue}/usr/share/BerkeleyDB/ ${AC}
    *

[Server Database Data File]
${Fseablue}/usr/share/OpenLDAP/var/openldap-data/ ${AC}
    *

[Server Program Configuration]
${Fseablue}/usr/share/OpenLDAP/etc/ ${AC}
    * : slapd.conf or OLC(Open Ldap Configuration) namely cn=config is supported started from 2.4
        ${Fred}Noted: slapd.conf maybe abandoned in the future.${AC}


[Client Program For CLIs]
${Fseablue}/usr/share/OpenLDAP/bin/ ${AC}
    ldapadd : linked to ldapmodify
    ldapmodify :
        
    ${Fgreen}ldapsearch${AC} :
        # -H <ldap://target-ip> : 指定远程ldap服务器主机地址
        # -x : 简单验证，即使用用户+密码方式验证
        # -D <RootDN> : 使用某个用户身份在ldap服务器上执行这条指令，用户也是一条DN,通常是RootDN
        # -w <RootDN-Password> : 使用-D所指定的用户的密码，也可以用-W直接在执行时提示密码输入
        # [ -b <BaseDN> ] : 可选,目录服务的数据是目录树，指定从某个目录作为基础节点开始执行操作
        # [ <matching-expression> ] : 可选,规则匹配
        ldapsearch -H ldap://127.0.0.1 -x -D "cn=root,dc=jllim,dc=com" -w 123456 \\
                   -b "dc=jllim,dc=com" "uid=*"
    ${Fgreen}ldapwhoami${AC} :
        ldapwhoami -H ldap://127.0.0.1 -x -D "cn=root,dc=jllim,dc=com" -w 123456
    ${Fgreen}ldapdelete${AC} :

    ldapcompare :
    ldapexop :
    ldapmodrdn :
    ldappasswd :
    ldapurl :


${Bblue}${Fgreen}/usr/share/BerkeleyDB:  OpenLDAP Server Database Programs${AC}
    *


${Bblue}${Fgreen}概述${AC}

LDAP 轻量级目录访问协议

--------
LDAP的目录信息的总体组织结构 
--------
  DIT: Directory Information Tree 目录信息树
  Entry: The DIT is made up of one or more Entry, unit of DIT
         目录信息树中一条记录，称为条目，每个条目有自己唯一的可区别的名称(DN)
  ObjectClass: 对象类，对象类可以继承，用于定义Entry的数据类型，即属性
  Property: 属性，描述Entry的某个类型 

--------
LDAP的目录条目常用字段
--------
${Fseablue}Schema${AC} 一个条目中各个字段是由Schema定义的,Schema文件一般位于 etc/openldap/schema/*
  core.schema : OpenLDAP的核心schema.【它是必须加载的】
  inetorgperson.schema : 它仅次于core, 我们添加账号时,很多要使用到它里面定义的objectClass.
  dyngroup.schema : 这是定义组时使用的schema,包括要使用sudo.schema时,也需要它。
  ppolicy.schema : 若需要做密码策略时,需要导入此schema.
  nis.schema : 网络信息服务(FYI),也是一种集中账号管理实现.
  java.schema : 若需要使用Java程序来操作openLDAP时,需要使用它,让OpenLDAP支持Java.
  cosine.schema : Cosine 和 Internet X.500 (比较有用, 不太懂.)
  misc.schema : Assorted (experimental)
  openldap.schema : OpenLDAP Project(experimental)
  sudo.schema: 定义sudo规则

常用字段:
dn(Distinguished Name): 
    “uid=songtao.xu,ou=oa组,dc=example,dc=com”，一条记录的位置（唯一）
uid(User Id): 
    用户ID songtao.xu（一条记录的ID）, 这里的UID不是Linux系统上的UID,这里的UID是用户登录LDAP的账号.
ou(Organization Unit): 
    组织单位，组织单位可以包含其他各种对象（包括其他组织单元），如“oa组”（一条记录的所属组织）
dc(Domain Component):
    域名的部分，其格式是将完整的域名分成几部分,
    如域名为example.com变成dc=example,dc=com（一条记录的所属位置）

    为什么会设计成域名形式？
        因为openldap是支持基于网络访问，即客户端和服务器可以是不同设备.   

cn(Common Name): 
    公共名称，如“Thomas Johansson”（一条记录的名称）
sn(Surname): 
    姓，如“许”, 只能写姓
giveName: 只能写名字
rdn(Relative dn): 
    相对辨别名，类似于文件系统中的相对路径，
    它是与目录树结构无关的部分，如“uid=tom”或“cn= Thomas Johansson”

传统方式的组织形式，聚焦于国别以及地理信息为上层构成,常用的字段有：
c(Country):
    国家，如“CN”或“US”等。
st(State):
    州/区/省
o(Organization):
    组织，它更多地代表是子公司.

e.g:
    cn=Barbara Jenson,ou=Sales,o=Acme,st=California,c=US

互联网域名的组织形式，基于域名，上层构成直接使用域名，能结合DNS相关的技术：
e.g:
    uid=babs,ou=People,dc=example,dc=com


--------




${Bred}${Fseablue}                                       ${AC}
${Bred}${Fseablue} Initialize and Configuration          ${AC}
${Bred}${Fseablue}                                       ${AC}
配置OpenLDAP服务器是整个方案中最为麻烦的部分，网络上参考几乎都不对（很多教程停留在2008年甚至1998年）
而正确的配置方法是通过ldapmodify命令执行一系列自己写好的ldif文件，而不是修改任何OpenLDAP预装好的配
置文件.记住，OpenLDAP预装好的ldif配置是通过schema文件自动生成的，不应该被直接修改
(e.g: This file was automatically generated from collective.schema)

${Fred}ldif文件，即LDAP Interchange Format${AC}
LDIF 文件每行的结尾不允许有空格或者制表符
LDIF 文件允许相关属性可以重复赋值并使用
LDIF 文件以.ldif结尾命名
LDIF 文件中以#号开头的一行为注释，可以作为解释使用
LDIF 文件所有的赋值方式为:    属性:[空格]属性值
LDIF 文件通过空行来定义一个条目，空格前为一个条目，空格后为另一个条目的开始
--------
# 注释，用于对条目进行解释
dn: 条目名称
objectClass(对象类): 属性值
objectClass(对象类): 属性值
...



${Bblue}${Fgreen} 配置说明 ${AC}
etc/slapd.conf   (Abandon)
    旧版本的默认使用它实现数据库文件的生成，但在2.4版本开始官方就不推荐了，
    因为通过它来配置LDAP,主要嫌它太繁琐,修改完配置必须重新生成OpenLDAP数据库,
　　这就意味着,OpenLDAP服务器必须停机. 建议cn=config方式.
cn=config   (Recommend)
    相对slapd.conf方式而言，通过ldapmodify修改后立即生效而不需要重启OpenLDAP服务器，属于热部署.


#
#DB_CONFIG.example会自动生成DB_CONFIG,所以不需要特别处理
#/usr/share/OpenLDAP/var/openldap-data/DB_CONFIG.example
#



${Bblue}${Fgreen} 初始化操作 ${AC}














${Bblue}${Fgreen} Prepare${AC}

${Bblue}${Fgreen} Building OpenLDAP ( gcc 4.7+ ) ${AC}
${Fred} ${AC}

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

root@BS-010197:/usr/share/OpenLDAP/bin# ldd ldapwhoami
        linux-vdso.so.1 =>  (0x00007ffc727dc000)
        ${Fred}libsasl2.so.2 => /usr/lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007f7f30d92000)${AC}
        libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007f7f30b33000)
        libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007f7f30756000)
        libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f7f3053b000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7f30172000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f7f2ff6e000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f7f30fad000)

${Fred}ISSUE is what about ldap_sasl_interactive_bind_s: Can't contact LDAP server (-1) ${AC}



------------------------------------------------
https://www.cnblogs.com/wn1m/p/10700236.html
------------------------------------------------


https://www.it610.com/article/5623624.htm


<<轻型目录访问协议>>
Lightweight Directory Access Protocol，缩写：LDAP）是一个开放的，中立的，工业标准的应用协议，通过IP协议提供访问控制和维护分布式信息的目录信息.

市面上只要你能够想像得到的所有工具软件，全部都支持LDAP协议。比如说你公司要安装一个项目管理工具，那么这个工具几乎必然支持LDAP协议，你公司要安装一个bug管理工具，这工具必然也支持LDAP协议，你公司要安装一套软件版本管理工具，这工具也必然支持LDAP协议。LDAP协议的好处就是你公司的所有员工在所有这些工具里共享同一套用户名和密码，来人的时候新增一个用户就能自动访问所有系统，走人的时候一键删除就取消了他对所有系统的访问权限，这就是LDAP。

有些领域并不像前端世界那么潮那么性感，但是缺了这个环节又总觉得很别扭。如果深入到运维的世界，你会发现大部分工具还活在上个世纪，产品设计完全反人类，比如cn, dc, dn, ou这样的命名方式，如果不钻研个一天两天，鬼知道它在说什么，比如说dns，dns是什么鬼？域名吗？不是，它只是某个懒惰的工程师起了dn这么一个缩写，再加一个复数，就成了dns，和域名服务器没有任何关系；cn是什么？中国的缩写？你想多了，这和中国没有任何关系。经过一系列这样疯狂的洗脑之后，你才能逐渐明白LDAP到底想干什么。抛弃你所有的认知，把自己当成一个什么都不懂的幼儿园孩子，然后我们从头学起LDAP.

如果你搜索OpenLDAP的安装指南，很不幸地告诉你，网上不管中文的英文的，90%都是错的，它们都还活在上个世纪，它们会告诉你要去修改一个叫做slapd.conf的文件，基本上看到这里，你就不用往下看了，这个文件早就被抛弃，新版的OpenLDAP里根本就没有这个文件！取而代之的是slapd.d的文件夹，然后另一部分教程会告诉你，让你修改这个文件夹下的某一个ldif文件，看到这里，你也不用往下看了，你又看到了伪教程，因为这个文件夹下的所有文件的第一行都明确地写着：『这是一个自动生成的文件，不要修改它！』你修改了它之后，它的md5校验值会匹配不上，造成更多的问题。你应该用ldapmodify来修改这个文件，而关于ldapmodify的教程，可以说几乎就没有！我一开始不知道面临这样荒谬的处境，很多运维人员是怎么活下来的，不过等我自己配通了以后，真的是累到连写教程的精力都没有了，好吧，我已经配通了，你们各人自求多福吧。

谈谈OpenLDAP的架构：
1.OpenLDAP服务器: 实质上它相当于一台可基于网络访问的数据库，所管理的数据是目录信息，
                  而目录信息非常适合存储用户账号等，它的访问API默认为命令行；
2.phpLDAPadmin: 为了解决管理员可以使用图形界面而非使用命令行去访问OpenLDAP服务器,phpLDAPadmin提供了
                一个奇丑无比的web化的管理操作平台;
3.PWM: 只装有管理工具也还不够，还需要为用户提供一个修改密码的地方;
4.客户端：配置各种工具



EOF

