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



[ Server.eth0.] <--- [.eth0. Router .eth1.] <--- [ Internet ] ---> [.eth0. PC ]
DNAT: Destionation Network Address Translation
      Router will modify the destionation IP which is set to Server eth0.IP then dispatch to Server




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


