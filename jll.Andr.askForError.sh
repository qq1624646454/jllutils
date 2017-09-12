#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.Andr.askForError.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-09-12 09:28:02
#   ModifiedTime: 2017-09-12 09:31:26

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}${Fyellow}status_t error:${AC}
${Fyellow}bionic/libc/kernel/uapi/asm-generic/errno-base.h${AC}

${Fyellow}system/core/include/utils/Errors.h${AC}



EOF

