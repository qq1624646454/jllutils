#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.jlink.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-04-17 15:51:47
#   ModifiedTime: 2018-05-07 12:44:51

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF

For Linux(Ubuntu-14.04)
==================================================================
(1).Download the Jlink from the follows:
    https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
(2).Install JLink:
    root@lnx:.# dpkg -i JLink/JLink_Linux_x86_64.deb  
(3).Use JLink:
    /usr/bin/JLinkExe 
    root@lnx:.# connect
    # For SWD interface: 4pins
    # For JTAG interface: 20pins
    #  SWD is better than JTAG for high speed dowloading
    ...

    #将二进制文件下载到目标存储器
    root@lnx:.# loadbin <filename>, <addr>

    #下载之前需要设置下目标版的处理器，否则无法正常烧写，我的型号是STM32F103RBT6，但在指定的时候只指定为STM32F103RB，如下：

------------------------
 Command line options
------------------------
[42m -AutoConnect [41m Automatically start the target connect sequence[0m

[42m -CommanderScript [41m Passes a CommandFile to J-Link[0m

[42m -CommandFile [41m Passes a CommandFile to J-Link[0m

[42m -Device [41m Pre-selects the device J-Link Commander shall connect to[0m
[42m -device <DeviceName>[0m
For a list of all supported device names, please refer to the follows which is List of supported target devices:
  https://www.segger.com/products/debug-probes/j-link/technology/cpus-and-devices/overview-of-supported-cpus-and-devices/#DeviceList
  https://www.segger.com/downloads/supported-devices.php

  MKL02Z32xxx4	Cortex-M0	Parallel CFI NOR flash Internal flash  
  MKL17Z32xxx4	Cortex-M0	Parallel CFI NOR flash Internal flash 
  MKL17Z64xxx4  Cortex-M0	Parallel CFI NOR flash Internal flash
  MKL16Z128xxx4	Cortex-M0	Parallel CFI NOR flash Internal flash

[42m -ExitOnError [41m Commander exits after error.[0m

[42m -If [41m Pre-selects the target interface[0m

[42m -IP [41m Selects IP as host interface[0m

[42m -JLinkScriptFile [41m Passes a JLinkScriptFile to J-Link[0m

[42m -JTAGConf [41m Sets IRPre and DRPre[0m

[42m -RTTTelnetPort [41m Sets the RTT Telnetport[0m

[42m -SelectEmuBySN [41m Connects to a J-Link with a specific S/N over USB[0m

[42m -SettingsFile [41m Passes a SettingsFile to J-Link[0m

[42m -Speed [41m Starts J-Link Commander with a given initial speed[0m



EOF

