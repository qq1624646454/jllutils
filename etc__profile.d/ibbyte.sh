#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     ibbyte.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-28 12:39:21
#   ModifiedTime: 2019-08-15 14:47:46

function jllim_wget()
{
more >&1<<EOF

#-nH:Not create host directory
#-m:reserved download directroy tree
wget -nH -m –restrict-file-names=nocontrol --ftp-user=reach --ftp-password=reach2019 ftp://ftp.reachxm.com/open/RD/

EOF 
}

function to_lora_workspace()
{
    cd /ibbyte512MB/projects/lpwan/lora 
}
export -f to_lora_workspace

function to_lora()
{
    cd /ibbyte1024MB/corporation/www.reachxm.com/LoRa 
}
export -f to_lora

function to_PublicNetworkIntercom()
{
    cd /ibbyte512MB/projects/L170/Products/PublicNetworkIntercom
}
export -f to_PublicNetworkIntercom

function to_169server_by_SSH()
{
    ssh root@172.16.10.169
}
export -f to_169server_by_SSH

function to_ws()
{
    cd /ibbyte512MB/projects
}
export -f to_ws

function to_gerrit()
{
    cd /ibbyte1024MB/corporation/www.reachxm.com/gerrit
}
export -f to_gerrit

function to_pni()
{
    cd /ibbyte512MB/projects/L170/Products/PublicNetworkIntercom/sw/L170L/apps_proc/reach-pni
}
export -f to_pni
