#!/bin/bash
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


#-----------------------
# The Main Entry Point
#-----------------------

echo "*** ifconfig  "
ifconfig 
read -n 1 -s -p ">>> Next to DNS [cat /etc/resolve.conf] if press any"
echo ""

echo "*** DNS /etc/resolv.conf"
cat /etc/resolv.conf
read -n 1 -s -p ">>> Next to Default Gateway [netstat -r] if press any"
echo ""

echo "*** Default Gateway " 
netstat -r

exit 0
####################################################################
#  Copyright (c) 2015.  lin_jie_long@126.com,  All rights reserved.
####################################################################


