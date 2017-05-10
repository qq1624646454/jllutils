#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

The solution comes from https://wiki.debian.org/rt2870sta
-----------------------------------------------------------

1.Add a "non-free" component to /etc/apt/source.list, for example:

### JLL.Start: support for RT3070 on Debian8.3 from https://wiki.debian.org/rt2870sta
deb http://ftp.us.debian.org/debian jessie main contrib non-free
### JLL.End: support for RT3070 on Debian8.3 from https://wiki.debian.org/rt2870sta

2.Update the list of available packages and install the firmware-ralink and wireless-tools packages:

aptitude update
aptitude install firmware-ralink wireless-tools


3.If not already performed, connect the device to your system

4.The rt2870sta kernel module is automatically loaded for supported devices.Verify your device has available interface:

iwconfig

5.Configure your wireless interface as appropriate


EOF


