#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

cat >&1 << EOF

/jll/debian-8.2.0-i386-DVD-1/dists/
├── jessie
│   ├── contrib
│   ├── main
│   └── Release
└── stable -> jessie

deb file:/jll/debian-8.2.0-i386-DVD-1 stable main contrib

EOF


