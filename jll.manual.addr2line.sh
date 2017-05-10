#!/bin/bash
#
# Coyright(c) 2016-2100.   jielong.lin.   All rights reserved.


cat >&1 <<EOF

addr2line -f -e <YourFile> <YourAddr>

@ <YourFile>: file is seen in log
@ <YourAddr>: address is seen in log
@ -f: output function

EOF



