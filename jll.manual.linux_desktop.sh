#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.linux_desktop.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-20 13:29:45
#   ModifiedTime: 2017-07-20 14:21:17

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Fseablue}sudo aptitude update${AC}
${Fseablue}sudo aptitude install ubuntu-desktop${AC}
...
Setting up lightdm (1.2.3-0ubuntu2.8) ...
Adding group 'lightdm' (GID 128) ...
Done.
Adding system user 'lightdm' (UID 115) ...
Adding new user 'lightdm' (UID 115) with group 'lightdm' ...
Creating home directory '/var/lib/lightdm' ...
usermod: no changes
usermod: no changes
usermod: no changes
Adding group 'nopasswdlogin' (GID 129) ...
Done.
Setting up python-xkit (0.4.2.3build1) ...
...
update-initramfs: Generating /boot/initrd.img-3.13.0-32-generic
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168g-3.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168g-2.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8106e-2.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8106e-1.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8411-2.fw for module r8169
Processing triggers for libgdk-pixbuf2.0-0 ...
Current status: 172 updates [-49].

${Fseablue}sudo reboot${AC}

${Fyellow}# login if met the issue about "Failed to load session "ubuntu"${AC}
${Fyellow}# please check if ubuntu-desktop is installed or not" ${AC}
${Fseablue}sudo dpkg --get-selections | grep -i ubuntu
...
ubuntu-desktop                                  install
${Fyellow}# if ubuntu-desktop is not installed, maybe need to install it again.${AC}
${Fseablue}sudo aptitude install ubuntu-desktop${AC}

${Fseablue}sudo reboot${AC}

EOF

