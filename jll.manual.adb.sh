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
${Fyellow}提示当前用户没在plugdev组,可以将当前用户再追加到plugdev组${AC}



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


EOF


