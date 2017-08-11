#!/bin/bash
# Copyright(c) 2016-2100   jielong.lin   All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

function Fn_Usage()
{
cat >&1 <<EOF

Usage:
    $(basename $0) -s
        Lookup status of samba by 'smbstatus'

    $(basename $0) -t
        Check and test parameters for samba by 'testparm'



    $(basename $0) [help]
        Lookup the usage

EOF
}


if [ $# -eq 0 -o x"$1" = x"help" ]; then
   Fn_Usage
   exit 0  
fi

if [ x"$1" = x"-s" ]; then
   echo
   smbstatus
   echo
   exit 0
fi
if [ x"$1" = x"-t" ]; then
   echo
   testparm 
   echo
   exit 0
fi


Fn_Usage

#################################################################################

