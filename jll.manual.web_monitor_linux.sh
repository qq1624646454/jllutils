#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.web_monitor_linux.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-03 17:20:15
#   ModifiedTime: 2018-12-03 17:22:16

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

netdata 探针

netdata 是一个分布式实时性能和健康监控系统。netdata 可以实时监控的操作系统和应用程序（如 Web服务器软件 和 数据库服务器软件），并通过现代化的 Web 界面表现出来。netdata 非常的快速和高效，其可以在 物理或虚拟服务器、容器、IoT设备上持续运行。

目前 netdata 可以运行在：Linux 发行版、FreeBSD 和 MacOS 上。


移动友好：在 PC 和 触碰设备下均可友好使用，目前提供 Light 和 Dark 两款主题
快速响应：即便是在低端硬件上，每个指标的查询速度依旧可以超过 0.5ms
高效迅速：单核心 CPU 利用率仅为 1%，个位数的内存占用以及几乎不产生磁盘读写
零配置：开箱即用的体验
零依赖：无需依赖任何执行语言和 Web 服务器软件
零维护：只要运行后无需任何操作
可扩展：提供丰富的插件(可以使用许多方式来制作它的插件，从bash到node.js)，你可以检测任何可以衡量的数据。
可嵌入：即便是在物联网设备上，依旧可以检测数据


Install by follows:
  bash <(curl -Ss https://my-netdata.io/kickstart.sh)


Run it by follows:
  firefox http://127.0.0.1:19999


EOF

