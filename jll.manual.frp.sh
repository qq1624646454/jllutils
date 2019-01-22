#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.frp.sh
<<<<<<< HEAD
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-22 23:21:45
#   ModifiedTime: 2019-01-22 23:22:07

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
=======
#   Author:       JLLim 
#   Email:        493164984@qq.com
#   DateTime:     2019-01-22 23:12:35
#   ModifiedTime: 2019-01-22 23:39:55
>>>>>>> 176d226fd3dbaada0976067579a74f9cf44ae550

more >&1<<EOF

=======================================================
<<<<<<< HEAD
      
-------------------------------------------------------
1.

EOF


=======
  基于免费frps服务器搭建内网透传网络
-------------------------------------------------------

1.选择免费frps服务器:  http://freenat.win
  注：可以通过http://www.frps.top选择其中一个免费的服务器，
      本文选择 freenat.win

2.在 http://freenat.win 选择美国frp线路2: 0.16.1版本，如下：
     连接地址为：freenat.bid:7000
     特权认证密码为：frp888
     状态查询：http://freenat.bid:7500
     查询帐号和密码均为：admin
     默认http端口为80
     默认https端口为443
     端口全部开放
     提供二级域名*.freenat.bid(*自定义)
     支持KCP协议
     支持P2P穿透（xtcp）
     本服务器长期服务 
  由此可见，免费的frps服务器为 freenat.bid，端口为 7000

3.在本地机子上搭建frpc客户端及其配置:
  3.1.版本很重要，一定要一致，否则会出现不可预料的连接问题
      

  3.2.配置文件，新建frpc__freenat.bid文件（文件名可自定义），内容如下：

        [common]

#frps服务端地址
server_addr = freenat.bid 

#frps服务端通讯端口，客户端连接到服务端内网穿透传输数据的端口
server_port = 7000

#特权模式密钥，客户端连接到FRPS服务端的验证密钥
privilege_token = frp888

#日志存放路径
log_file = /root/frpc.log

#日志记录类别,可选：trace, debug, info, warn, error
#log_level = trace
log_level = info

#日志保存天数
log_max_days = 7 

#login_fail_exit = true 
#设置为false，frpc连接frps失败后重连，默认为true不重连
login_fail_exit = false

#KCP协议在弱网环境下传输效率提升明显，但是对frps会有一些额外的流量消耗。
#服务端须先设置kcp_bind_port = 7000，freenat.bid服务端已设置支持
protocol = kcp 



EOF
>>>>>>> 176d226fd3dbaada0976067579a74f9cf44ae550

