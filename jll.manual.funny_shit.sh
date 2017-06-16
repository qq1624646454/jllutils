#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.funny_shit.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-06-16 17:27:00
#   ModifiedTime: 2017-06-16 17:27:00

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more>&1<<EOF

${Fyellow}项目简介：${AC}
WifiDog 是一款开源的用来实现无线认证的软件，可以集成到路由器或者网关中，对于连接到路由器或者网关的设备，使其先登录云端认证服务器，然后通过认证才能上网。比如在星巴克上网，浏览器会先弹出一个广告页面，我们输入手机号，获取验证码，然后就可以上网了。

${Fseablue}官网地址：http://dev.wifidog.org/${AC}

授权协议：GPLv2



EOF

