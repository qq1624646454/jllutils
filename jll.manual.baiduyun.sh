#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.baiduyun.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-09-19 01:20:10
#   ModifiedTime: 2018-09-19 01:29:04

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

------------------------------
-- for ubuntu 14.04 64bit
------------------------------
apt-get install youtube-dl
apt-get install python-pip
pip install requests
pip install bypy

#First run it and need to authorization code is pasted from website then press [Enter]
#第一次运行时需要授权，只需跑任何一个命令（比如 bypy info）然后跟着说明（登陆等）来授权即可。授权只需一次，一旦成功，以后不会再出现授权提示.
#可以看到，提示你访问某个网址，并对bypy python客户端进行授权，按照提示操作即可授权成功
bypy info

#由于百度PCS API权限限制，程序只能存取百度云端/apps/bypy目录下面的文件和目录
bypy list
bypy downdir  #把云盘上的内容(apps/bypy)同步到本地
bypy syncdown #把云盘上的内容(apps/bypy)同步到本地
bypy upload   #把本地当前目录下的文件同步到百度云盘(apps/bypy)
bypy syncup   #把本地当前目录下的文件同步到百度云盘(apps/bypy)
bypy compare

-v 参数表示显示进度详情


EOF

