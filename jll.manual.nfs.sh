#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.nfs.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-07-01 13:26:21
#   ModifiedTime: 2017-07-01 15:00:32

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF



${Byellow}                                                                     ${AC}
${Byellow}  ${AC}The Below Steps Have Already Been Checked Pass By jielong.lin
${Byellow}  ${AC}    Install and Configure NFS Server support on Ubuntu
${Byellow}                                                                     ${AC}
jll@S1:~$ ${Fyellow}sudo apt-get install nfs-kernel-server nfs-common portmap${AC}
[sudo] password for jll:
...
jll@S1:~$ ${Fyellow}sudo vim /etc/exports${AC}
#...
/home/jll 172.20.30.1/24(rw,no_root_squash,async)

jll@S1:~$ ${Fyellow}sudo /etc/init.d/nfs-kernel-server restart${AC}
...
jll@S1:~$ ${Fyellow}sudo exportfs -a ${AC}
...
jll@S1:~$

${Byellow}                                                                     ${AC}
${Byellow}  ${AC}The Below Steps Have Already Been Checked Pass By jielong.lin
${Byellow}  ${AC}    Install and Configure NFS Client support on Ubuntu
${Byellow}                                                                     ${AC}
jll@S2:~$ ${Fyellow}apt-get install libnfs-dev nfs-common ${AC}
... 
jll@S2:~$
jll@S2:~$ ${Fyellow}mkdir -pv ~/xmnb4003161.tpvaoc.com/Desktop ${AC}
jll@S2:~$ ${Fyellow}cd ~/xmnb4003161.tpvaoc.com ${AC}
jll@S2:~/xmnb4003161.tpvaoc.com$ 
jll@S2:~/xmnb4003161.tpvaoc.com$ ${Fyellow}mount -v -t nfs -o nfsvers=3 \
172.20.30.32:/home/jll/ Desktop${AC}
...



















${Fpink}NFS Server                          NFS Client    ${AC}
${Fpink}Windows7 [FreeNFS.exe] <----------> Ubuntu        ${AC}
${Fpink}172.20.27.30                        172.20.30.29  ${AC}
${Fpink}xmnb4003161.tpvaoc.com                            ${AC}

root@TpvServer:~/xmnb4003161.tpvaoc.com# \\
    ${Fgreen}mount -v -t nfs 172.20.27.30:/D/System/jielong.lin/Desktop/ Desktop${AC}
mount.nfs: timeout set for Sat Jul  1 13:57:00 2017
mount.nfs: trying text-based options 'vers=4,addr=172.20.27.30,clientaddr=172.20.30.29'
mount.nfs: mount(2): Permission denied
mount.nfs: access denied by server while mounting 172.20.27.30:/D/System/jielong.lin/Desktop/
root@TpvServer:~/xmnb4003161.tpvaoc.com#

root@TpvServer:~/xmnb4003161.tpvaoc.com# \\
    ${Fgreen}mount -v -t nfs -o nfsvers=3 172.20.27.30:/D/System/jielong.lin/Desktop/ Desktop${AC}
mount.nfs: timeout set for Sat Jul  1 13:58:23 2017
mount.nfs: trying text-based options 'nfsvers=3,addr=172.20.27.30'
mount.nfs: prog 100003, trying vers=3, prot=6
mount.nfs: trying 172.20.27.30 prog 100003 vers 3 prot TCP port 2049
mount.nfs: portmap query failed: RPC: Authentication error
mount.nfs: access denied by server while mounting 172.20.27.30:/D/System/jielong.lin/Desktop/
root@TpvServer:~/xmnb4003161.tpvaoc.com#

root@TpvServer:~/xmnb4003161.tpvaoc.com# ${Fyellow}showmount -e xmnb4003161.tpvaoc.com${AC}
rpc mount dump: RPC: Procedure unavailable


root@TpvServer:~/xmnb4003161.tpvaoc.com# ${Fyellow}rpcinfo -p${AC}
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  53019  status
    100024    1   tcp  55657  status
root@TpvServer:~/xmnb4003161.tpvaoc.com#


${Bgreen}                                                          ${AC}
${Bgreen}  ${AC}Install NFS server support on Ubuntu
${Bgreen}  ${AC}Open the terminal and run the following command
${Bgreen}                                                          ${AC}
sudo apt-get install nfs-kernel-server nfs-common portmap

${Fred}When configuring portmap do not bind loopback. If you do you can either edit ${AC}
${Fred}/etc/default/portmap using the following ${Fgreen}sudo vi /etc/default/portmap${AC}
${Fred}or use the following command ${Fgreen}sudo dpkg-reconfigure portmap${AC}
${Fred}Restart Portmap using the following command${Fgreen}sudo /etc/init.d/portmap restart${AC}

${Bgreen}   ${AC}NFS Server Configuration
NFS exports from a server are controlled by the file /etc/exports. Each line begins with 
the absolute path of a directory to be exported, followed by a space-seperated list of 
allowed clients.
You need to edit the exports file using the following command
    ${Fgreen}sudo vi /etc/exports${AC}
Here are some quick examples of what you could add to your /etc/exports
For Full Read Write Permissions allowing any computer from 192.168.1.1 through 192.168.1.255
    ${Fgreen}/files 192.168.1.1/24(rw,no_root_squash,async)${AC}
Or for Read Only from a single machine
    ${Fgreen}files 192.168.1.2 (ro,async)${AC}
save this file and exit

A client can be specified either by name or IP address. Wildcards (*) are allowed in names, 
as are netmasks (e.g. /24) following IP addresses, but should usually be avoided for security 
reasons.

A client specification may be followed by a set of options, in parenthesis. It is important 
not to leave any space between the last client specification character and the opening 
parenthesis, since spaces are intrepreted as client seperators.

Now you need to restart NFS server using the following command
  ${Fgreen} sudo /etc/init.d/nfs-kernel-server restart ${AC}
If you make changes to /etc/exports on a running NFS server, you can make these changes 
effective by issuing the command
  ${Fgreen} sudo exportfs -a ${AC}



${Bgreen}                                                          ${AC}
${Bgreen}  ${AC}Install NFS client support on Ubuntu
${Bgreen}  ${AC}Open the terminal and run the following command
${Bgreen}                                                          ${AC}
sudo apt-get install portmap nfs-common



EOF

