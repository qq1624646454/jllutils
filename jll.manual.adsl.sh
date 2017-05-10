#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

cat >&1 << EOF

Install adsl component:
  $ aptitude install pppoeconf

Configuration for PPPoE
  $ pppoeconf
  Note: you should answer Yes for all questions.

Connect to the configurated ADSL settings:
  $ pon  dsl-provider

Disconnect :
  $ poff dsl-provider

If Call successfully, but dont go to internet:
  $ route del  default
  $ route add  default dev ppp0


Any issues are occured , please run "plog " then "pppeconf" to check dsl provider


====================================
ps aux | grep -i pppd

ifconfig | grep -i ppp

plog


EOF

