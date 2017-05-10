#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.wget.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-03-09 15:56:24
#   ModifiedTime: 2017-03-09 15:59:09

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

# Obtain the website specified by URL
wget -c -r -np -k --timeout=3  URL
  e.g:
      wget -c -r -np -k --timeout=3   www.baidu.com
      w3m www.baidu.com/index.html


EOF

