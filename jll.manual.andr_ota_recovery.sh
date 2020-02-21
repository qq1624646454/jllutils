#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.andr_ota_recovery.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-01-15 20:29:07
#   ModifiedTime: 2020-01-15 20:37:08

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1<<EOF

[YuTong.icard1] android-4.x   3g rmnet
OTA升级包的制作：
      1.必须基于一次AP全编译后所生成的M160Y-ota-eng.root.zip
         一般客户的需求会让锐骐研发工程师进行功能定制，改动后需要执行一次全编译并生成M160Y-ota-eng.roog.zip：
                out/M160Y/target/product/M160Y/M160Y-ota-eng.root.zip
      2.新建工作目录:
         为了更好地管理，请在OTA_Maker目录下新建基于制作当天的日期的文件夹及子目录ws,制作的工作目录是ws。
         比如在2020-01-14制作的ota包
           cd   /workspace/M160NPSHIP/M160NP/OTA_Maker/
           mkdir  -pv   2020-01-14/ws
           cd  2020-01-14/ws
      3.拷贝M160Y-ota-eng.root.zip到工作目录，解压并删除未改动的文件和文件夹
       （可从相关研发工程师那边确认和SVN提交记录进行确认）
           cp  -rvf   ../../../out/M160Y/target/product/M160Y/M160Y-ota-eng.root.zip   ./
           unzip  M160Y-ota-eng.root.zip  -d  ./M160Y-ota-eng.root
           cd  M160Y-ota-eng.root
        经过确认，本次改动主要涉及两大功能:
                在内核中添加adb root和adb shell的鉴权功能，必须保留boot.img
                移除/system/custom-app/VBSP_ven.apk  (需要修改updater-script)
          (1).删除非改动的文件及文件夹
              M160Y-ota-eng.root
              ├── boot.img   #Must be hold because it is updated
              ├── META-INF
              │   ├── CERT.RSA
              │   ├── CERT.SF
              │   ├── com
              │   │   ├── android
              │   │   │   ├── metadata
              │   │   │   └── otacert
              │   │   └── google
              │   │       └── android
              │   │           ├── update-binary
              │   │           └── updater-script   #Should be modified
              │   └── MANIFEST.MF
              └── system
                  ├── build.prop    #Not modify because riv_ota_pkg_maker_M120A_M160NP.sh will modify it
                  └── build.prop.bakforspec #The same to build.prop
           (2).修改 M160Y-ota-eng.root/META-INF/com/google/android/updater-script
               mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");
               package_extract_dir("system", "/system");
               symlink("/system/build.prop", "/system/vendor/Default/system/build.prop.link");
               set_metadata("/system/vendor/CTA/system/build.prop", "uid", 0, "gid", 0, "mode", 0644, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0");
               show_progress(0.200000, 0);
               delete_recursive("/system/custom-app/VBSP_ven.apk");
               show_progress(0.200000, 10);
               package_extract_file("boot.img", "/dev/block/platform/msm_sdcc.1/by-name/boot");
               show_progress(0.100000, 0);
               unmount("/system"); 
      4.开始制作ota包：
          在工作目录下，执行如下命令并带上第一个参数，即 版本号（版本号不含eng.root.，仅保留后段年月日.时分秒），
          同时还可以带第二个参数，即release说明，第二个参数是可选的，如果不带第二个参数，制作ota包过程中，会用
          vim自动打开release文件要求写release说明。如下操作实例：
         【注：命令必须一条执行完再执行下一条，一条命令可完成一个版本号的ota包】

          riv_ota_pkg_maker_M120A_M160NP.sh  20180616.182001 "support adb root login permission and vbsp_ven.apk is removed" 

EOF

