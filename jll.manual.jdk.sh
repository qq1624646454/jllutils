#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.jdk.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-10-17 09:36:32
#   ModifiedTime: 2017-10-17 09:44:15

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

${Bgreen}${Fblack}                               ${AC}
${Bgreen}${Fblack}  jdk is installed on Win7     ${AC}
${Bgreen}${Fblack}                               ${AC}

After jdk was installed on Win7, please run setenv_jdk_jre.bat to
registe the system environment variables about jdk and jre. 

    JAVA_HOME="C:\\Program Files\\Java\\jdk1.8.0_121"
    CLASSPATH=".;%%JAVA_HOME%%\\lib\\tools.jar;%%JAVA_HOME%%%\\lib\\dt.jar"
    PATH="%%JAVA_HOME%%\\bin;%%PATH%%"

EOF

