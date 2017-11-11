#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-01 21:11:31
#   ModifiedTime: 2017-11-11 23:55:30

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

function Reachxm_L170H_on_mdm9607_by_jllim()
{
    jllProject="L170H"  #
    #jllRoot="/media/root/work/mdm9607/mangov2/trunk_yxlog/apps_proc"
    jllRoot="/media/root/work/jllproject/trunk_L170H/apps_proc"

    #####################################################################

    JLLPATH="$(which jll.god.sh)"
    JLLPATH="$(dirname ${JLLPATH})"
    if [ ! -e "${JLLPATH}/BashShellLibrary" ]; then
        echo
        echo -e "[0m[31mjllim: Error - not found BashShellLibrary[0m"
        echo
        exit 0
    fi
    source ${JLLPATH}/BashShellLibrary

    declare -a GvMenuUtilsContent=(
        "CodeTree: Enter"
        "Kernel:   Build"
        "Kernel:   Flash"
        "All:      Build"
        "All:      Flash"
        "All:      Update and reBuild"
        "Usage:    Help Information"
    )
    GvMenuUtilsContentCnt=${#GvMenuUtilsContent[@]}

    while [ 1 -eq 1 ]; do
        Lfn_MenuUtils GvResult  "Select" 7 4 \
            "***** ${jllProject} Main MENU (q: quit no matter what) *****"
        GvResultID=0

        # "CodeTree: Enter"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo

            declare -a GvMenuUtilsContent=(
                "kernel path"
                "mcm-api path"
                "build path"
                "images path"
            )
            GvMenuUtilsContentCnt=${#GvMenuUtilsContent[@]}
            Lfn_MenuUtils GvResult  "Select" 7 4 \
                "***** ${jllProject} CodeTree MENU (q: quit no matter what) *****"
            GvResultID=0
            #kernel path
            if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
                clear
                [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
                [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
                jllTarget="${jllRoot}/kernel/msm-3.18"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #mcm-api path
            if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
                clear
                [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
                [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
                jllTarget="${jllRoot}/mcm-api"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #build path
            if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
                clear
                [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
                [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
                jllTarget="${jllRoot}/poky"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            #images path
            if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
                clear
                [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
                [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
                jllTarget="${jllRoot}/poky/build/tmp-glibc/deploy/images"
                if [ -e "${jllTarget}" ]; then
                    cd ${jllTarget}
                else
                    echo -e "Not found ${Fred}${jllTarget}${AC}"
                fi
                break 
            fi
            echo
            break; 
        fi

        #"Kernel:   Build"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            cd ${jllRoot}/poky
            source build/conf/set_bb_env_${jllProject}.sh
            mbuild linux-quic
            echo
            break;
        fi

        #"Kernel:   Flash"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img"
                break;
            fi
            cd ${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607
            adb reboot-bootloader
            fastboot devices
            fastboot flash boot mdm9607-boot.img
            fastboot reboot
            cd - >/dev/null 
            echo
            break;
        fi

        #"All:      Build"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            if [ 1 -eq 1 ]; then
                cd ${jllRoot}/poky
                source build/conf/set_bb_env_${jllProject}.sh
                buildclean
                build-9607-image
            else
                if [ ! -e "${jllRoot}/buildapp/build${jllProject}SHIP" ]; then
                    echo -e \
                    "JLLim: Not found ${Fred}${jllRoot}/buildapp/build${jllProject}SHIP${AC}"
                    break;
                fi
                cd ${jllRoot}/buildapp
                ./build${jllProject}SHIP app
            fi
            echo
            break;
        fi

        # "All:      Flash"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/appsboot.mbn" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/appsboot.mbn"
                break;
            fi
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-boot.img"
                break;
            fi
            if [ ! -e "${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-sysfs.ubi" ];
            then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607/mdm9607-sysfs.ubi"
                break;
            fi
            cd ${jllRoot}/poky/build/tmp-glibc/deploy/images/mdm9607
            adb reboot-bootloader
            fastboot devices
            echo
            sleep 1
            echo
            fastboot flash aboot appsboot.mbn
            echo
            fastboot flash boot mdm9607-boot.img
            echo
            fastboot flash system mdm9607-sysfs.ubi
            echo
            fastboot reboot
            cd - >/dev/null 
            echo
            break;
        fi

        # "All:      Update and reBuild"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
            if [ ! -e "${jllRoot}/../.svn" ]; then
                echo -e "JLLim: Not found ${Fred}${jllRoot}/../.svn${AC}"
                break;
            fi
            cd ${jllRoot}/../
            if [ x"$(svn status)" != x ]; then
                echo -e "JLLim: Fount the changes as follows:"
                svn status
                echo
                read -p "JLLim: cleanup those changes if [y] or exit" -n 1 _my_choice_
                if [ x"${_my_choice_}" != x"y" ]; then
                    break;
                fi
                svn status | grep -e '^?' | xargs rm -rvf
                svn status | grep -e '^M' | xargs svn revert 
            fi
            echo "JLLim: Updating all to the latest version..."
            svn update
            if [ ! -e "${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh" ]; then
                echo -e \
                "JLLim: Not found ${Fred}${jllRoot}/poky/build/conf/set_bb_env_${jllProject}.sh${AC}"
                break;
            fi
            if [ 1 -eq 1 ]; then
                cd ${jllRoot}/poky
                source build/conf/set_bb_env_${jllProject}.sh
                buildclean
                build-9607-image
            else
                if [ ! -e "${jllRoot}/buildapp/build${jllProject}SHIP" ]; then
                    echo -e \
                    "JLLim: Not found ${Fred}${jllRoot}/buildapp/build${jllProject}SHIP${AC}"
                    break;
                fi
                cd ${jllRoot}/buildapp
                ./build${jllProject}SHIP app
            fi
            echo "JLLim: Okay"
            cd - >/dev/null
            echo
            break;
        fi

        # "Usage:    Help Information"
        if [ x"${GvResult}" = x"${GvMenuUtilsContent[GvResultID++]}" ]; then
            clear
            [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
            [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
            echo
cat >&1<<EOF

//build app
cd ${jllRoot}/poky
source build/conf/set_bb_env_${jllProject}.sh

bitbake uarttest -c cleanall
bitbake uarttest 

#Output:
    apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/uarttest
#Push:
    cd apps_proc/poky/build/tmp-glibc/work/armv7a-vfp-neon-oe-linux-gnueabi/uarttest/0.0-r0/image/usr/bin
    adb push uarttest /usr/bin/

#Package to FileSystem:
    bitbake machine-image OR  build-9607-image 

//更好的内核编译方法：
//可以在apps_proc/poky/build/tmp-glibc/work-shared/mdm9607/kernel-source修改代码
//验证正确后，需要手动把代码同步 到apps_proc/kernel目录
使用以下命令编译 
# bitbake linux-quic -c compile -f   // 编译kernel
# bitbake linux-quic -c deploy -f    // 更新镜像


EOF
            break 
        fi
 
    done
    [ x"${GvMenuUtilsContent}" != x ] && unset GvMenuUtilsContent
    [ x"${GvMenuUtilsContentCnt}" != x ] && unset GvMenuUtilsContentCnt
}
export -f Reachxm_L170H_on_mdm9607_by_jllim
