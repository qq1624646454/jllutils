#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.usb_camera.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-07 00:18:08
#   ModifiedTime: 2017-11-07 00:51:44

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Fgreen}V4L2 - Video For Linux 2 Architect${AC}
${Bgreen}=====================================================================================${AC}
                                        ${Fyellow}Made by jielong.lin   All rights reserved.${AC}
    +------------------------+
    |  /dev/videoX           |                                       User Space
-----------------------------------------------------------------------------------
    |  V4L2 DevNumber(81,x)  |                                      Kernel Space
    +------------------------+
                 |
                 |       +---------------------------------+
                 |       |      Platform V4L2 Driver       |
                 |       +---------------------------------+
                 |         ^          |                ^
                 |     call|   registe|                |
                 |         |          v                |
                 |  +--------------------+             |
                 |  |  V2L2 Driver Core  |             v
                 |  +--------------------+      +-------------------------+
                 |         ^          |         | Specified Sensor Driver | 
                 |     call|   registe|         |      ( V2L2_subdev)     |
                 |         |          v         +-------------------------+ 
     +---------------------------------------+         ^
     |  Character Device Driver Core (cdev)  |         |
     +---------------------------------------+         |
                                                       |          Kernel Space
-------------------------------------------------------|--------------------------
                                                       |          Hardware Device
                                                       v
                                             +--------------------------------+ 
                                             |     Camera sensor hardware     |
                                             +--------------------------------+

${Bgreen}=====================================================================================${AC}


${Fgreen}How to Use Which Camera Driver${AC}
${Fyellow}1).Insert the use-camera into linux system${AC}
${Fyellow}2).Type the dmesg | tail, then found the followwing information, and in last 3 lines${AC}
${Fyellow}   are only interested${AC}
usb 1-1: New USB device found, idVendor=1e4e, idProduct=0102
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: Product: USB2.0 Camera
usb 1-1: Manufacturer: Etron Technology, Inc.
${Fseablue}uvcvideo: Found UVC 1.00 device USB2.0 Camera (1e4e:0102) ${AC}
${Fseablue}uvcvideo: UVC non compiance - GET_DEF(PROBE) not supported. Enabling workaround.${AC}
${Fseablue}input: USB2.0 Camera as /devices/platform/s5p-ohci/usb1/1-1/1-1:1.0/input/input1.${AC}
${Fyellow}3).Search all driver source code files for UVC${AC}
It may be in drivers/media/usb/uvc/uvc_driver.c:1864


${Fgreen}Check if uvc id is supported${AC}
http://www.ideasonboard.org/uvc/



EOF

