#!/bin/bash
# Copyright (c) 2016 - 2100.   jielong.lin     All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

======================================================================================
||  How to set default item for grub
======================================================================================
jll@S~\$ ${Fyellow}su - root${AC}
jll@S~# ${Fyellow}vim /etc/default/grub ${AC}
...
${Bpink}${Fseablue}GRUB_DEFAULT=0 ${AC}
...


BUT, The below commands is invalid for ubuntu 12.10 After checking 
----------------------------------------------------------------------------------
jll@S~\$ ${Fyellow}su - root${AC}
jll@S~# ${Fyellow}cat /boot/grub/grub.cfg | grep Windows${AC}
...
jll@S~# ${Fyellow}grub-set-default "Windows 7 (loader) (on /dev/sda1)"${AC}
...
jll@S~# ${Fyellow}grub-editenv list${AC}
...
jll@S~# ${Fyellow}grub-mkconfig -o /boot/grub/grub.cfg${AC}



EOF

