#!/bin/bash

if [ $# -ne 3 ]; then
cat >&1<<EOF

    $0 username  password   ftp-path-to-file

    For example:
         $0  linjielong  ib***e  /img/L170H/xxx/yyy

EOF

    exit 0
fi

wget -nH  -m  --restrict-file-names=nocontrol --ftp-user=$1 --ftp-password=$2 ftp://ftp.reachxm.com/$3


