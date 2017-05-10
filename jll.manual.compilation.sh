#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

#
# build-essential is a set of compilation tools contained gcc, g++, make, libc and so on.
#
  aptitude install build-essential

#
# man -a printf
# man 1 printf
# man 3 printf
#
  aptitude install manpages-dev



EOF


