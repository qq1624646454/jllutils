#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.vim.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-07 20:56:02
#   ModifiedTime: 2017-06-07 21:01:57

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF
${AC}${Fgreen}
文件内部替换${AC}
${Fseablue}1)在全部内容的行首添加//号：${Fyellow}
:% s/^/\/\//g${AC}
${Fseablue}2)在2~50行的行尾添加#号: ${Fyellow}
:2,50 s/$/#/g${AC}
${Fseablue}3)在2~50行的行首删除//号： ${Fyellow}
:2,50 s/^\/\///g

EOF

