#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF


################################################
## hostapd + dhcpd build the Wireless Soft-AP
################################################
hostapd is an IEEE 802.11 AP and IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator.

hostapd is a user space daemon for access point and authentication servers. It implements IEEE 802.11 access point management, IEEE 802.1X/WPA/WPA2/EAP Authenticators, RADIUS client, EAP server, and RADIUS authentication server. The current version supports Linux (Host AP, madwifi, mac80211-based drivers) and FreeBSD (net80211).

hostapd is designed to be a “daemon” program that runs in the background and acts as the backend component controlling authentication. hostapd supports separate frontend programs and an example text-based frontend, hostapd_cli, is included with hostapd.

------------------------------------------------
1.Install hostapd and dhcpd
# apt-get install hostapd isc-dhcp-server
Note: Don't start this two services on startup, suggest to turn off them:
(1)
# update-rc.d -f hostapd remove
(2)
Please comment the line contained "start on" in /etc/init/isc-dhcp-server.conf and /etc/init/isc-dhcp-server6.conf

2.Configurate for hostapd and dhcpd
(0)
# aptitude install hwinfo

(1)
Note: Please specify the ssid and wpa_passphrase
# cat > /etc/hostapd/hostapd.conf << EOFL
interface=wlan0
driver=ath9k    # refer to 'hwinfo --netcard'
ssid=JLL_AP_NAME
hw_mode=g
channel=10
macaddr_acl=0
auth_algs=3
wpa=2
wpa_passphrase=jll
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=TKIP CCMP

EOFL

(2)
Note: append the following content to the configurate file
      180.76.76.76 - baidu DNS
      8.8.8.8 - google DNS
# cat >> /etc/dhcp/dhcpd.conf << EOFL
subnet 192.168.0.0 netmask 255.255.255.0
{
range 192.168.0.2 192.168.0.10;
option routers 192.168.0.1;
option domain-name-servers 192.168.0.1,180.76.76.76,8.8.8.8;
}

EOFL


3.Build the start and stop script tools in myself home directory
# mkdir -pv ~/hostapd
# cat > ~/hostapd/ap-start.sh <<EOFL
#!/bin/bash

# 开启内核IP转发
bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

# 开启防火墙NAT转发(如果本机使用eth0上网,则把ppp0改为eth0)
read -p "Is ppp0 valid ? "
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE

# 关闭NetworkManager对无线网卡的控制
nmcli nm wifi off

# 设置并启动无线网卡
ifconfig wlan0 192.168.0.1 netmask 255.255.255.0

# 解锁无线设备,可以用rfkill list查看解锁结果.
rfkill unblock wlan

# 睡眠6秒,待rfkill解锁生效
sleep 6s

# 启动dhcpd和hostapd,如果hostapd无法启动请查看日志hostapd.log,查看这两个进程ps -ef|egrep "dhcpd|hostapd"
nohup hostapd /etc/hostapd/hostapd.conf > ~/hostapd/hostapd.log 2>&1 &

dhcpd wlan0 -pf /var/run/dhcpd.pid

ps -ef | head -n1 && ps -ef | egrep "dhcpd|hostapd"

EOFL

# cat > ~/hostapd/ap-stop.sh << EOFL
#!/bin/bash
killall hostapd dhcpd
bash -c "echo 0 > /proc/sys/net/ipv4/ip_forward"
ifconfig wlan0 down

EOFL


--------------------------------------------------------------
Reference to https://wiki.debian.org/WiFi/AdHoc


1.Define stanzas for each node's wirelss interface, setting the network SSID
  and the device's operating mode to ad-hoc:

# vim /etc/network/interfacess
------------------------------

auto wlan0
iface wlan0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    wireless-channel 1
    wireless-essid   MYNETWORK
    wireless-mode    ad-hoc

2.Raise the interface on each node:

# ifup wlan0


3.Scan for ad-hoc cells in range(necessary for some drivers to trigger IBSS scanning)

# iwlist wlan0 scan

EOF

