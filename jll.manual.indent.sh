#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.indent.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-08-22 00:57:27
#   ModifiedTime: 2019-08-22 00:57:27

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

indent -st -orig --ignore-newlines -nut -l100 -nfca -ncdb -npsl -nbc -di8 -sob test_style.c | \\
indent -st -orig --ignore-newlines -nut -l100 -nfca -ncdb -npsl -nbc -di8 -sob | \\
indent -st -orig --ignore-newlines -nut -l100 -nfca -ncdb -npsl -nbc -di8 -sob | \\
indent -st -orig --ignore-newlines -nut -l100 -nfca -ncdb -npsl -nbc -di8 -sob



EOF

