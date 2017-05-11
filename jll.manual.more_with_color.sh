#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.more_with_color.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 10:19:56
#   ModifiedTime: 2017-05-11 10:25:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<GEOF

more \>\&1\<\<EOF

[ESC] should be expressed to ^[ by [Ctrl]+[v]+[ESC] rather than \033

Example For:
  ERROR:  \033[0m\033[31m\033[43m world \033[0m
  GOOD:   ^[[0m^[[31m^[[43m world ^[[0m
          [0m[31m[43m world [0m

EOF

GEOF


