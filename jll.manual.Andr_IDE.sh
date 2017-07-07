#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.Andr_IDE.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-07 09:22:27
#   ModifiedTime: 2017-07-07 09:22:46

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF


${Bred}${Black}                                     ${AC}
${Bred}  ${AC} Could not reserve enough space for object heap
${Bred}${Black}                                     ${AC}


${Bgreen}${Fwhite}Here is how to fix it:${AC}

Go to Start->Control Panel->System->Advanced(tab)->Environment Variables->System
Variables->New: Variable name: _JAVA_OPTIONS

Variable value: -Xmx512M

Variable name: Path
Variable value: %PATH%;C:\Program Files\Java\jre6\bin;F:\JDK\bin;

Change this to your appropriate path.

