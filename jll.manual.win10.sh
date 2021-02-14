#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.win10.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-08-15 11:38:09
#   ModifiedTime: 2021-01-06 11:25:43

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

针对品牌笔记本自带的正版WIN10 HOME版本

${Byellow}${Fblack} 解决截屏或录屏软件在截图或录制时，屏幕被放大的问题 ${AC}
Camtasia Studio 7, Screenshot
----------------------------------
右击应用选择属性，选择兼容性选项，选择更改高DPI设置，在替代高DPI缩放行为勾选上，缩放执行:应用程序




win10底部任务栏无响应
--------------------------
Get-AppXPackage -Name Microsoft.Windows.Cortana | Foreach {Add-AppxPackage -DisableDevelopmentMo
de -Register "\$(\$_.InstallLocation)\\AppXManifest.xml"}

Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "\$(\$_.Ins
tallLocation)\\AppXManifest.xml"}





系统文件检查器
--------------------------
sfc /scannow


EOF


