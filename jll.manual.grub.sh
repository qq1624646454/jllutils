#!/bin/bash
# Copyright (c) 2016 - 2100.   jielong.lin     All rights reserved.
#

cat >&1 << EOF
 $ su - root
 # cat /boot/grub/grub.cfg | grep Windows
 # grub-set-default "Windows 7 (loader) (on /dev/sda1)"
 # grub-editenv list
 # grub-mkconfig -o /boot/grub/grub.cfg

EOF

