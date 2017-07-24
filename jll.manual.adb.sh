#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1 <<EOF

===============================================================================================
1.首先需要在Android设备上使能USB方式的ADB功能，不同的android厂家设备有不同的方法：
    以Philips TV为例：
          (1).开机时按住SPACE键进入Uboot命令行模式，输入 
                mt5890 #  addboot ssusb_adb=1
          (2).确认使能信息已经配置到系统中
                mt5890 #  pri
                ... ssusb_adb=1 ...
          (3).重启系统
                 mt5890 # reset

2.让Linux识别所有USB连接，这里有两种方法: 
2.1.USB设备连接时，udev自动探测识别，在下强烈强烈推荐。
    jielong.lin@TpvServer:~$  sudo vim /etc/udev/rules.d/50-android.rules
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", GROUP="plugdev"

    jielong.lin@TpvServer:~$  sudo chmod 0777 /etc/udev/rules.d/50-android.rules

2.2.USB设备连接时，手动地去获取USB设备的标识符并配置到udev规则当中，要是有多个USB设备，
    会很麻烦，在下不推荐。
(1).使用USB线（公对公）连接 Philips TV 和 Ubuntu，在Ubuntu系统上检查是否识别到PhilipsTV设备：
    tpv@TpvUbuntu:~#  lsusb
    Bus 004 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
    Bus 004 Device 001: ID 1d6b:0002 linux Foundation 2.0 root hub
    Bus 003 Device 004: ID 04f2:b2fa Chicony Electronics Co., Ltd
    Bus 003 Device 003: ID 147e:1002 Upek Biometric Touchchip/Touchstrip Fingerprint Sensor
    Bus 003 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
    Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    Bus 001 Device 006: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
    Bus 001 Device 003: ID 17ef:6019 Lenovo
    Bus 001 Device 010: ID 18d1:0d02 Google Inc. Celkon A88
    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
NOTE:   idVendor=0x18d1,    idProduct=0x0d02
(2).让Ubuntu支持USB所连接的Android设备. 
    tpv@TpvUbuntu:~#  sudo echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="0d02", MODE="0600" , OWNER=="jielong.lin" ' >  /etc/udev/rules.d/50-android.rules
    tpv@TpvUbuntu:~#  chmod  0777  /etc/udev/rules.d/50-android.rules
    tpv@TpvUbuntu:~#  mkdir  -pv  ~/.android
    tpv@TpvUbuntu:~#  echo '0x18d1' >  ~/.android/adb_usb.ini

3.保证当前用户在plugdev组当中
    groups
    # 如果没在plugdev，请加入：
    chmod usermod -a -G plugdev \$(whoami)

4.验证测试
    # If failure but android studio has been installed, 
    # you can use platform-tools/adb in Android Studio
    sudo aptitude install android-tools-adb  
    # 重新以普通用户账号登录...  
    adb kill-server
    adb devices
    adb shell
    xxx@QM16XE_U:/ # 




${Bred}                                                              ${AC}
${Bred} ${AC}no permissions (udev requires plugdev group membership)
${Bred}                                                              ${AC}
${Fyellow}提示当前用户没在plugdev组,可以将当前用户再追加到plugdev组${AC}
sudo usermod -a -G plugdev jielong.lin
exit 0 # re-login jielong.lin
groups


${Bred}                                                              ${AC}
${Bred} ${AC}no permissions (verify udev rules)
${Bred}                                                              ${AC}
${Fyellow}配置文件/etc/udev/rules.d/50-android.rules存在问题,请参考如下配置${AC}
${Fyellow}  注：Linux可以识别所有USB设备 ${AC}
sudo vim /etc/udev/rules.d/50-android.rules
${Fgreen}SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0666", GROUP="plugdev"${AC}





>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
||      USB ADB Usage
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# 0.Lookup the actived USB ADB Device
adb devices

# 1.Remount the TV Set with rw property.
adb remount

# 2.Suppose that push [LOCAL] D:\\file.txt into [TV Set] system/
#       <LOCAL> ==> <Remote_Android>
#   adb push  <LOCAL_PATH_FILE>  <REMOTE_PATH_FILE>
adb push D:\\file.txt system/
   
# 3.Suppose that pull [TV Set] system/file.txt into [LOCAL] D:/
#       <Remote_Android> ==> <LOCAL>
#   adb pull  <REMOTE_PATH_FILE>  <LOCAL_PATH_FILE>
adb pull system/file.txt  D:/ 

-----------------------------------------------------------------------
adb pull: Get file from Remote Android Device
adb push: Put file into Remote Android Device

Environment Condition:
                             USB ADB 
  [Remote_Android_Device] ============= [Local_Computer]
  Android Philips TV Set  ------------- My Computer
                                        1: run ConEmu.exe
                                        2: adb devices
                                        3: adb remount
                                        4: adb pull <Android_Philips_TV_Set> [My_Computer] 
    eg-1: adb pull system/lib/drm/libdrmplayreadyplugin.so 
    eg-2: adb pull system/lib/drm/libdrmplayreadyplugin.so  /W/androidn_2k16_mainline 
                                        5: adb push <My_Computer> <Android_Philips_TV_Set>
    eg-3: adb pull libdrmplayreadyplugin.so   system/lib/drm
    eg-3: adb pull /W/androidn_2k16_mainline/libdrmplayreadyplugin.so  system/lib/drm







>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
||      USB ADB Settings
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
For TV Set: (no matter what is Asta or Msaf)
-----------------------------------------------------
1.reboot the TV Set with pressing the space key untill "mt5890 #" is shown up 
2.input the below commands:
mt5890 # addboot androidboot.selinux=permissive
mt5890 # addboot ssusb_adb=1
mt5890 # addboot adb_enable=1
mt5890 # addboot adb_port=1
mt5890 # pri 
mt5890 # saveenv
3.reboot the TV via reset command in "mt5890 #"
mt5890 # reset
4.And then type following command  (JLL: optional)
su 
setprop persist.sys.usb.config adb 
setprop sys.usb.config adb 
setprop sys.usb.state adb 
setprop service.adb.root 1 
setprop service.adb.tcp.port 5555 
5.IF windows7 can not recognize the USB ADB device, please do the follows:
    stop adbd 
    start adbd
  If it still can not recognize the USB ADB device, please do the follows:
    Enter "developer option" menu from "main home"/"Settings"
    Disable "USB debugging" and then re-enable "USB debugging"
  If it still can not recognize the USB ADB device, you finally do the follows:
    Enter the "Devices Manager" on Windows7 then update the USB driver 
    until "Android Phone" can be observed.

After system run Android Home UI successfully, Please enable developer options
for enabling USB ADB, For Example: Android N(7.0)
-----------------------------------------------------
1.Settings-->Android Settings-->Device-->About-->Build:
    Click Multilse times until the developer mode enable is seen.
2.Back to Settings-->Developer options-->USB Debugger

re-plugin to build the connection between device and host, and the below log
will be shown:
[  259.023838] android_work: sent uevent USB_STATE=DISCONNECTED
[  259.111722] android_work: sent uevent USB_STATE=CONNECTED
[  259.115836] android_work: sent uevent USB_STATE=DISCONNECTED
[  259.219065] android_work: sent uevent USB_STATE=CONNECTED
[  259.312972] android_usb gadget: high-speed config #1: android
[  259.316890] android_work: sent uevent USB_STATE=CONFIGURED





>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
adb via USB on 2k17 msaf
------------------------------------------------

mt5890 #
addboot androidboot.selinux=permissive
addboot ssusb_adb=1
addboot adb_enable=1
addboot adb_port=1
saveenv
reset



${Bred}${Fblack}                                                                              ${AC}
${Bred} ${AC}If multise USB devices, please use -s <deviceName> to specify the usb device.
${Bred}${Fblack}                                                                              ${AC}
${Fred}such as : ${AC}
${Fgreen}adb devices ${AC}
List of devices attached
0123456789ABCDEF	device
emulator-5554	device
${Fgreen}adb -s emulator-5554 shell ${AC}


EOF


