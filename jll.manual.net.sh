#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

cat >&1 << EOF

--------------------------------------
dhcp to retrieve ipv4 and dns
有时配置的DNS=114.114.114.114并不能访问时，
需要切换为动态获取的方式
--------------------------------------
  cat /etc/resolv.conf
    nameserver 114.114.114.114

#reset DNS settings
  /etc/init.d/resolvconf restart
  dhclient eth0 

#lookup ip and dns
  ifconfig
  cat /var/lib/dhcp/dhclient.leases
  cat /etc/resolv.conf



--------------------------------------
bridge eth0
--------------------------------------

关闭网桥命令
     brctl delif br0 eth0;
     ifconfig br0 down;
     brctl delbr br0;





--------------------------------------
domain
--------------------------------------
 wbinfo -u
 wbinfo -g

 nslookup
 dig www.baidu.com



---------------------------------------------------------------
 Check if IPv4:Port which based on tcp/udp is valid or not

 nc = netcat 
 -l : listening mode
 -p <port>
 -u : udp mode or tcp mode if not -u
 -v : more detail
 -t : use telnet interact
 -s <addr>: local source address
 -z : disable io for scaning
---------------------------------------------------------------
#Test tcp port 22 on server 10.1.1.110 ,namely ssh port 
root@debian:~# nc -zv 10.1.1.110 22
DNS fwd/rev mismatch: fj.10086.cn != www.fj.10086.cn.wscdns.com
fj.10086.cn [10.1.1.110] 22 (ssh) open
root@debian:~# 

#Test udp port 470 on server 110.80.142.93 
root@REACHXM82:~#
root@REACHXM82:~# nc -zvu 110.80.142.93  470

Connection to 110.80.142.93 470 port [udp/*] succeeded!
root@REACHXM82:~#


for android:
busybox nc ip port


--------------------------------------

ifconfig eth0 0.0.0.0 metmask 255.255.255.0 promisc up
ifconfig eth0 0.0.0.0 promisc down

###### dump gateway
route 

route add default gw 192.168.1.1  

###### DNS
$ vi /etc/resolve.conf
  nameserver DNS_ADDR_1
  nameserver DNS_ADDR_2


$ iptables -L [-t table_name]
$ iptables -nv -L


###### Persistent IP
$ vi /etc/network/interface
  auto eth0 # Auto configurate eth0 on startup
  iface eth0 inet static  # set static settings,also set dhcp
  # allow-hotplug eth0
  address 192.168.1.100
  netmask 255.255.255.0
  gateway 192.168.1.1

$ /etc/init.d/networking restart

----------------------------------------------

###### Persistent IP
$ vi /etc/network/interfaces

$ vi /etc/network/interface

# The primary network interface
auto eth0
iface eth0 inet static
address 192.168.1.11
netmask 255.255.255.0
gateway 192.168.1.10
dns-nameservers 172.20.2.29 172.20.2.30  211.138.156.66  211.138.151.161 218.85.152.99 218.85.157.99
dns-search www.baid.com




How to Get the IP from DHCP server
----------------------------------------------
$ dhclient eth0
$ dhclient wlan0
and so on.



EOF

