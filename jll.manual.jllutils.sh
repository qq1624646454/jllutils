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
cd - >/dev/null

${Fpink}# install jllutils contained registed path into ~/.bash ${AC}
${Fpink}# and auto align from git remote repository. ${AC}
cd ~/github.com/qq1624646454/jllutils
./____install_jllutils.sh
cd - >/dev/null


${Fpink}# For a developer, maybe need to setup ssh keys into ~/.ssh and ~/.sshconf ${AC}
${Fpink}# and meanwhile Push URL will be changed to ssh format rather than https ${AC}
${Fpink}# please next to do the follows: ${AC}
cd ~/github.com/qq1624646454/jllutils
./jll.sshconf.sh
${Fpink}# please select the item \"installing: setup ssh keys then let jllutils over SSH\" ${AC}
git remote show origin
cd - >/dev/null



${Fpink}# wanna the other project also support for the auto align from git remote repository ${AC}
${Fpink}# please next to do the follows: ${AC}
tar -zvxf AUTO_TOOL_OVER_LINUX.tgz -C [YourTargetFolder]
cd [YourTargetFolder]
${Fseablue}# please modify ____install_auto_sync.sh for crontab triggerred actived time.${AC}
./____install_auto_sync.sh
cd - >/dev/null


EOF


