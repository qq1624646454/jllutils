#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.iDSS.sh
#   Author:       jielong.lin 
#   Email:        493164984@qq.com
#   DateTime:     2017-06-20 18:53:35
#   ModifiedTime: 2017-06-22 13:48:20

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

declare -i GvPageUnit=10
declare -a GvPageMenuUtilsContent=(
  "Dump runtime status of DarwinStreamingServer"
)
declare -i GvPageMenuUtilsContentSZ=${#GvPageMenuUtilsContent[@]}


function _FNCB_stop()
{
    ps ax | awk '{print $1" " $5}' | awk '/DarwinStreamingServer/ {print $1}' | xargs -r kill -9
    ps ax | awk '/streamingadminserver.pl/ {print $1}' | xargs -r kill -9
}


function _FNCB_dump()
{
  echo
  echo "======================================================================================"
  echo "   Darwin Streaming Server Alive Processes "
  echo "======================================================================================"
  PS_AX=$(ps ax)
  # DSS_ is DarwingStreamingServer
  #DSS_="[Dd][Aa][Rr][Ww][Ii][Nn][Ss][Tt][Rr][Ee][Aa][Mm][Ii][Nn][Gg][Ss][Ee][Rr][Vv][Ee][Rr]"
  #DSS_PID=$(echo "${PS_AX}" | awk "{\$2=\$3=\$4=\"\"; print}" | awk "/${DSS_}/ {printf \$1\" \"}")
  #echo "${PS_AX}" | awk "{\$2=\$3=\$4=\"\"; print}" | awk "/${DSS_}/ {print}"
  # SAS_ is streamingadminserver.pl 
  #SAS_="[Ss][Tt][Rr][Ee][Aa][Mm][Ii][Nn][Gg][Aa][Dd][Mm][Ii][Nn][Ss][Ee][Rr][Vv][Ee][Rr].[Pp][Ll]"
  #SAS_PID=$(ps ax | grep -Ei "${SAS_PNAME}" | awk "{print \$1}" | xargs -r echo -n)
  #SAS_PID=$(echo "${PS_AX}" | awk "{\$2=\$3=\$4=\"\"; print}" | awk "/${SAS_}/ {printf \$1\" \"}")
  #echo "${PS_AX}" | awk "{\$2=\$3=\$4=\"\"; print}" | awk "/${SAS_}/ {print}"
  
  ps ax | awk "{\$2=\$3=\$4=\"\"; print}" | grep -Ei "[D]arwinStreamingServer$"
  ps ax | awk "{\$2=\$3=\$4=\"\"; print}" | grep -Ei "[s]treamingadminserver\.pl$"

  echo
  echo
  echo "======================================================================================"
  echo "   Darwin Streaming Server Alive Ports "
  echo "======================================================================================"
  netstat -ntulp | grep -i Darwin
  echo
  echo
}


GUEST_OS=`uname`

if [ $GUEST_OS != "SunOS" ]; then
	USERID=`id -u`
else
	USERID=`/usr/xpg4/bin/id -u`
fi

if [ $USERID != 0 ]; then
more >&1<<EOF

JLL-Exit:: ${Fred}not privilege user${AC}
           UserID=${USERID} on ${GUEST_OS}

EOF
exit 0
fi


Lfn_PageMenuUtils __menu \
    "Select" 7 4 "***** Action Menu (q: quit) *****"

if [ x"${__menu}" = x"${GvPageMenuUtilsContent[0]}" ]; then
    [ x"${__menu}" != x ] && unset __menu
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
    [ x"${GvPageMenuUtilsContentSZ}" != x ] && unset GvPageMenuUtilsContentSZ
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
    _FNCB_dump
    exit 0
fi 


