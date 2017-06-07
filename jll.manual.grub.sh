#!/bin/bash
# Copyright (c) 2016 - 2100.   jielong.lin     All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

jll@S~\$ ${Fyellow}su - root${AC}
 # cat /boot/grub/grub.cfg | grep Windows
 # grub-set-default "Windows 7 (loader) (on /dev/sda1)"
 # grub-editenv list
 # grub-mkconfig -o /boot/grub/grub.cfg

EOF

