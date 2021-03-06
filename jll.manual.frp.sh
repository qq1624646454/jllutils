#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.frp.sh
#   Author:       JLLim 
#   Email:        493164984@qq.com
#   DateTime:     2019-01-22 23:12:35
#   ModifiedTime: 2019-01-23 00:38:25

more >&1<<EOF

=======================================================
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
        最好是下载同版本的已编译好的bin文件
       （注：曾试过同版本源码编译生成的bin文件无法与免费服务器的frps建立连接）
        选择frp_0.16.1_linux-amd64 

  3.2.配置文件，新建frpc__freenat.bid文件（文件名可自定义），内容如下：
      ------------------------------------------------------------------------------------
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


        #穿透服务名称,不能和其他已建立的相同，使用公共服务器的建议修改成复杂一点的名称
        #避免与其他人冲突，很多路由器内置frpc的默认服务名称为[web]，很容易很其他人冲突
        [http_ibbyte_80]

        #穿透协议类型，可选：tcp，udp，http，https，stcp，xtcp，这个设置前必须自行搞清楚应该是什么
        type=http

        #本地监听IP，可以是本机IP，也可以是本地的局域网内某IP
        local_ip = 127.0.0.1

        #本地监听端口，通常有ssh端口22，远程桌面3389等等
        local_port = 80

        #对传输内容进行压缩，可以有效减小 frpc 与 frps 之间的网络流量，加快流量转发速度，
        #但是会额外消耗一些 cpu 资源
        use_compression = true

        #将 frpc 与 frps 之间的通信内容加密传输
        use_encryption = true

        #域名访问方式一：不需要申请域名的方法
        #                自定义一个可用的子域名，你的访问地址将会是http://ibbyte.freenat.bid
        #subdomain = ibbyte

        #域名访问方式二：需要申请域名，假如为ibbyte.com，请先在域名管理上创建一条域名为
        #                    CNAME  web.ibbyte.com  freenat.bid
        #                通过配置如下custom_domains = web.ibbyte.com 即可以通过访问
        #                    web.ibbyte.com 访问本机上的80端口对应的web服务
        custom_domains = web.ibbyte.com


        #web2.ibbyte.com to releasing version for customers
        [http_web2_ibbyte_com_9988]
        type = http
        local_ip = 127.0.0.1
        local_port = 9988 
        use_compression = true
        use_encryption = true
        custom_domains = web2.ibbyte.com 
        #subdomain = ibbyte
        #ibbyte.freenat.bid亲测是可以的 by JLLim
        #custom_domains = ibbyte.freenat.bid


        #
        #其它的电脑可以通过 ssh -oPort=59156 root@ssh.ibbyte.com 远程登录本机
        #
        [tcp_ssh_ibbyte_22]
        type = tcp
        local_ip = 127.0.0.1
        local_port = 22
        use_compression = true
        use_encryption = true
        #由于远程端口可能被别人使用，所以很容易冲突
        remote_port = 59156 
        custom_domains = ssh.ibbyte.com

4.启动:
     ./frpc -c ./frpc__freenat.bid

 
EOF

