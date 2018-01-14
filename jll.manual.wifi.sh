#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.wifi.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-12-25 14:15:05
#   ModifiedTime: 2017-12-25 14:15:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF
 
最后更新： 2017 年 12 月 15 日
LINUX / RASPBERRYPI / 随意CODING
RTL8188cus开启监听模式
由 FIND · 发布日期 2015年11月19日 · 已更新 2015年11月19日 3,100 看过

目录	
Pre
步骤
STEP 0: Update existing modules and kernel to latest更新现有的kernel和模块到最新版本
STEP 1: Get the raspbian kernel source and add missing dependencies获取最新的raspbian 内核源码并安装依赖
STEP 2: Enable the rtlwifi (kernel) drivers for RTL8188CUS (RTL8192)用rtlwifi的驱动代替原来的rtl8188cus
STEP 3: Compile and install kernel (took many hours)编译和安装内核
STEP 4: Reboot
STEP 5: Check that the rtlwifi/rtl8192cu module is loaded检查新驱动是否成功加上了
STEP 6: 安装iw工具
STEP 7查看是否支持监听模式
STEP 8开启监听模式
后续
Pre
去年买了树莓派之后，又买了个免驱的无线网卡，查看芯片是RTL8188cus，看wiki无线网卡的列表它是支持monitor模式的，但是实际使用的时候，并不能开启监听模式。
在贴吧的贴子讨论，时隔一年，断断续续的回复下，终于有人在stackoverflow上发现了有用的讨论。

Raspbian官方不能开是因为rtlwifi这驱动在arm上不稳定，所以被屏蔽了，换成realtek官方的驱动了。这个官方的驱动代码是2013年释出的，所以很多功能并不支持。只要重新编译rtlwifi驱动到内核里面就可以了。

下面整理一下整个步骤。

步骤
STEP 0: Update existing modules and kernel to latest更新现有的kernel和模块到最新版本
sudo apt-get update
sudo rpi-update
uname -a
Linux raspberrypi 4.1.7+ #815 PREEMPT Thu Sep 17 17:59:24 BST 2015 armv6l GNU/Linux
STEP 1: Get the raspbian kernel source and add missing dependencies获取最新的raspbian 内核源码并安装依赖
git clone --depth=1 https://github.com/raspberrypi/linux
sudo apt-get install bc lshw
STEP 2: Enable the rtlwifi (kernel) drivers for RTL8188CUS (RTL8192)用rtlwifi的驱动代替原来的rtl8188cus
leafpad linux/drivers/net/wireless/Kconfig
找到下面一行，去掉前面的#
#source "drivers/net/wireless/rtlwifi/Kconfig"
找到下面一行，在前面加上#
source "drivers/net/wireless/rtl8192cu/Kconfig"
编辑makefile
leafpad linux/drivers/net/wireless/Makefile
找到下面一行，去掉前面#
#obj-$(CONFIG_RTLWIFI)         += rtlwifi/
STEP 3: Compile and install kernel (took many hours)编译和安装内核
cd linux
KERNEL=kernel
make bcmrpi_defconfig
#下面这行，我第一天中午开始跑，第二天早上看到跑完了。。。
make zImage modules dtbs
sudo make modules_install
下面的可以直接复制到脚本里运行脚本：

sudo cp arch/arm/boot/dts/*.dtb /boot/
sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
sudo scripts/mkknlimg arch/arm/boot/zImage /boot/$KERNEL.img
STEP 4: Reboot
sudo reboot

STEP 5: Check that the rtlwifi/rtl8192cu module is loaded检查新驱动是否成功加上了
lsmod | fgrep rtl8192cu

rtl8192cu             100806  0 
rtl_usb                14781  1 rtl8192cu
rtl8192c_common        72091  1 rtl8192cu
rtlwifi               101122  3 rtl_usb,rtl8192c_common,rtl8192cu
mac80211              623281  3 rtl_usb,rtlwifi,rtl8192cu

lshw
  *-network:0
       description: Ethernet interface
       physical id: 1
       bus info: usb@1:1.3
       logical name: wlan0
       serial: 00:0b:81:94:e9:a3
       capabilities: ethernet physical
       configuration: broadcast=yes driver=rtl8192cu driverversion=4.1.7+ firmware=N/A link=no multicast=yes
STEP 6: 安装iw工具
默认的iwconfig工具还是没法开启监听模式，安装iw这个工具，

sudo apt-get install iw -y
查看可用的物理网卡

iw dev

phy#0
    Interface wlan0
        ifindex 3
        wdev 0x1
        addr e8:4e:06:20:22:fc
        type managed
        channel 6 (2437 MHz), width: 40 MHz, center1: 2447 MHz

STEP 7查看是否支持监听模式
iw phy phy0 info
... lots of stuff 忽略...
Supported interface modes:
     * IBSS
     * managed
     * AP
     * AP/VLAN
     * monitor（看到这个说明支持）
     * mesh point
     * P2P-client
     * P2P-GO
... lots more stuff 忽略...
STEP 8开启监听模式
从这里就可以参考树莓派(RASPBERRYPI)安装AIRCRACK-NG,REAVER及WIFI破解教程[整理]
注意在执行到sudo airmon-ng start wlan0的时候，应该还是提示错误，但是可以通过运行

sudo airmon-ng check kill
结束所有阻碍它开启的进程，然后start就可以了

后续
开启监听模式后，会关闭它的wifi连接功能，所以必须要外接显示器和键盘操作。
但是我印象中，使用另外一个型号无线网卡的时候，开启了monitor模式之后，仍可以连接wifi。而且在当前这个小网卡上，开启的interface是wlan0mon而不是mon0，所以在上面的破解教程里，所有mon0都要改成wlan0mon
另外我在实验中，开始运行破解命令之后，一直都提示failed to associate with ...问题，这个应该是说无线关闭了wps功能，但是连接任何wifi都是这样的，就不禁让我怀疑哪里出了问题，难道周围人都这么有警惕性？？我用平板开了个热点，终于连上了，但是破解仍有问题。一直都是持续的receive timeout (0x03), or WPS transaction fail (0x02)。最终我放弃了，没有继续让它跑下去，希望各位如有结果，请回来告知。
这个问题可以参考Constant receive timeout (0x03), or WPS transaction fail (0x02) with rtl8187

可以先通过wash -i wlan0mon -C这个命令扫描开启了wps的。

文章版权归 FindHao 所有丨本站默认采用CC-BY-NC-SA 4.0协议进行授权|
转载必须包含本声明，并以超链接形式注明作者 FindHao 和本文原始地址：
https://www.findhao.net/easycoding/1498
你可能喜欢：(相似内容推荐和广告都使用了谷歌的推荐系统，需要对本站取消广告屏蔽才能显示。感谢点击↓广告支持博主～)

 

 
标签： raspberrypi树莓派硬件


Find
新浪微博（FindHaoX86）QQ群：不安分的Coder（375670127）  不安分的Coder

下一篇
以太网的以太的由来
上一篇
AndroidStudio设置外观
8 条回复

评论8
引用通告0
梦里茶  2017年12月10日 下午12:14
树莓派3B内核默认编译了rtlwifi和rtl8192的驱动，但iwconfig wlan0 mode monitor还是提示set failed invalid argument. 下载最新内核去掉rtl8192驱动，只保留rtlwifi驱动编译，结果依旧，楼主知道在树莓派3B上应该怎么解决吗

回复
Find  2017年12月10日 下午12:43
这篇文章已经很早啦。
你可以尝试用iw命令？我看到文章里记录说 “默认的iwconfig工具还是没法开启监听模式，安装iw这个工具”

回复
梦里茶  2017年12月10日 下午5:20
问题解决啦！3B上的raspbian里是有rtlwifi驱动的，需要把rtl8192驱动关闭，把rtlwifi驱动打开：https://github.com/ahangchen/windy-afternoon/blob/master/raspbian/rtlwifi.md

回复
zwq939681378  2016年2月25日 下午11:17
贴吧的回复，pi2的运行方法
RASPBERRY PI 1 (OR COMPUTE MODULE) DEFAULT BUILD CONFIGURATION
cd linux
KERNEL=kernel
make bcmrpi_defconfig
pi 1 和 pi2 是不一样的
RASPBERRY PI 2 DEFAULT BUILD CONFIGURATION
cd linux
KERNEL=kernel7
make bcm2709_defconfig
编译完就可以用

回复
wu1169668869  2016年1月28日 上午12:54
不知道博主用的什么版本的pi
我重新刷了官方的2015-05-05-raspbian-wheezy.img
然后照着博主的流程一步步下来，结果还是没能装上驱动。
iw list 提示 nl80211 not found…
哦对，我用的是pi2 B v1.1的板子 + rtl8188cus

回复
Find  2016年1月28日 下午4:23
我是一代b+

回复
撑伞s  2015年12月8日 下午12:08
你好，我按照你的流程做之后，在树莓派的命令行里输入iwconfig ，出现的是wlan0 no wireless extensions，其他的lo, eth0都是这样，也无法跑脚本程序去probe，请问你有解决的办法吗？

回复
Find  2015年12月8日 下午7:48
抱歉，没有遇到这样的情况。


EOF


