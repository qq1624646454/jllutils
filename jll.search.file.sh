#!/bin/bash
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary



if [ x"$1" != x -a x"$2" != x ]; then

cat >&1 << EOF

    find . -type f -a -name "$1" -print | grep -Ei "$2"

EOF

    find . -type f -a -name "$1" -print | grep -Ei "$2"

else
cat >&1 << EOF

${CvScriptName} "<YourFileOrType>" "<KeyWord>"

Example:
    ${CvScriptName} "*.deb" "ncurser"


find . -type f -a -name "\$1" -print | grep -Ei "\$2"


EOF
fi


exit 0

