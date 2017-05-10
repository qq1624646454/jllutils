#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

echo -e
echo -e "------------- Code Comment ------------"
echo -e "\033[0m\033[31m\033[43m/*** JLL.S<TIMEFORMAT>: COMMENT ***/\033[0m"
echo -e "\033[0m\033[31m\033[43m/*** JLL.E<TIMEFORMAT>: COMMENT ***/\033[0m"
echo -e
echo -e "For Example:"
echo -e "    /*** JLL.S2016042400: Solution to can't get IP from DHCP Server ***/"
echo -e "    int32_t  i4PropValue;"
echo -e "    /*** JLL.E2016042400: Solution to can't get IP from DHCP Server ***/"
echo -e

