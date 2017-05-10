#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

--------------------------------------------------
-  Juniper SSL/VPN only use openjdk(32bit)
--------------------------------------------------
# Print the current dpkg architecture
 dpkg --print-architecture

# Print the external dpkg architectures
 dpkg --print-foreign-architectures

# Support for the external architectures: i386
 dpkg --add-architecture i386 


 apt-get update
 apt-get install openjdk-7-jdk:i386

 # Install plugin for Iceweasel
 aptitude install icedtea-plugin



-------------------------------------------------------------
Please ensure that necessary 32 bit libraries are installed. 
For more details, refer KB article KB25230
Setup failed. Please install 32 bit Java and update alternatives
links using update-alternatives command. For more details, refer 
KB article KB25230
-------------------------------------------------------------

# Command = /bin/sh -c /usr/sbin/update-alternatives --display java 2>&1 | grep -v "/bin/sh:" | grep ^/ | cut -d " " -f 1 | tr " " " "

However it's looking update-alternatives from /usr/sbin/ and there seems to be no symlink pointing to the right directory like 13.10 had. So adding symlink to /usr/sbin/ helped.
# ln -s /usr/bin/update-alternatives /usr/sbin/


# apt-get install libstdc++6:i386 lib32z1 lib32ncurses5 lib32bz2-1.0 libxext6:i386 libxrender1:i386 libxtst6:i386 libxi6:i386



---------------------------------
 Configurate the Juniper-TPV
---------------------------------

 mkdir -pv ~/.juniper_networks/network_connect/
 cd ~/.juniper_networks/

 wget -c https://cnhqvpn01.tpv-tech.com/dana-cached/nc/ncLinuxApp.jar
 tar -vxf ncLinuxApp.jar -C network_connect/
 cd -
 chown root:root  ~/.juniper_networks/network_connect/ncsvc
 chmod 6711 ~/.juniper_networks/network_connect/ncsvc
 chmod 744 ~/.juniper_networks/network_connect/ncd  



EOF


