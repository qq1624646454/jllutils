#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


more >&1 << EOF


------------------------------------------------------
 How to check if the new harddisk is the new or old?
------------------------------------------------------
root@REACHXM82:.# ${AC}${Fred}aptitude install smartmontools${AC}
The following NEW packages will be installed:
  heirloom-mailx{a} smartmontools 
0 packages upgraded, 2 newly installed, 0 to remove and 176 not upgraded.
Need to get 664 kB of archives. After unpacking 2,168 kB will be used.
Do you want to continue? [Y/n/?] y
Get: 1 http://cn.archive.ubuntu.com/ubuntu/ trusty-updates/universe heirloom-mailx amd64 12.5-2+deb7u1build0.14.04.1 [219 kB]
...
Setting up smartmontools (6.2+svn3841-1.2ubuntu0.1) ...
Processing triggers for ureadahead (0.100.0-16) ...
                                         
root@REACHXM82:.# 
root@REACHXM82:.# ${AC}${Fred}smartctl -A /dev/sdd${AC}
sdd   sdd1  sdd2  
root@REACHXM82:.# ${AC}${Fred}smartctl -A /dev/sdd${AC}
smartctl 6.2 2013-07-26 r3841 [x86_64-linux-4.4.0-134-generic] (local build)
Copyright (C) 2002-13, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF READ SMART DATA SECTION ===
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x002f   100   253   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0027   100   253   021    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       3
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x002e   100   253   000    Old_age   Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       0
 10 Spin_Retry_Count        0x0032   100   253   000    Old_age   Always       -       0
 11 Calibration_Retry_Count 0x0032   100   253   000    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       3
192 Power-Off_Retract_Count 0x0032   200   200   000    Old_age   Always       -       0
193 Load_Cycle_Count        0x0032   200   200   000    Old_age   Always       -       15
194 Temperature_Celsius     0x0022   112   112   000    Old_age   Always       -       31
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0030   100   253   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0008   100   253   000    Old_age   Offline      -       0

You can check the Power_On_Hours for confirm your harddisk is the new nor old.



--------------------------------------------------------------------------------------
fdisk /dev/sdX
...

partprobe
mkfs.ext4 -L VolumeName  /dev/sdXn


# bootable windows7 installer over udisk
Command (m for help): n
Partition type:
  p  primary (0 primary, 0 extended, 4 free)
  e  extended
Select (default p): p
Partition number (1-4, default 1):
Using default value 1
First sector (2048-15564799, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-15564799, default 15564799):
Using default value 15564799

Command (m for help): p


Disk /dev/sdb: 7969 MB, 7969177600 bytes
246 heads, 62 sectors/track, 1020 cylinders, total 15564800 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x8d55b9cb


  Device Boot      Start        End      Blocks  Id  System
/dev/sdb1            2048    15564799    7781376  83  Linux

上面/dev/sdb1就分出来了，全部的空间都给了sdb1

2. 然后把/dev/sdb1设置为启动分区

Command (m for help): a
Partition number (1-4): 1

Command (m for help): p


Disk /dev/sdb: 7969 MB, 7969177600 bytes
126 heads, 10 sectors/track, 12353 cylinders, total 15564800 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x8d55b9cb

  Device Boot      Start        End      Blocks  Id  System
/dev/sdb1  *        2048    15564799    7781376  83  Linux

我们可以看到，sdb1后面，多了个*

3. 接下来，把上面做的所有改动写入USB

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.

WARNING: Re-reading the partition table failed with error 22: Invalid argument.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
Syncing disks.

然后就是q退出

4. 将分区格式化为ntfs的

sudo mkfs -t ntfs /dev/sdb1

这个过程中，会把分区中写入全0，大概会等几分钟

5. 接下来就是把下载好的iso文件dd到这个启动分区了

# 把下载的iso文件刻录到usb的分区中（及得，一定是分区，否则下次用这个usb是会出现 Operating not found的问题
sudo dd if=/home/peter/Downloads/WindowsTechnicalPreview-x64-ZH-CN.iso of=/dev/sdb1 bs=4M iflag=direct​

看到了吧，我在安装win10

6. 现在还不可以从usb盘启动，还要在usb盘MBR区信息写入，这需要一个工具LILO

sudo apt-get install lilo
sudo lilo -M /dev/sdb mbr

下次启动的时候，选择这个USB启动就会出现windows的安装界面了！

另外，我自己也试了unetbootin，不过没有成功，选择从U盘启动后，一直卡在一个选择界面。大家有试成功的麻烦推荐下


EOF

