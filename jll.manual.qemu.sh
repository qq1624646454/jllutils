#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

aptitude install  qemu-kvm qemu-system qemu-utils



-------------------
  Full Screen 
-------------------
Enter the Qemu, type Ctrl_ALT_F to switch to full screen mode.
Back to original screen mode by Ctrl_ALT_F




-------------------
  Load USB device
-------------------
After start Qemu-KVM, press Ctrl_ALT_2 to enter QEMU-Consolo mode,
Please type "info usb" to lookup the guest usb information.
And type usb_add host:xxx:xxx to add the new usb device.

Back to Guest OS by Ctrl_ALT_1



-------------------
  Mouse not sync
-------------------
add the startup parameters as follows:
-usb -usbdevice tablet \\



--------------------
 -bios 
--------------------
Only for windows7 activied with ACER OEM
for other system, such as Ubuntu/Debian linux, not suggest to use it.



--------------------
 -no-acpi
--------------------
may cause that system shutdown failure



--------------------
 -vga qxl 
--------------------
may cause that system startup failure




-----------------------------
 vgabios　（玩转显卡透传） 
-----------------------------
vgabios.bin is available referenced to:
    http://www.techpowerup.com/vgabios
Debian KVM VGA Passthrough (透传) referenced to:
    https://wiki.debian.org/VGAPassthrough#Introduction
Very details:
    https://bbs.archlinux.org/viewtopic.php?id=162768





---------------------
 Qemu GUI very slower 
---------------------
Maybe Guest System Platform do not install the GUI (such as Gnome3)
so aptitude install gdm3 to install the gdm3, namely gnome3 should be installed.






---------------------
 Ubuntu 12.10 on Qemu
---------------------
# vim QemuRuner_Linux.sh
 ...
 5      GvCONF_img=/fight4honor/LinuxFromScratch/workspace/Ubuntu@Qemu.img
 ...
 13     GvCONF_mac="00:04:23:10:28:56"  # mac_address is made from 00:\$(date +%m:%d:%H:%M:%S)
 14     if [ x"\${GvCONF_BIOS}" = x -o -e "\${GvCONF_BIOS}" ]; then \
 15         GvBIOS="-bios \${GvCONF_BIOS}"  \
 16     else
 17         GvBIOS=""
 18     fi
 ...
 51     qemu-system-x86_64 -enable-kvm \\
 52                        -cpu host \\
 53                        -smp 4 \\
 54                        -m 4096 \\
 55                        -usb -usbdevice tablet \\
 56                        \${GvBIOS} \\
 57                        -rtc base=localtime,clock=host \\
 58                        -net nic,vlan=0,macaddr=\${GvCONF_mac},model=rtl8139,name=QemuNIC \\
 59                        -net tap,vlan=0,name=QemuNIC,ifname=tap1,script=no,downscript=no \\
 60                        -boot c \\
 61                        -hda \${GvCONF_img} \\
 62                        #-vga qxl  #maybe startup failure
 63                        #-no-acpi  #maybe shutdown failure 







EOF

