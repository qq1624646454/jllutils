#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

debian.8.3 jessie - gnome3

====================================================
 Lookup the release version 
---------------------------
User@Linux:~$  lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 14.04.4 LTS
Release:        14.04
Codename:       trusty





====================================================
 Setting for gnome
-----------------------

$ hwclock --systohc --localtime 


$ gnome-tweak-tool

<<Desktop>>
Icons on Desktop
[*] Home
[ ] Network Servers
[*] Trash
[*] Mounted Volumes


<<Appearance>>
Theme
Window       Simple
GTK+         Adwaita(default)
Icons        Gnome(default)
Cursor       Adwaita(default)
Shell theme  ...

====================================================
 Disable the screen saver:
----------------------------

# xset s off
# xset -dpms

# xset q

Modification HandleLidSwitch=ignore that tell system 
about don't suspend or hibernate when turn off lid of 
the laptop
# vim  /etc/systemd/logind.conf
--- #HandleLidSwitch=suspend
+++ HandleLidSwitch=ignore
:wq

# reboot


====================================================
 Lookup the services 
----------------------------
# service --status-all


====================================================
 dump Desktop Management Interface (DMI) included 
 Hardware and BIOS 
----------------------------
# dmidecode
# dmidecode -t bios
# dmidecode -s system-serial-number

Lookup the memory device information
# free
# meminfo

Want to know how much do the external memory for server
# dmidecode -t 16



      0   BIOS
        1   System
        2   BaseBoard
        3   Chassis
        4   Processor
        5   MemoryController
        6   MemoryModule
        7   Cache
        8   PortConnector
        9   SystemSlots
       10   On BoardDevices
       11   OEMStrings
       12   SystemConfiguration Options
       13   BIOSLanguage
       14   GroupAssociations
       15   System EventLog
       16   PhysicalMemory Array
       17   MemoryDevice
       18   32-bit MemoryError
       19   Memory ArrayMapped Address
       20   Memory DeviceMapped Address
       21   Built-inPointing Device
       22   PortableBattery
       23   SystemReset
       24   HardwareSecurity
       25   System PowerControls
       26   VoltageProbe
       27   CoolingDevice
       28   TemperatureProbe
       29   ElectricalCurrent Probe
       30   Out-of-bandRemote Access
       31   Boot IntegrityServices
       32   SystemBoot
       33   64-bit MemoryError
       34   ManagementDevice
       35   ManagementDevice Component
       36   ManagementDevice Threshold Data
       37   MemoryChannel
       38   IPMIDevice
       39   PowerSupply

====================================================
 How to cleanup memory page cache by system 
---------------------------------------------
# free -h
# echo 1 > /proc/sys/vm/drop_caches
# free -h



====================================================
 How to settings for backlight brightness 
---------------------------------------------
# echo 600 > /sys/class/backlight/intel_backlight/brightness



EOF

echo
echo
echo
echo    "===================================================="
echo    "   How to Calculate the size of some partition "
echo    "       (End-Start)*Units/(1024*1024*1024)"
echo    "===================================================="
echo    "Linux:~$ sudo fdisk -lu qemukvm.img "
echo    "[sudo] password for jielong.lin: "
echo
echo    "Disk qemukvm.img: 12.9 GB, 12884901888 bytes"
echo    "255 heads, 63 sectors/track, 1566 cylinders, total 25165824 sectors"
echo -e "Units = sectors of 1 * 512 = \033[0m\033[31m\033[43m512\033[0m bytes"
echo    "Sector size (logical/physical): 512 bytes / 512 bytes"
echo    "I/O size (minimum/optimal): 512 bytes / 512 bytes"
echo    "Disk identifier: 0x6fef3ae6"
echo
echo    "      Device Boot      Start         End      Blocks   Id  System"
echo -e "qemukvm.img1   *        \033[0m\033[31m\033[43m2048\033[0m    19531775     9764864   83  Linux"
echo    "qemukvm.img2        19531776    25163775     2816000   82  Linux swap / Solaris"
echo
echo    ">>> How to calculate the size of qemukvm.img1 ?"
echo    "((19531775-2048)*512)/(1024*1024*1024)"
echo
echo
echo
echo    "===================================================="
echo    "  How to mount qemukvm.img on Host OS"
echo    "===================================================="
echo    "Linux:~$ sudo fdisk -lu qemukvm.img "
echo    "[sudo] password for jielong.lin: "
echo
echo    "Disk qemukvm.img: 12.9 GB, 12884901888 bytes"
echo    "255 heads, 63 sectors/track, 1566 cylinders, total 25165824 sectors"
echo -e "Units = sectors of 1 * 512 = \033[0m\033[31m\033[43m512\033[0m bytes"
echo    "Sector size (logical/physical): 512 bytes / 512 bytes"
echo    "I/O size (minimum/optimal): 512 bytes / 512 bytes"
echo    "Disk identifier: 0x6fef3ae6"
echo
echo    "      Device Boot      Start         End      Blocks   Id  System"
echo -e "qemukvm.img1   *        \033[0m\033[31m\033[43m2048\033[0m    19531775     9764864   83  Linux"
echo    "qemukvm.img2        19531776    25163775     2816000   82  Linux swap / Solaris"
echo
echo -e "$ sudo mount ./qemukvm.img /mnt -o loop,offset=\033[0m\033[31m\033[43m\\\$((2048*512))\033[0m"
echo
echo
cat >&1<<EOF



====================================================
      Gnome GUI
  -------------------
  gdm3 - gnome 3
====================================================

root@JllServer:/fight4honor# aptitude install gdm3








====================================================
      Gnome GUI
  -------------------
  login by root account 
====================================================

root@JllServer:/fight4honor# vim /etc/pam.d/gdm-password
  1 #%PAM-1.0
  2 auth    requisite       pam_nologin.so
  3 #auth   required    pam_succeed_if.so user != root quiet_success
  4 @include common-auth

root@JllServer:/fight4honor# vim /etc/gdm3/daemon.conf 
 14
 15 [security]
 16 AllowRoot = true
 17



EOF


