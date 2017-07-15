#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.dd.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-15 10:56:07
#   ModifiedTime: 2017-07-15 10:56:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more>&1<<EOF

# make a file with size is 1KB
${Fseablue}dd if=/dev/zero of=./test_1kb bs=1K count=1${AC}

EOF

