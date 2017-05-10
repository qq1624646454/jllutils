#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.jllserver.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-04-18 23:51:20
#   ModifiedTime: 2017-04-19 00:07:02

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1 <<EOF

==========================================================================
  [ Remote:: JllServer ] <---------------> [ Localhost:: Windows7 ]
   192.168.1.110                              192.168.1.11
==========================================================================
  # echo \$DISPLAY
  
  # export DISPLAY=192.168.1.11:0.0
  # echo \$DISPLAY
  192.168.1.11:0.0
  # xterm
      |
      |                                Ask for setupping and running VcXsrv.exe
      \                                And the follows Application will be run by
       \                               automatically:
        \                                   +---------------------------+
         -------------------------------->  | xterm              [] _ X |
                                            |---------------------------|
                                            |jll@linux #                |
                                            |                           |
                                            |                           |
                                            +---------------------------+


EOF

