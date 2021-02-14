#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.makefile.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-01-15 20:27:18
#   ModifiedTime: 2020-01-15 20:42:53

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

---------------------------------------------------------------
scripts/Makefile.lib
---------------------------------------------------------------
define func1
    @echo "My name is \$(0)"     #\$(0)表示取函数名
endef

define func2
    @echo "My name is \$(0)"
    @echo "Param => \$(1)"
endef





---------------------------------------------------------------
Makefile
---------------------------------------------------------------
include scripts/Makefile.lib
srctree :=
xxx ?= \$<
yyy ?= \$@

all: _all



_all:
    @echo "hello"
    \$(call func1, param)
    \$(call func2, param)
---------------------------------------------------------------


# make
hello
My name is func1
My name is func2
Param =>  param




EOF

