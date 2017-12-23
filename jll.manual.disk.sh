#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


mount >&1 << EOF

fdisk /dev/sdX
...

partprobe
mkfs.ext4  /dev/sdXn


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
​
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

