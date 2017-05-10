#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 <<EOF

Create an empty swap image with 8GB size
# dd if=/dev/zero of=./ext_8g.swap bs=1024 count=\$((1024*1024*8))
8388608+0 records in
8388608+0 records out
8589934592 bytes (8.6 GB) copied, 199.082 s, 43.1 MB/s

Format the ext_8g.swap as swap filesystem
# mkswap ./ext_8g.swap
Setting up swapspace version 1, size = 8388604 KiB
no label, UUID=d903b661-8728-48ff-941b-1b71ba97a43b

Enable ext_8g.swap
# swapon  ./ext_8g.swap

Disable ext_8g.swap
# swapoff ./ext_8g.swap

Query the status of swap
# swapon -s

For persist swap
# vim  /etc/fstab
/home/tpv/QemuKvm/QemuUbuntu14/ext_8g.swap swap swap defaults 0 0
/dev/sda3 swap swap defaults 0 0

EOF

