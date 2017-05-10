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

mkdir -pv ~/github

# For a User, please do the follows:
cd ~/github
git clone https://github.com/qq1624646454/jllutils.git
cd - >/dev/null



# For a developer, please next to do the follows:
cd ~/github/jllutils
./jll.sshconf
cd - >/dev/null


EOF


