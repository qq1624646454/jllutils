#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.pm.forAndroid.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-04-13 11:58:38
#   ModifiedTime: 2017-04-13 11:59:03

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF



1、安装APK：例如，在串口终端下输入：

pm install -r /data/card/ApicalRadio.apk

就可以重新安装ApicalRadio.apk到android系统上，默认是安装到系统的data/app/目录下。

-r 参数表示重新安装，如果原来已经安装了，会覆盖原来的安装包。

2、卸载

pm uninstall -k com.apical.apicalradio

其中，com.apical.apicalradio 是你的APK包的包名。

3、除了pm命令，使用cp 或者 rm 都可以达到安装的效果。如果是在终端模式操作，个人感觉使用cp和 rm 更方便。

安装：cp /data/card/ApicalRadio.apk  /data/app

卸载：rm -f  /data/app/ApicalRadio.apk

这两个命令其实就是Linux下的删除和复制命令。

下面是有关PM命令详细使用，英文原文，理解也不能，就不翻译了。。。。。。

usage: pm list
pm list packages -f
pm list permission-groups
pm list permissions -g -f -d -u GROUP
pm list instrumentation -f TARGET-PACKAGE
pm path PACKAGE
pm install -l -r PATH
pm uninstall -k PACKAGE
pm enable PACKAGE_OR_COMPONENT
pm disable PACKAGE_OR_COMPONENT
The list packages command prints all packages.Use the -f option to see their associated file.
The list permission-groups command prints all knownpermission groups.
The list permissions command prints all known permissions, optionally only those in GROUP.Use
the -g option to organize by group.Use
the -f option to print all information.Use
the -s option for a short summary.Use
the -d option to only list dangerous permissions.Use
the -u option to list only the permissions users will see.
The list instrumentation command prints all instrumentations,or only those that target a specified package.Use the -ff option to see their associated file.
The path command prints the path to the .apk of a package.
The install command installs a package to the system.Use
the -l option to install the package with FORWARD_LOCK. Use
the -r option to reinstall an exisiting app, keeping its data.
The uninstall command removes a package from the system. Use
the -k option to keep the data and cache directories around after the package removal.


EOF

