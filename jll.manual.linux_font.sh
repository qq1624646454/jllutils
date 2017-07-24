#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.linux_font.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-24 10:06:31
#   ModifiedTime: 2017-07-24 10:06:31

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source  ${JLLPATH}/BashShellLibrary 

more >&1<<EOF

${Bgreen}                                              ${AC}
${Bgreen} ${AC}${Fwhite} How to Install Ubuntu Font ${AC}
${Bgreen}                                              ${AC}

${Fgreen}Please download TTF: Consolas for Powerline FixedD Regular${AC}
https://en.fontke.com/family/968145/style?fromlang=zh_CN

${Fgreen}Please double click CONSOLA-Powerline.ttf to install ${AC}

EOF

