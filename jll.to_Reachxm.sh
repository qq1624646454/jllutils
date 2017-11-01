#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.to_Reachxm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 21:05:57
#   ModifiedTime: 2017-11-01 21:05:57

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

echo

if [ x"$1" = x"-h" ]; then
cat >&1 <<EOF

  USAGE:
    $(basename $0) [-h]

    $(basename $0) [Account For sign in]
    # If Account isn't specified, and the Account will be set to current user.

EOF
exit 0
fi


GvAccount=$1

GvDevice=JllServer_P

GvIP=$(/sbin/ifconfig ${GvDevice} \
          | /bin/grep "inet addr:" \
          | /usr/bin/awk -F':' '{print $2}' \
          | /usr/bin/awk '{print $1}')
if [ x"${GvIP}" = x ]; then
    echo "Fatal Error because the IP isn't present on \"${GvDevice}\""
    exit 0
fi
echo "  JLL: Trying to build the session connection: ${GvIP}--->${GvIP%.*}.110"
echo
GvIP=${GvIP%.*}.110


GvMTU=$(/sbin/ifconfig ${GvDevice} \
           | /bin/grep "MTU:" \
           | /usr/bin/awk -F':' '{print $2}' \
           | /usr/bin/awk '{print $1}')
if [ x"${GvMTU}" = x ]; then
    echo "Fatal Error because can't get MTU from \"${GvDevice}\""
    exit 0
fi

echo "  JLL: Checking MTU: ${GvMTU} for \"${GvDevice}\""
echo
if [ ${GvMTU} -gt 1300 ]; then
    echo "  JLL: Changing MTU: 1300 for \"${GvDevice}\""
    /usr/bin/sudo /sbin/ifconfig ${GvDevice} mtu 1300
fi

if [ x"$(which nc)" != x ]; then
    nc -zv 106.186.30.16 6489
fi

if [ x"${GvAccount}" = x ]; then
    #ssh -vvv ${GvIP} 
    ssh ${GvIP} 
else
    #ssh -vvv ${GvAccount}@${GvIP} 
    ssh ${GvAccount}@${GvIP} 
fi


