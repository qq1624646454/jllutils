#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubifs.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-03-29 17:19:01
#   ModifiedTime: 2018-04-01 21:53:33

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more>&1<<EOF

apt-get install mtd-utils

-----------------------------------------------------------------------------------------------
How do I use NAND simulator?

NAND simulator (nandsim) is an extremely useful debugging and development tool which simulates 
NAND flashes in RAM or a file. To select the simulated flash type one should specify ID bytes 
of your flash - the ones which are returned by the "Read ID" command (0x90) - consult the flash
manual. The following are examples of input parameters:

modprobe nandsim first_id_byte=0x20 second_id_byte=0x33 #16MiB, 512 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0x35 #32MiB, 512 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0x36 #64MiB, 512 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0x78 #128MiB, 512 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0x71 #256MiB, 512 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0xa2 third_id_byte=0x00 fourth_id_byte=0x15 #64MiB, 2048 bytes page;
modprobe nandsim first_id_byte=0xec second_id_byte=0xa1 third_id_byte=0x00 fourth_id_byte=0x15 #128MiB, 2048 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0xaa third_id_byte=0x00 fourth_id_byte=0x15 #256MiB, 2048 bytes page;
modprobe nandsim first_id_byte=0x20 second_id_byte=0xac third_id_byte=0x00 fourth_id_byte=0x15 #512MiB, 2048 bytes page;
modprobe nandsim first_id_byte=0xec second_id_byte=0xd3 third_id_byte=0x51 fourth_id_byte=0x95 #1GiB, 2048 bytes page;

---------------------
挂载ubi镜像
---------------------
#(1).模拟一个基于nandflash的设备: /dev/mtd0,大小1GB,页大小为2KB
modprobe nandsim first_id_byte=0xec second_id_byte=0xd3 third_id_byte=0x51 fourth_id_byte=0x95 #1GiB, 2048 bytes page;

#(2).查看nandflash设备信息
cat /proc/mtd
#dev:    size   erasesize  name  mtd0: 40000000 00040000 "NAND simulator partition 0"   

mtdinfo /dev/mtd0

#(3).将ubi与/dev/mtd0进行关联，即在ubifs文件系统中让ubi_ctrl代表/dev/mtd0这个设备
modprobe ubi mtd=0

#(4).格式化前先解绑定,因为关联时会默认绑定/dev/ubi_ctrl和/dev/mtd0
ubidetach /dev/ubi_ctrl -m 0

#(5).格式化：意思就是把镜像文件按照/dev/mtd0的页大小等硬件flash格式烧写到这个设备空间中.注意：这里要加上 -O 2048 的选项，
#            显式表明 UBI_VID_HDR 的偏移位置是 2KB，而不是默认值。从上面 mtdinfo /dev/mtd0 的输出结果中，有一项
#            Sub-page size 的选项，如果不用 -O 显示指定，默认偏移值则是 sub-page size
ubiformat /dev/mtd0 -s 2048 -f mdm9607-sysfs.ubi

#(6).重新绑定/dev/ubi_ctrl和/dev/mtd0,注意：仍然要显式加上 -O 2048 的选项
ubiattach /dev/ubi_ctrl -m 0 -O 2048

#(7).创建一个挂载点,并按照ubi文件系统格式进行挂载
mkdir ubifs_mnt 
mount -t ubifs ubi0 ubifs_mnt 

至此，挂载完成，进入ubifs_mnt就可以看到mdm9607_sysfs.ubi的文件系统的具体内容了


*********************************************************************************************
反向制作ubi镜像:
    由前面挂载了一个ubi镜像后，经过定制，需要重新打包生成ubi镜像
---------------------------------------------------------------------------------------------
#(1).定制内容：
cd ubifs_mnt
echo "hello" > hello #假如我的定制就是加个带有“hello"的hello文件

#(2).通过mkfs.ubifs生成临时的ubi镜像:
#    -m - Minimum I/O unit size. 即页大小，由前面得知为 2KB。  
#    -e - Logical Erase Block (LEB) size. 由前面计算得为 248KB，即 253952。  
#    -c - Max LEB count. (vol_size/LEB). 通过 mtdinfo /dev/mtd0 输出结果中的 Amount of eraseblocks
#         可得。 
#    -r - Path.    ubifs_new.img - Temporary image file
mkfs.ubifs -m 2048 -e 253952 -c 4096 -r ubifs_mnt ubifs_new.img 

#(3).通过ubinize生成ubi镜像: 
#    首先要准备一个配置文件，内容如下，文件名为 ubi.ini
#    [ubi_rfs]
#    mode=ubi
#    image=ubifs.img
#    vol_id=0
#    vol_size=6856704   // ubifs.img 的大小
#    vol_type=dynamic
#    vol_name=userdata  //分区卷标名，可以随便取，但最好与原来的镜像保持一致 
#    vol_alignment=1 
#    vol_flags=autoresize
#
#  ubinize的参数：
#    -o - Output file.  
#    -p - Physical Erase Block (PEB) size. 由前面分析得 PEB 为 256KB，即 262144。
#    -m - Minimum I/O unit size. 即页大小 4KB。 
#    -s - Minimum I/O size for UBI headers, eg. sub-page size. Sub-page size，从 mtdinfo /dev/mtd0 
#         的结果中可以得知。
#    -O - VID header offset from start of PEB. UBI_VID_HDR 的偏移，由前面分析得为 4KB。
#    ubi.ini - UBI image configuration file.
#  
ubinize -o userdata.ubi -p 262144 -m 2048 -s 1024 -O 2048 ubi.ini


--------------------------------
如何使用UBIFS
--------------------------------
1.使用nfs启动系统, 首先建立设备节点： 
    以下操作可以用mdev -s 生成
     mknod /dev/ubi_ctrl c 10 58
     mknod /dev/ubi0 c 250 0
2.执行以下命令挂载ubifs：
     1.flash_eraseall /dev/mtd8 #擦出分区
     2.ubiattach /dev/ubi_ctrl -m 8 –O  #建立关联
     3.ubimkvol /dev/ubi0 -N rootfs -s 30MiB

           ubimkvol创建容量, -s 是设置大小 ，  此步的作用在于mtd8中没有烧录数据之前需要通过此步才可以挂载文件系统到挂载点下。由于此处用的是nfs和tar组合烧录，所以需要先挂载ubi设备文件到挂载点，才能进行解压，因此在挂载之前需要这一步。如果已经将镜像焼写到了相应块设备中，则可以免去这一句。  关于tar焼写文件的原理：  将任何一个文件夹下的目录进行tar打包之后，它们都是以二进制的文件存在，是脱离于文件系统的，将他们解压到某一个目录时，此目录的文件系统格式，就决定了它们在设备上的摆放方式，也就决定了它们在设备上所处的文件系统类型。如果tar了所有rootfs所具备的资源，并将他们tar vf –C 到ubi文件系统类型的目录下，那么它们无异与被写入了目录所挂载的相应的块设备，并以ubi文件系统的格式存在，那么和用nand write 或 flashcp 将用mkfs.ubifs  flashcp –v /opt/mtc/xxxx.ubifs  /dev/mtd8  制作出来的的rootfs镜像没有区别，只是在生产时，有一定的限制，所以最好还是用nand write 提前焼写到nand flash在内核中对其的所分的相应分区地址空间内。如下：

EOF

