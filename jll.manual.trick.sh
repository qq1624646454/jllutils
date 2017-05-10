#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.trick.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-04-12 16:17:54
#   ModifiedTime: 2017-04-21 14:44:55

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1 <<EOF


===============================================================
 为对象分配一个长度为0的Java数组
---------------------------------------------------------------
好处：调用者就不必每次都要判断该对象是不是null;





===============================================================
 抽象类
---------------------------------------------------------------
当一个类当中只要有方法被声明为抽象，即不实现的那种函数，该类也
相当于没有完全实现，是个不具体的类，所以就必须声明为抽象类.

接口也是一种抽象类，由于java无法多继承类，而可以多实现接口，因
此设计了只含方法声明（或再加一些成员常量）的接口.

有人问：抽象类能实例化吗？不能，因为有抽象方法没有实现，无法为
其分配具体的空间大小。

EOF

