#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


mount >&1 << EOF

fdisk /dev/sdX
...

partprobe
mkfs.ext4  /dev/sdXn


EOF

