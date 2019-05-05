#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.reachxm.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 08:48:41
#   ModifiedTime: 2019-05-06 00:21:43

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF


   mkdir -pv lora_endnode_dev
   cd lora_endnode_dev/
   ../git-repo/repo init -u ssh://lora.reachxm.com/lora_endnode/platform/manifest -m reach.xml -b master --config-name --repo-url=\$(pwd)/../git-repo
   ../git-repo/repo sync
   #../git-repo/repo start master --all
   #Switch to ATcmd from remotes/origin/ATcmd
   ../git-repo/repo forall -c 'git checkout -b ATcmd remotes/origin/ATcmd'



   git clone  https://mirrors.tuna.tsinghua.edu.cn/git/git-repo
   mkdir -pv L170L
   cd L170L
   ../git-repo/repo init -u ssh://L170L_2plus1.reachxm.com/L170L/platform/manifest \\
                    -b master --config-name --repo-url=\$(pwd)/../git-repo
   ../git-repo/repo sync
   ../git-repo/repo start master --all
   cd .repo/manifests
   git checkout -b master
   cd ../repo
   git checkout -b master
   cd ../.. 



${Bgreen}${Fblack} How to create the new remote branch ${AC}
   ../git-repo/repo start --all  new-branch-name
   ../git-repo/repo forall -c 'git push -u origin new-branch-name'



${Bgreen}${Fblack} How to retrieve L170L 2+1 Project ${AC}
${Fgreen}1).项目配置环境安装：${AC}
   1-1).请安装好git, repo,ssh工具
   1-2).请管理员忙新建gerrit账号，生成SSH KEY并在Gerrit上绑定SSH Public Key及邮箱，
        同时将账号归入到L170_Member组中.完成gerrit服务器账号创建后，管理员会向各位
        提供SSH Private Key及gerrit的用户名及密码
   1-3).在~/.ssh/目录下新建config文件
         Host          L170L_2plus1.reachxm.com
         HostName     gerrit.reachxm.com
         User          你的Gerrit账号的用户名
         Port          29418
         IdentityFile  ~/.ssh/id_rsa
       把SSH Private Key放入~/.ssh/目录下

${Fgreen}2).下载项目：L170L 2+1${AC}
mkdir -pv L170L_2plus1
cd L170L_2plus1

repo init -u ssh://L170L_2plus1.reachxm.com/L170L_2plus1/platform/manifest -b master --config-name
repo sync
repo start master --all

${Fgreen}3).编译项目：L170L 2+1${AC}
在L170L_2plus1项目根目录下，通过make_by_reachxm编译脚本可以完成整套项目的编译，打包等工作:

./make_by_reachxm h #查看工具的用法

#编译APSS和MPSS并打包为QPST和QMSCT软件包
./make_by_reachxm APSS MPSS 9607.lwgniag.prod for2K hasClean hasPackingForQPST hasPackingForQMSCT 




${Bgreen}${Fblack} How to build recovery${AC}
1.modify source code under apps_proc/bootable/recovery
2.set environment variabiles:
    cd apps_proc/poky
    source build/conf/set_bb_env_L170H.sh
3.clean then compile target - recovery
    MACHINE=mdm9607 rebake recovery 
    cdbitbake machine-recovery-image 
4.Retrieve target:
    apps_proc/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-recovery.ubi 
5.Flash:
    adb reboot bootloader
    fastboot flash recoveryfs apps_proc/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-recovery.ubi

${Bgreen}${Fblack} Custom the /etc/init.d/reachservice.sh${AC}
/media/root/work/jllproject/trunk_xghd/apps_proc/poky/meta-qti-bsp-prop/recipes-bsp/reach-services/reach-services_0.0.bb
/media/root/work/jllproject/trunk_xghd/apps_proc/mcm-api/mcm_sample/reach-services/reachservices.sh


${Bgreen}${Fblack}[Ctrl]+[Alt]+[T] ${Fred}# Run Terminate in a separated windows${AC}
~# ${Fyellow}cd /media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky ${AC}
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky# ${Fyellow}source build/conf/set_bb_env_L170H.sh${AC}

# mbuild will first clean then compile
/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc/poky/build# ${Fyellow}mbuild linux-quic${AC}

# originial method to build all
buildclean
build-9607-image

# script method to build all
cd buildapp
./buildL170HSHIP app

#out: apps_proc/poky/build/tmp-glibc/deploy/images/mdm9607






${Bgreen}${Fblack}[Ctrl]+[Shift]+[T] ${Fred}# Run Terminate in a separated table of the same windows${AC}
   adb reboot-bootloader
   fastboot devices
   fastboot flash boot mdm9607-boot.img
   fastboot reboot

${Fseablue} Suggestion: make a script to run the above commands ${AC}
  ${Fyellow}vim ./fl.sh${AC}
  ${Fyellow}#!/bin/sh${AC}
  ${Fyellow}adb reboot-bootloader${AC}
  ${Fyellow}fastboot devices${AC}
  ${Fyellow}fastboot flash boot mdm9607-boot.img${AC}
  ${Fyellow}fastboot reboot${AC}


Lk:      fastboot flash aboot  appsboot.mbn
Kernel:  fastboot flash boot   mdm9607-boot.img
System:  fastboot flash system mdm9607-sysfs.ubi

# fast compile kernel
# 可以在apps_proc\oe-core\build\tmp-glibc\work-shared\mdm9607\kernel-source修改代码
# 验证正确后，需要手动把代码同步到apps_proc/kernel目录
# 使用以下命令编译
bitbake linux-quic -c compile -f   //编译kernel
bitbake linux-quic -c deploy -f    // 更新镜像


adb reboot bootloader
fastboot erase efs2 #如果出现无法擦除，说明是被tz锁住了，请重新编译tz即可
fastboot reboot



####################################################################
    L170L_2plus1
####################################################################
1).项目配置环境安装：
   在~/.ssh/目录下新建config文件
         Host          L170L_2plus1.reachxm.com
         HostName      gerrit.reachxm.com
         User          你的Gerrit账号的用户名
         Port          29418
         IdentityFile  ~/.ssh/id_rsa
   把SSH Private Key放入~/.ssh/目录下
2).下载项目：L170L 2+1
   git clone  https://mirrors.tuna.tsinghua.edu.cn/git/git-repo
   mkdir -pv L170L_2plus1
   cd L170L_2plus1
   ../git-repo/repo init -u ssh://L170L_2plus1.reachxm.com/L170L_2plus1/platform/manifest \\
                    -b master --config-name --repo-url=\$(pwd)/../git-repo
   ../git-repo/repo sync
   ../git-repo/repo start master --all

3).编译项目：L170L 2+1
  在L170L_2plus1项目根目录下，通过make_by_reachxm编译脚本可以完成整套项目的编译，打包等工作:
  ./make_by_reachxm h #查看工具的用法

  #编译APSS和MPSS并打包为QPST和QMSCT软件包
  ./make_by_reachxm APSS MPSS 9607.lwgniag.prod for2K hasClean hasPackingForQPST hasPackingForQMSCT



EOF

