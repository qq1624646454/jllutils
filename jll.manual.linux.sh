#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.linux.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-04-19 10:38:33
#   ModifiedTime: 2017-07-18 22:40:05

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


${Fred} You have new mail in /var/mail/jll ${AC}
${Fgreen} ANALYZE: 一般是系统执行出错了,才会出现这个问题,输入mutt可以查看具体问题${AC}
mutt


/etc/X11/default-display-manager




---------------------
profile & bashrc
---------------------
https://wido.me/sunteya/understand-bashrc-and-profile




${Byellow}${Fblack}=====================================${AC}
${Fyellow}     Users and Groups List
${Byellow}${Fblack}=====================================${AC}
${Fseablue}1）与用户（user）相关的配置文件；${AC}
/etc/passwd 注：用户（user）的配置文件；
/etc/shadow 注：用户（user）影子口令文件；

${Fseablue}2）与用户组（group）相关的配置文件；${AC}
/etc/group 注：用户组（group）配置文件；
/etc/gshadow 注：用户组（group）的影子文件；





========================================================
 Linux 开机脚本
========================================================
1: 需以root权限运行的开机脚本，请在/etc/rc.local中添加,比如
. /etc/rc.local.VPN_N2N_JllServer_Peer
. /etc/auto_QemuNetwork_setNAT_tun_tap_for_TpvServer_172.20.30.29.sh
exit 0

2: 不需要root权限的运行的开机脚本，直接放在/etc/profile.d/目录下即可




========================================================
 which 找不到的命令,却可以在全局路径下执行，这是为什么
========================================================
jielong.lin@xmbuilder03:~$
jielong.lin@xmbuilder03:~$ which set_m
jielong.lin@xmbuilder03:~$
jielong.lin@xmbuilder03:~$ type set_m
set_m is a function
set_m ()
{
    export JAVA_HOME=/mtkoss/openjdk/1.7.0_55-ubuntu-12.04/x86_64;
    export MAKE382=/mtkeda/dtv/tools_M/make-3.82;
    export PATH=\${JAVA_HOME}/bin:\${MAKE382}:\$PATH:\$(get_path_minus_java);
    java -version;
    echo PATH=\$PATH
}
jielong.lin@xmbuilder03:~$
jielong.lin@xmbuilder03:~$ vim /etc/profile.d/Java.sh
...
function set_m() {
    export JAVA_HOME=/mtkoss/openjdk/1.7.0_55-ubuntu-12.04/x86_64;
    export MAKE382=/mtkeda/dtv/tools_M/make-3.82;
    export PATH=\${JAVA_HOME}/bin:\${MAKE382}:\$PATH:\$(get_path_minus_java);
    java -version;
    echo PATH=\$PATH
} 
...
jielong.lin@xmbuilder03:~$
+------------------------------------------------------------------------------------
| which set_m 找不到set_m是因为which只会在PATH范围中查找set_m命令文件，但是
| set_m是一个被定义在当前Bash进程上下文环境中的函数，显然which是绝对找不到的.
| type可以将set_m的类型和内容打印出来，但它不会暴露出set_m被定义的位置
| Linux启动时会默认执行一些脚本来初始化当前的上下文环境, /etc/profile.d目录
| 下的所有.sh文件都会被/etc/profile执行调用,从而写进了当前的进程
+------------------------------------------------------------------------------------


========================================================
 eth0 error while getting interface flags no such device 
========================================================
# ifconfig eth0 up
eth0: error while getting interface flags no such device

# lspci -nnk | grep -iA2 eth
00:03.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd. 
RTL-8139/819C/8139C+ [10ec:8139] (rev 20)
    Subsystem: Red Hat, Inc Device [1af4:1100]
    Kernel driver in use: 8139cp
说明：网络适配器（network adapter）,即网卡是正常的

# ifconfig -a
应该会有一个ethX是有效的
所有的eth网口全部被定义在 /etc/udev/rules.d/70-persistent-net.rules 当中;

找到当前加载的ethX网口，修改下/etc/network/interfaces:
auto ethX
iface ethX inet static






========================================================
   apt-get install xxx failure,
   Please update the /etc/apt/sources.list:
========================================================
deb http://old-releases.ubuntu.com/ubuntu/ quantal main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ quantal-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ quantal-updates main restricted universe multiverse







========================================================
  port 22: Connection refused 
========================================================
# netstat -anp | grep sshd
没有任何信息说明sshd根本就没在运行

# apt-get install openssh-client openssh-server

验证
# ssh root@10.111.1.110






========================================================
  如何在Ubuntu图形桌面中退出当前账号(logout) 
========================================================
# service lightdm stop





========================================================
  Ubuntu/Debian Linux Auto-Login with root account 
========================================================
$ sudo passwd root
设置root的密码为

$ su - root
切换到root账户

for Ubuntu (using lightdm)
# vim /etc/lightdm/lightdm.conf
[SeatDefaults]
autologin-guest=false
autologin-user=root
autologin-user-timeout=0
autologin-session=lightdm-autologin
user-session=ubuntu
greeter-session=unity-greeter
:w
修改autologin-user=root
# reboot







EOF

