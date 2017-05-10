#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

cat >&1 << EOF

--------------------------------------
 Check if IPv4:Port is valid or not
--------------------------------------
root@debian:~# nc -zv 10.1.1.110 22
DNS fwd/rev mismatch: fj.10086.cn != www.fj.10086.cn.wscdns.com
fj.10086.cn [10.1.1.110] 22 (ssh) open
root@debian:~# 







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
dns-nameservers 172.20.2.29 172.20.2.30  211.138.156.66  211.138.151.161
dns-search www.baid.com




How to Get the IP from DHCP server
----------------------------------------------
$ dhclient eth0
$ dhclient wlan0
and so on.



EOF

