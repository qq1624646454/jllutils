#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.shared_library.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-01-14 11:05:11
#   ModifiedTime: 2020-01-14 16:54:35

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

shared library namely so file, it should be found by the followwing order when
it needs to run.
1.Specify the shared library path when application code is compiled.
  For Example:
      #The runtime shared library path is set by -Wl,-rpath,./
      gcc -o test main.c -L. -lmylib -Wl,-rpath,./
      
2.Environment variable named LD_LIBRARY_PATH can be set.
3.Access /etc/ld.so.conf to retrieve shared library path.
4.Default by /lib
5.Default by /usr/lib


EOF


