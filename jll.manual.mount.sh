#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


cat >&1 << EOF

mount -t iso9660 <YourISO>  <MountPath>  -o loop,offset=0

mount -o remount,rw <Partition> <MountPath>
  SUCH AS:
    mount -o rw,remount /dev/block/mmcblk0p6 /system


FOR Android:
    mount -o rw,remount <MountPath>
    mount -o rw,remount <partition>
  SUCH AS:
    mount -o rw,remount /system
    mount -o rw,remount /dev/block/mmcblk0p6 


FOR nfs:
mount -v -t nfs -o nfsvers=3 xmnb4003161.tpvaoc.com:/C/Android  Desktop

umount -f Desktop # if nfs is break

EOF

