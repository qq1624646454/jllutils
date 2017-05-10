#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.ReactOS.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-12-15 15:29:29
#   ModifiedTime: 2016-12-15 15:32:26

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1 <<EOF

---------------------------------------------------------------------------------------------------
ReactOS是Windows NT兼容平台，它提供一套与Windows NT一样的API，以便可以支持Windows Application的运行
所以搭建ReactOS可以帮忙Windows程序员更好地理解Win32编程.
---------------------------------------------------------------------------------------------------

#创建svn版本库
svn co svn://svn.reactos.org/reactos/trunk/reactos
# 或 git svn clone svn://svn.reactos.org/reactos/trunk/reactos 不推荐，因为速度太慢了



EOF

