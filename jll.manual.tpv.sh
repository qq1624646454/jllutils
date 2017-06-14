#!/bin/bash
#

# adapt to more/echo/less and so on
  ESC=
  AC=${ESC}[0m
  Fblack=${ESC}[30m
  Fred=${ESC}[31m
  Fgreen=${ESC}[32m
  Fyellow=${ESC}[33m
  Fblue=${ESC}[34m
  Fpink=${ESC}[35m
  Fseablue=${ESC}[36m
  Fwhite=${ESC}[37m
  Bblack=${ESC}[40m
  Bred=${ESC}[41m
  Bgreen=${ESC}[42m
  Byellow=${ESC}[43m
  Bblue=${ESC}[44m
  Bpink=${ESC}[45m
  Bseablue=${ESC}[46m
  Bwhite=${ESC}[47m

GvShellObject="$0"
GvShellObject="$(basename ${GvShellObject})"

more >&1 << EOF
${Bpink}***************************************${AC}
${Bpink}** Asta N                              ${AC}
${Bpink}***************************************${AC}

${Fyellow}mkdir -pv ~/workspace/androidn_2k16_mtk_mainline${AC}
${Fyellow}cd ~/workspace/androidn_2k16_mtk_mainline${AC}
${Fseablue}repo init -m manifest_new_structure_v1.xml -u ssh://gerrit/platform/manifest -b  tpvision/androidn_2k16_mainline${AC}
${Fyellow}repo sync${AC}

${Fyellow}set_n${AC}
${Fyellow}cd android/n-base/${AC}
${Fseablue}./device/tpvision/common/sde/upg/build_philipstv.sh -p QM16XE_U${AC}

${Fgreen}git push origin HEAD:refs/for/tpvision/androidn_2k16_mtk_mainline${AC}


${Bpink}***************************************${AC}
${Bpink}** Asta N: Home is not shown           ${AC}
${Bpink}***************************************${AC}
${Fseablue}settings put secure user_setup_complete 1${AC}


${Bpink}***************************************${AC}
${Bpink}** Test Web site                       ${AC}
${Bpink}***************************************${AC}
${Fseablue}www.connectedplanet.tv/olvs/test/${AC}






===== The Branch before 2017.March.07 =====
mkdir -pv ~/workspace/androidn_2k16_mainline
cd ~/workspace/androidn_2k16_mainline
repo init   -u ssh://gerrit/platform/manifest -b  tpvision/androidn_2k16_mainline
repo sync

# apply the patch namely overwrite init.sh
~/workspace/Asta_Upgrade_M2N/compilation/jll_apply_patch.sh

# compile as QM16XE_U-userdebug
set_N
source build/envsetup.sh
lunch  QM16XE_U-userdebug
export ANDROID_L_2K15_MTK_EU_BUILD=1

cd system/core/libsparse/
mma
cd -

make -j32 DM_VERITY=false mtk_build 2>&1 | tee make.mtk_build.log

make -j32 mtk_clean 2>&1 | tee make.clean.log



*************************************** 
** Asta M 
***************************************

# Pure Project
repo init -m default_tpvision.xml  -u ssh://gerrit/platform/manifest -b tpvison/aosp_6.0.1_r10_asis 
repo sync

# Partically Integrate TPVISION
repo init -m default_tpvision_mport.xml -u ssh://gerrit/platform/manifest -b tpvison/aosp_6.0.1_r10_asis
repo sync

# Development Branch
repo init -m default_tpvision_mport.xml -u ssh://gerrit/platform/manifest -b tpvision/aosp_6.0.1_r10_selinux
repo sync


source build/envsetup.sh
lunch QM16XE_F-userdebug 


*************************************** 
** 2k16 Asta project  
***************************************

 #
 # Development Branch Version - don't update version
 #
 mkdir -pv 2k16_mtk_ppr1refdev
 cd 2k16_mtk_ppr1refdev
 repo init -m default_head.xml -u ssh://gerrit/platform/manifest -b tpvision/2k16_mtk_ppr1refdev
 repo sync

 #
 # Product Branch Always Latest Version - the version information can align with offically release. 
 #      Latest Version but don't ensure stable due to some functions aren't tested.
 mkdir -pv ~/2k16_mtk_ppr1devprod
 cd ~/2k16_mtk_ppr1devprod
 repo init -m default_head.xml -u ssh://gerrit/platform/manifest -b tpvision/2k16_mtk_ppr1devprod
 repo sync

 #
 # Product Branch Version - the version information can align with offically release. 
 #      Latest Version and ensure stable
 mkdir -pv ~/2k16_mtk_ppr1devprod
 cd ~/2k16_mtk_ppr1devprod
 repo init -m default.xml -u ssh://gerrit/platform/manifest -b tpvision/2k16_mtk_ppr1devprod
 repo sync


***************************************
** 2k17 msaf
***************************************
http://172.16.112.62/mediawiki/index.php/2k17_Android_prj#Code_Release_Branch_Diagram

Host url-tpe 
HostName 172.16.112.71 
User zhibo.chen 
Port 29418 
IdentityFile ~/.ssh/id_rsa


repo init -u ssh://url-tpe/tpv/platform/manifest -b 2k17_mtk_archer_m_refdev
repo sync



git push ssh://url-tpe/tpv/device/tpv/common/app/contentexplorer HEAD:refs/for/2k17_mtk_archer_m_refdev 
git push ssh://url-tpe/tpv/device/tpv/common/plf/exoplayer HEAD:refs/for/2k17_mtk_archer_m_refdev




*************************************** 
** 2k16 Archer branch on Msaf project  
***************************************
 mkdir -pv 2k16_mtk_archer_refdev
 cd 2k16_mtk_archer_refdev
 repo init -u ssh://url/tpv/platform/manifest -b 2k16_mtk_archer_refdev
 repo sync

 cd android/l-mr1-tv-dev-archer/
 source build/envsetup.sh
 lunch    # PH6M_EU_FHT-userdebug
 make -j8 mtk_clean 2>&1|tee make.mtk_clean.log
 make -j8 mtk_build 2>&1|tee make.mtk_build.log
 
( Note: Version TPM161E.0.0.123.0 )
( Note: MTK release tarball: \\172.16.114.19\2k16_msaf\Release\MTK_release_Archer )
( Note: Wiki:  http://172.20.30.3/xmicwiki/index.php/Main_Page )
( Note: OpenGrok for Archer source review: http://172.16.114.16:8080/opengrok/ )


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





*************************************** 
** 2k16 mprep branch on Asta project  
***************************************
 mkdir -pv  2k16_mprep_refdev
 cd 2k16_mprep_refdev 
 repo init -m default_head.xml -u ssh://gerrit/platform/manifest -b tpvision/2k16_mprep_refdev
 repo sync


************************************************* 
** Code Update By Git Run jll.CodeUpdateByGit.sh
************************************************* 



**************************************************************************** 
** Infra
**************************************************************************** 
Auto_Standby_On_Startup {
    If system is still enterred to Standby after reboot, please do the follows:
    # Modify the Power state
    setprop sys.droidtv.target_bootlevel full
    # Modify the NVM:0x1000 to 1
    1.ESC is pressed on startup
    2.DTV> cd eeprom
      DTV> dump 0x1000 1
    [if its value is 0, namely the target power state is standby]
      DTV> wb 0x1000 1
}

Lookup_Status_Of_TVPower {
    dumpsys TV_POWER_SERVICE
}



******** TPVision Android Logcat For UDisk
** Create the file TPVisionDebug.cookie to U-Disk(/storage/sda1/)
** Plug-in U-Disk to Dut
**
** Stop to capture the logcat to U-Disk, please press RC as follows:
**  456789info
** 


********* Code Review and Image Release 
** OpenGrok
**     http://172.16.114.16:8080/opengrok/
**     http://2k15mvl-xref.tpvision.com:8080/source/  
** Release
**     http://tux.tpvision.com/Android_Releases/official_product_releases/Miscellaneous/PRODUCTION_IMAGES/
**


********* Bugs 
** URTracker
**     http://fwtrack.tpvaoc.com/Pts/Home.aspx
**


********* 2k15 EU FHT & UPLUS
**
**
 mkdir -pv 2k15_mtk_1446_1_devprod
 cd 2k15_mtk_1446_1_devprod
 repo init -m default_head.xml -u ssh://gerrit/platform/manifest -b tpvision/2k15_mtk_1446_1_devprod
 repo sync


********* 2k15 LT
** reference to http://172.20.30.3/xmicwiki/index.php/Latin_America_Project
**
 mkdir -pv 2k15_mtk_1446_1_devprod_LT
 cd 2k15_mtk_1446_1_devprod_LT
 repo init -u ssh://url/devprod/platform/manifest -b 2k15_mtk_1446_1_devprod_LT 
 repo sync

**-------------------------
 source build/envsetup.sh
 lunch philips_MT5593HT_LT-userdebug
 export TPVISION_ANDROID_CONSOLE_ENABLED=1
 make -j8 DM_VERITY=false mtk_build  2>&1 | tee make.log
 



********* Don't show any prompt after type 'cli'
 su
 echo 7 > /proc/sys/kernel/printk
 cli
 


********* Email
** ms-outlook 
**     Microsoft Exchage:  hqcasarray.tpvaoc.com
** web-outlook
**     https://hqmx.tpvaoc.com/owa/
**


********* Debug For Marvell (Mrvl)
** ampdiag lsmod
** ampdiag setmodl ADEC 255
**
**

********* Putty
    Ctrl_s : blocking the all events on Putty
    Ctrl_q : restore from blocking


********* Some issues when install apk from app gallery 
** there is no storage device to install the app
**
** First check   "getprop persist.sys.storage.eas_enabled" if it is 1
** Second modify "setprop persist.sys.storage.eas_enabled 0" if it is 1 
** Third  reboot the system
**
** If still meet some issues such as no enough space to install app
** then please reinstall via Settings
**



******** app gallery Key
**
make a folder /factory_settings/icp
copy databag.zip to /factory_settings/icp

Note: databag.zip and databag2.zip are two different gallery keys separately.




******** Netflix Key <=> RPMB KEY
**
Step0:
  su
  echo "7 4 1 7">/proc/sys/kernel/printk
Step1:
  cli
  eeprom.wb 0x1182 0
  eeprom.wb 0x1183 0 
Step2:
  re-flash NVM.BIN and OPTION.BIN

But regarding 2k17 msaf, it is address:0x974/value:0, address:0x975/value:0




pm clear org.droidtv.icp
pm clear org.droidtv.nettvregistration
sync
reboot





******** Generate SSH KEY 
**
==> 1.Generate the ssh key
$ ssh-keygen -t rsa -C "YOUR MAIL"
==> 2.Add SSH Key
$ vim ~/.ssh/id_rsa.pub
COPY ALL content to clipboard
==> 3.Open https://172.16.112.71/tpv-review/login/c/11864/
==> 4.Switch the view at SSH Public Keys and paste the content to a new key



******** Lookup the sync & update about TPV/TPVIsion and Mediatek
**
\\172.20.30.11\Dailybuilds\MTK\MTK_tarball_release\Android_M\wk1621.1_DTV_X_IDTV1402_368_001_233_001_11



******** Upgrade the FRC-NT324/NT333
**
1.mkdir -pv upgrades on the top directory of USB-Disk
2.put the upg under Tooling_QM16XE_U_xxx on upgrades of USB-Disk
3.Plug-in USB-Disk to TV
4.Select Settings/upgrade to accomplish local upgrade


******** Compile into upg file
**
cd device/tpvision/common/sde/upg/
# Full upg
./upgmaker.sh QM16XE_U r f
# Tool upg
./upgmaker.sh QM16XE_U r t 



******** upgrade without UI
**
1.	cp /storage/****/upgrades/Full* /cache/tvupgrades;sync
2.	echo “—update_package=/cache/tvupgrades/Full*” > /cache/recovery/command
3.	reboot recovery



******** How to Enter Factory Settings From TV Set 
**
Press RC as below keys:
[home]+[1]+[9]+[9]+[9]+[Back]



******** How to Show CSM information From TV Set 
**
Press RC as below keys:
[1]+[2]+[3]+[6]+[5]+[4]




******** Code Stream Instrument
**
1.Remote Connect to 172.20.30.38, user=DMX\\test, password=0.123456789
2.Run StreamXp on Desktop to open your Code Stream File such as Xxx.ts,
  And set the correct channel 474. Final click play
3.Make TV search channel. 



******** All TSR From Wiki-gdc 
**
Projects List: 
1) 2K16 - PPR1 (F & U+) 
2) 2K15 - MTK - PPR2 - Mainline (FHT & U+) 
3) 2K15 - Marvell - TV - All branches 
4) 2K15 - Marvell - HEVCBOX 
TSR URL  : http://marvell2k15tsruploader.tpvision.com/uploadfiles/ 
Login name = marvell2k15user  ; Password = marvell2k15_user 
----------------
Projects List: 
1) 2K16 - PPR1 (F & U+) 
2) 2K15 - MTK - PPR2 - Mainline (FHT & U+) 
3) 2K15 - MTK - PPR2 - MP branch (FHT & U+) 
4) 2K15 - MTK - PPR1 Branch (FHT only) 
TSR URL  : http://mtk2k15tsruploader.tpvision.com/uploadfiles/ 
Login name = mtk2k15user  ; Password = mtk2k15_user 
----------------
Project : 2K14 Marvell 
TSR URL  : http://marvell2k14tsruploader.tpvision.com/uploadfiles/ 
Login name = marvell2k14user  ; Password = marvell2k14_user 
----------------
--> Sudharsan on 01-Dec-2015. 
Retrieved from http://pww.ud1.brg.sv.philips.com/wiki-gdc/index.php?title=All_TSR_Information






******** How to setprop xxx in Production Version
**
1.mkdir -pv upgrades on the top directory of USB-Disk

2.put "SetLogLevel_mtkUplus_prod.upg" under Tooling_QM16XE_x_xxx on upgrades of USB-Disk

3.put "TpvVerboseLog.txt" on root top path of USB-Disk, the content of TpvVerboseLog.txt as follows:
persist.sys.jll_alog 1
persist.sys.mp.ffmpeg.log 1
persist.tpvlog.smtv 1 
persist.sys.jll_callstack 1

4.Plug-in USB-Disk to TV

5.Select upgrade by "SetLogLevel_mtkUplus_prod.upg" to accomplish local upgrade





******** How to Pack Up Changed Files Recognised By git status -s into Patch for Merging in Project
**
>>>Requirement:
(1).Modifying some files in "/mnt/localdata/localhome/jielong.lin/workspace/aosp_6.0.1_r10_selinux"
(2).Wanna pack up those changed files into 
  "/mnt/localdata/localhome/jielong.lin/workspace/jllrepository/drmtracer/Failed_to_find_drm_plugin" 
>>>Actions:
  User@Ubuntu:.$ mkdir -pv Failed_to_find_drm_plugin
  User@Ubuntu:.$ cd Failed_to_find_drm_plugin
  User@Ubuntu:.$ jll.patchs_for_merge.sh
    (1).Check if .settings.conf is present.If it doesn't exist, automatically generated and you are
        asked for custom via edit .settings.conf
    (2).Check if GvCONF_Project is path and contains the Project Root path with .repo;
    (3).All changed files are recognised and summarized to All_Git_Repositories_Status.jll under the
        Project Root path;
        Done by repo forall -c 'if [ x"\$(git status -s)" != x ]; then echo;pwd;git status -s; fi'
    (4).Parse the All_Git_Repositories_Status.jll for retrieving all changed files into Source Pool;
    (5).When loop through Source Pool,create path tree for every changed file and then copy the
        file into this path tree;
    (6).Meanwhile, generate the 'vim -d project_file patch_file' script to jll.merge_to_project.sh; 
    (7).Finally, the project location of every changed files are also stored in filelist.txt;
  User@Ubuntu:.$ ls -al
    total 44
    drwxr-xr-x 6 jielong.lin MediaPlayer 4096 Aug 25 16:53 .
    drwxr-xr-x 5 jielong.lin MediaPlayer 4096 Aug 25 14:48 ..
    -rw-r--r-- 1 jielong.lin MediaPlayer  934 Aug 25 16:53 All_Git_Repositories_Status.jll
    drwxr-xr-x 3 jielong.lin MediaPlayer 4096 Aug 25 16:53 cts
    drwxr-xr-x 3 jielong.lin MediaPlayer 4096 Aug 25 16:53 device
    -rw-r--r-- 1 jielong.lin MediaPlayer  881 Aug 25 16:53 filelist.txt
    drwxr-xr-x 3 jielong.lin MediaPlayer 4096 Aug 25 16:53 frameworks
    -rwxr-xr-x 1 jielong.lin MediaPlayer 5606 Aug 25 16:53 jll.merge_to_project.sh
    -rw-r--r-- 1 jielong.lin MediaPlayer  217 Aug 25 16:47 .settings.conf
    drwxr-xr-x 3 jielong.lin MediaPlayer 4096 Aug 25 16:53 vendor

>>>How to Use For Merge task:
  First, Suggest you get a pure project code without any files are changed, do as follows:
      repo forall -c 'git clean -dfx; git reset --hard HEAD'
  Second, Enter the Patch Folder and then run jll.merge_to_project.sh, such as:

  User@Ubuntu:.$ cd ~/workspace/jllrepository/drmtracer/Failed_to_find_drm_plugin
  User@Ubuntu:.$ ./jll.merge_to_project.sh 
      




******** 2k15 LatAM Project 
**
<<WiKi>>
http://172.20.30.3/xmicwiki/index.php/Latin_America_Project

<<Ftp Entry>> 
\\\\172.16.112.52

<<Offical Release>>
\\\\172.16.112.52\\Bin_For_Release\\2k15_LT

<<Checkout the Branch>>
mkdir -pv 2k15_mtk_1446_1_devprod_LT
cd 2k15_mtk_1446_1_devprod_LT
repo init -u ssh://url/devprod/platform/manifest -b 2k15_mtk_1446_1_devprod_LT 
repo sync

<<BUilding>>
cd 2k15_mtk_1446_1_devprod_LT
source build/envsetup.sh 
lunch philips_MT5593HT_LT-userdebug
export TPVISION_ANDROID_CONSOLE_ENABLED=1
make -j8 DM_VERITY=false mtk_build  2>&1 | tee make.log


<<2k15 Version Example>>
TPM156L.5.96.0.72




EOF




exit 0
####################################################################
#  Copyright (c) 2015.  lin_jie_long@126.com,  All rights reserved.
####################################################################


