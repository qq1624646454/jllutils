#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

===================================================================
 Drm Key | How to flash the key to active the DRM 
-------------------------------------------------------------------
For 2k15 EU Platform to flash the key, it isn't use usb dongle to 
implement
===================================================================
1.Upgrade the system by upgrade_loader.pkg contained nvm.
2.Upgrade the only factory setting by Upgrade_Only_factory_setting.pkg
  ==>rename Upgrade_Only_factory_settings.pkg into upgrade_loader.pkg
  ==>Upgrade as the same to step 1
3.create a folder "usb_key_dir" in USB stick root
4.Put the key in the folder of "usb_key_dir"
5.Put "DRM_KEY_TEST_GG" also in USB stick
6.Insert USB to TV USB port
7.connect uart tool and run Putty or teraterm
8.Type "su" in Putty or teraterm
9.Type "cp /storage/sda1/DRM_KEY_TEST_GG /system/bin/" in Putty or teraterm
10.Type "su" in teraterm
11.Type "/system/bin/DRM_KEY_TEST_GG" in teraterm after TV reboot
12.Type "ls /factory_setting" to check if the key have existed or not.

or Flashing by usb dongle
0.Ensure the network is United States line. 
1.run TVx_Secure_Key_download/Shortcut to TVx_SecKey_Download.exe
2.select MTK5593_Eu_FHT or other relevant type.



E.VPN : 8hPDXK80



===================================================================
 App Gallery Key | How to flash the key to login App Gallery 
-------------------------------------------------------------------
Usecase:
    Widevine test demo - VOYO BG or Okko
    VOYO BG or Okko use nettvbrowser and mooplayer to test Widevine
===================================================================
0.Ensure the network is United States line connected to Google. 
1.make a folder /factory_settings/icp
2.copy databag.zip to /factory_settings/icp
Note: maybe meet the issue "Could not reach the Smart TV Server at this moment", 
      maybe try to flash the NVM.BIN to TV Set.

If login APP Gallery successfully, it is done.




===================================================================
 App Gallery | How to Install VOYO BG or Okko 
-------------------------------------------------------------------
Usecase:
    Widevine test demo - VOYO BG or Okko
    VOYO BG or Okko use nettvbrowser and mooplayer to test Widevine
===================================================================
0.Ensure the network is United States line connected to Google. 
1.Login in App Gallery.
2.Select Country=Bulgaria by press RC green button 
3.Select VOYO BG APK to install in APP Gallery.
Note: If wanna to install Okko, please first select country=Russia 
4.Login VOYO BG with username=boza9  password=123456




===================================================================
 ExpressVPN | How to Test DRM Via VOYO.BG 
-------------------------------------------------------------------
WEBSITE: https://www.expressvpn.com/

Login by yayong.chen's mail : jSlk417h
==>Android Version APK: Username:yayong.chen's mail Password: 866811321


Login by jielong.lin's mail : 8hPDXK80
==>Android Version APK: Username:jielong.lin's mail Password: 863777784

How to install ExpressVPN APK for Android4 or Android5:
==> adb install expressvpn_4.13.1.397.apk
==> pm install -r /storage/00FF-224E/49PUS7101_12_131/expressvpn_4.13.1.397.apk

===================================================================






==========================================================
 issue | maximum allowed amount of this type of device
----------------------------------------------------------
You have reached a maximum allowed amount of this type of device that can be used with your VOYO account.
Please proceed to User profile where you can remove one of the devices which are currently in use.
==========================================================
To deactivate the device  , There is a device management form on the web (and also on iOS and Android applications) for each instance of VOYO.
If you refer to VOYO.bg, website client is located here:
- http://voyo.bg
- You will need to login with the same account; search on head of any page on the right hand side for  Вход  ( meaning Login ) 
- navigate to device management > point your browser to http://voyo.bg/profil/?sect=devices 
 
Interface should be straight forward, just click "X" for each device you want to remove.
 
Similar interface is available if all countries, relative path of the device management being the same ( profil/?sect=devices )
 
 
Please find the below steps for disabling the number of devices for VOYO BG app : 
- Open http://voyo.bg/welcome  in PC browser
- Select : Login(Вход)
- Login with boza9/123456
- Open  http://voyo.bg/profil/?sect=devices# in same PC browser
- Below you can see the number of X marks which need to be disabled 




*******************************************
** How to Flash Drm Key 2k17 Msaf project
*******************************************
1.Upgrade by upgrade_loader_no_perm
2.Check if /factory_setting present the below items:
  root@android:/ # ls /factory_setting/
    PSTVK000
    PSTVK001
    PSTVK003
    PSTVK004
    PSTVK010
    PSTVK013
    PSTVK014
    RpmbCheckPass
    fw
    lost+found
    widevine
  If Not, please do the followwing steps
3.Upgrade by upgrade_loader_perm_only.pkg
  it will bring RpmbCheckPass,fw,lost+found,widevine and so on.
4.Enable Factory Mode in TV Set, as follows:
  <1>.Press RC Keys: [Home]+[1]+[9]+[9]+[9]+[Back] for popup factory menu.
  <2>.Select 35 items to enable Factory Mode.
  <3>.TV Set should be rebooted then it will enter Factory Mode with green high-light T/TF on
      Right-Bottom of screen.
5.Plug-in the Blue dongle with Laptop, and ensure the Laptop can access to google without any proxy
6.Open TVx_Secure_Key_download, maybe need to modify the com port in file prod_TVx_config.ini.
7.Fill 12345678901234567890 in the blank of Product Identification (barcode)
  And select DRM Key Items.
8.Finally, Press Download Keys to start flashing DRM Keys.
9.If some errors, maybe need to flash it multise times.
10.After performing the above, should exit Factory Mode by eeprom cli, as follows:
   echo 7 >/proc/sys/kernel/printk
   cli
   eeprom.wb 0x3145 0
   eeprom.dump 0x3145 1
   quit
   reboot



If met the issue about rpmb not present, please set eeprom first before flashing NVM.bin
    eeprom.wb 0x974 0
    eeprom.wb 0x975 0

Flashing NVM.bin Then Upgrade by upgrade_loader_perm_only.pkg

Finally, Enter factory mode then flashing DRM keys by blue dongle.


EOF


