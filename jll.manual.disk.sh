#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


more >&1 << EOF

root@RS82:/# ${Bblue}umount /jllim2 ${AC}
root@RS82:/# ${Bblue}fsck.ext4 /dev/sdb2 ${AC}
e2fsck 1.42.9 (4-Feb-2014)
ibbyte1024MB contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 6685636 has an invalid extent node (blk 27481116, lblk 0)
Clear<y>? ${Bblue}yes${AC}

HTREE directory inode 6685636 has an invalid root node.
Clear HTree index<y>? ${Bblue}yes${AC}
Inode 6685636 is a zero-length directory.  Clear<y>? ${Bblue}yes${AC}
HTREE directory inode 6693034 has an invalid root node.
Clear HTree index<y>? ${Bblue}yes${AC}







root@REACHXM82:/honor# lsblk -a -d -o name,rota
NAME  ROTA
sda      1  #HDD
sdb      1  #HDD
sdc      0  #SSD
sdd      1  #HDD
sde      1
loop0    1
loop1    1
loop2    1
loop3    1
loop4    1
loop5    1
loop6    1
loop7    1


root@REACHXM82:/honor# lsblk  -a
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 298.1G  0 disk
└─sda1   8:1    0 298.1G  0 part /honor
sdb      8:16   0   1.8T  0 disk
├─sdb1   8:17   0   512G  0 part /repository
└─sdb2   8:18   0     1T  0 part /ws
sdc      8:32   0 223.6G  0 disk
├─sdc1   8:33   0   6.4G  0 part [SWAP]
├─sdc2   8:34   0  96.1G  0 part /
└─sdc3   8:35   0 121.1G  0 part /VM
sdd      8:48   0   1.8T  0 disk
├─sdd1   8:49   0 428.4G  0 part /workspace1
├─sdd2   8:50   0  37.6G  0 part /miscellaneous
└─sdd4   8:52   0   1.4T  0 part /workspace2
sde      8:64   1         0 disk
loop0    7:0    0         0 loop
loop1    7:1    0         0 loop
loop2    7:2    0         0 loop
loop3    7:3    0         0 loop
loop4    7:4    0         0 loop
loop5    7:5    0         0 loop
loop6    7:6    0         0 loop
loop7    7:7    0         0 loop



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

