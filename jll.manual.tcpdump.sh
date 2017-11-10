#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.tcpdump.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-11 01:50:29
#   ModifiedTime: 2017-11-11 01:53:55

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more>&1<<EOF

tcpdump [-i 网卡] -nnAX '表达式'

各参数说明如下：

    -i：interface 监听的网卡。
    -nn：表示以ip和port的方式显示来源主机和目的主机，而不是用主机名和服务。
    -A：以ascii的方式显示数据包，抓取web数据时很有用。
    -X：数据包将会以16进制和ascii的方式显示。
    表达式：表达式有很多种，常见的有：host 主机；port 端口；src host 发包主机；
    dst host 收包主机。多个条件可以用and、or组合，取反可以使用!，更多的使用可以
    查看man 7 pcap-filter


tcpdump -i eth0 -nn 'icmp'
# 抓到包的时间 IP 发包的主机和端口 > 接收的主机和端口 数据包内容


tcpdump -i eth0 -nn 'src host 192.168.1.231'

tcpdump -i eth0 -nn 'dst host 192.168.1.231'

tcpdump -i eth0 -nnA 'port 80'

tcpdump -i eth0 -nnA 'port 80 and src host 192.168.1.231'

tcpdump -i eth0 -nnA '!port 22'


EOF

