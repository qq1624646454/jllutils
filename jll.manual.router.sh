#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.router.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-11 01:08:26
#   ModifiedTime: 2017-11-11 01:30:29

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more>&1<<EOF

route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0 #增加一条到达244.0.0.0的路由。

route del -net 224.0.0.0 netmask 240.0.0.0

route add default gw 192.168.120.240

route del default gw 192.168.120.240



route -n
  Kernel IP routing table 
  Destination   Gateway         Genmask       Flags Metric Ref Use Iface 
  112.124.12.0  0.0.0.0         255.255.252.0 U     0      0   0 eth1 
  10.160.0.0    0.0.0.0         255.255.240.0 U     0      0   0 eth0 
  192.168.0.0   10.160.15.247   255.255.0.0   UG    0      0   0 eth0
  172.16.0.0    10.160.15.247   255.240.0.0   UG    0      0   0 eth0 
  10.0.0.0      10.160.15.247   255.0.0.0     UG    0      0   0 eth0 
  0.0.0.0       112.124.15.247  0.0.0.0       UG    0      0   0 eth1 

其中Flags为路由标志，标记当前网络节点的状态，Flags标志说明： 
U Up表示此路由当前为启动状态。 
H Host，表示此网关为一主机。 
G Gateway，表示此网关为一路由器。 
R Reinstate Route，使用动态路由重新初始化的路由。 
D Dynamically,此路由是动态性地写入。 
M Modified，此路由是由路由守护程序或导向器动态修改。 
! 表示此路由当前为关闭状态。

Gateway: *表示目标是本主机所属网络,不需要路由
         0.0.0.0表示直连到网络设备上的,目的地址是0.0.0.0的路由是你的缺省网关 


i # ifconfig bridge0
bridge0   Link encap:Ethernet  HWaddr 0A:55:0F:BF:CB:F1  
          inet addr:192.168.225.1  Bcast:192.168.225.255  Mask:255.255.255.0
          inet6 addr: fe80::855:fff:febc:c8ee/64 Scope:Link
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:76 (76.0 B)

/ # ip route
default dev rmnet_data0  scope link 
10.112.209.16/28 dev rmnet_data0  proto kernel  scope link  src 10.112.209.24 
192.168.10.0/24 dev bridge0  proto kernel  scope link  src 192.168.10.1 
192.168.225.0/24 dev bridge0  proto kernel  scope link  src 192.168.225.1 



EOF

