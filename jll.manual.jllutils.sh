#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

if [ x"\$(dpkg --get-selections | grep git)" = x ]; then \\
    aptitude install -y git git-svn git-doc git-email git-gui gitk gitweb \\
fi

mkdir -pv /home/\$(whoami)/Vanquisher
cd /home/\$(whoami)/Vanquisher

git clone git@code.csdn.net:x13015851932/jllutils.git



EOF


