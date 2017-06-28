#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

${Fpink}# Please install git tool ${AC}
if [ x"\$(dpkg --get-selections | grep git)" = x ]; then \\
    aptitude install -y git git-svn git-doc git-email git-gui gitk gitweb \\
fi

mkdir -pv ~/github.com/qq1624646454

${Fpink}# For a User, please do the follows: ${AC}
cd ~/github.com/qq1624646454
git clone https://github.com/qq1624646454/jllutils.git
cd jllutils
cd - >/dev/null


# For a developer, please next to do the follows:
cd ~/github.com/qq1624646454/jllutils
./jll.sshconf.sh
cd - >/dev/null


# Build the auto align from remote git repository
tar -zvxf AUTO_TOOL_OVER_LINUX.tgz -C [YourTargetFolder]
cd [YourTargetFolder]
please modify ____install_auto_sync.sh for crontab triggerred actived time.
./____install_auto_sync.sh



EOF


