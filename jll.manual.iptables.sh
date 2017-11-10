#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

iptables -t nat -nL


|----- raw table ------------|    |------ managle table ------|    |--- nat table ------------|
|   |----------------------| |    |  |----------------------| |    | |----------------------| |
|   |                      | |    |  |                      | |    | |                      | |
|   |-- PREROUTING List ---| |    |  |-- PREROUTING List ---| |    | |-- PREROUTING List ---| |
|                            |--->|                           |--->|                          | 
|   |----------------------| |    |  |----------------------| |    | |----------------------| |
|   |                      | |    |  |                      | |    | |                      | |
|   |---- Output List -----| |    |  |-- POSTROUTING List --| |    | |-- POSTROUTING List --| |
|----------------------------|    |                           |    |                          |
                                  |  |----------------------| |    | |----------------------| |
                                  |  |                      | |    | |                      | |
                                  |  |------ INPUT List ----| |    | |----- OUTPUT List ----| |
                                  |                           |    |-----------|--------------|
                                  |  |----------------------| |                V 
                                  |  |                      | |    |------- filter -----------|
                                  |  |---- OUTPUT List -----| |    | |----------------------| |
                                  |                           |    | |                      | |
                                  |  |----------------------| |    | |--- INPUT List -------| |
                                  |  |                      | |    |                          |
                                  |  |---- FORWARD List ----| |    | |----------------------| |
                                  |---------------------------|    | |                      | |
                                                                   | |--- FORWARD List -----| |
                                                                   |                          |
                                                                   | |----------------------| |
                                                                   | |                      | |
                                                                   | |--- OUTPUT List ------| |
                                                                   |--------------------------|

-----------------------------------------------------------------------------
| --delete  -D chain rulenum
|                                Delete rule rulenum (1 = first) from chain
-----------------------------------------------------------------------------
EOF

more >&1<<EOF

There are three types about NAT:

[ PC .eth0.] ----> [.eth0. Router .eth1.] -----> [ Internet ] ---> [.eth0. Server ]
SNAT: Source Network Address Translation
      Router will modify the source IP which is set to Router eth1.IP then dispatch to internet
e.g:
# Change Source IP=10.8.0.0/24 to 192.168.5.3 then dispatch to internet from eth0 
${Fseablue}iptables-t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source 192.168.5.3${AC}
# Change Source IP=10.8.0.0/24 to one of 192.168.5.3-192.168.5.5 then dispatch to internet from eth0
${Fseablue}iptables-t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source 192.168.5.3-192.168.5.5${AC}


${Fyellow}For SNAT, the Router.eth1 is got dynamic IP from Carrieroperator, and ${AC}
${Fyellow}Router will not re-configure the source IP address translation for every IP change${AC}
${Fyellow}Hence Router will use the followwing MASQUERADE NAT, namely 伪装${AC}
对于SNAT，不管是几个地址，必须明确的指定要SNAT的ip，假如当前系统用的是ADSL动态拨号方式，那么每次拨号，出口
ip 192.168.5.3都会改变，而且改变的幅度很大，不一定是192.168.5.3到192.168.5.5范围内的地址，这个时候如果按照
现在的方式来配置iptables就会出现问题了，因为每次拨号后，服务器地址都会变化，而iptables规则内的ip是不会随着
自动变化的，每次地址变化后都必须手工修改一次iptables，把规则里边的固定ip改成新的ip，这样是非常不好用的。
MASQUERADE就是针对这种场景而设计的，他的作用是，从服务器的网卡上，自动获取当前ip地址来做NAT。
e.g:
${Fseablue}iptables-t nat -A POSTROUTING -s 10.8.0.0/255.255.255.0 -o eth0 -j MASQUERADE${AC}


[ Server.eth0.] <--- [.eth0. Router .eth1.] <--- [ Internet ] ---> [.eth0. PC ]
DNAT: Destionation Network Address Translation
      Router will modify the destionation IP which is set to Server eth0.IP then dispatch to Server


===============================================================
    通常的配置：  eth0是连接外网或Internet的网卡
===============================================================
1、打开包转发功能:
echo "1" > /proc/sys/net/ipv4/ip_forward

2、修改/etc/sysctl.conf文件，让包转发功能在系统启动时自动生效:
# Controls IP packet forwarding
net.ipv4.ip_forward = 1

3、打开iptables的NAT功能:
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


EOF


echo -e "root@TpvServer:~# \033[0m\033[31m\033[43m iptables -L -n --line-number \033[0m"

echo -e "Chain \033[0m\033[31m\033[43mINPUT\033[0m (policy ACCEPT)"

more >&1 << EOF
num  target     prot opt source               destination
1    ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:53
2    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:53
3    ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:67
4    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:67

EOF

echo -e "Chain \033[0m\033[31m\033[43mFORWARD\033[0m (policy ACCEPT)"

more >&1 << EOF
num  target     prot opt source               destination
1    ACCEPT     all  --  0.0.0.0/0            192.168.122.0/24     state RELATED,ESTABLISHED
2    ACCEPT     all  --  192.168.122.0/24     0.0.0.0/0
3    ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0
4    REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
5    REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
6    ACCEPT     all  --  192.168.1.0/24       0.0.0.0/0
7    ACCEPT     all  --  0.0.0.0/0            192.168.1.0/24
EOF

echo -e "\033[0m\033[31m\033[43m8\033[0m    ACCEPT     all  --  192.168.1.11         172.20.27.0/24"

more >&1 << EOF
9    ACCEPT     all  --  192.168.1.0/24       0.0.0.0/0
10   ACCEPT     all  --  0.0.0.0/0            192.168.1.0/24

EOF


echo -e "Chain \033[0m\033[31m\033[43mOUTPUT\033[0m (policy ACCEPT)"

more >&1 << EOF
num  target     prot opt source               destination


EOF

echo -e "root@TpvServer:~# \033[0m\033[31m\033[43miptables -D FORWARD 8\033[0m"

echo -e "root@TpvServer:~# \033[0m\033[31m\033[43miptables -L -n --line-number\033[0m"

more >&1 << EOF
Chain INPUT (policy ACCEPT)
num  target     prot opt source               destination
1    ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:53
2    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:53
3    ACCEPT     udp  --  0.0.0.0/0            0.0.0.0/0            udp dpt:67
4    ACCEPT     tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:67

Chain FORWARD (policy ACCEPT)
num  target     prot opt source               destination
1    ACCEPT     all  --  0.0.0.0/0            192.168.122.0/24     state RELATED,ESTABLISHED
2    ACCEPT     all  --  192.168.122.0/24     0.0.0.0/0
3    ACCEPT     all  --  0.0.0.0/0            0.0.0.0/0
4    REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
5    REJECT     all  --  0.0.0.0/0            0.0.0.0/0            reject-with icmp-port-unreachable
6    ACCEPT     all  --  192.168.1.0/24       0.0.0.0/0
7    ACCEPT     all  --  0.0.0.0/0            192.168.1.0/24
EOF

echo -e "\033[0m\033[31m\033[43m8\033[0m    ACCEPT     all  --  192.168.1.0/24       0.0.0.0/0"

more >&1 << EOF
9    ACCEPT     all  --  0.0.0.0/0            192.168.1.0/24

Chain OUTPUT (policy ACCEPT)
num  target     prot opt source               destination


EOF


