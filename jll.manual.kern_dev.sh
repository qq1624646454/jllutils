#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.kern_dev.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-04-04 11:10:37
#   ModifiedTime: 2019-04-04 11:11:32

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

### Check file/folder exist or not
    @kernel-function populate_rootfs 
    if (sys_access((const char __user *) "/dev", 0) != 0) {
        pr_info("JLLim[%s:%d] /dev not existed\\n", __FUNCTION__, __LINE__);
    } else {
        pr_info("JLLim[%s:%d] /dev existed\\n", __FUNCTION__, __LINE__);
        if (sys_access((const char __user *) "/dev/console", 0) != 0) {
            pr_info("JLLim[%s:%d] /dev/console not existed\\n", __FUNCTION__, __LINE__);
        } else {
            pr_info("JLLim[%s:%d] /dev/console existed\\n", __FUNCTION__, __LINE__);
        }
    }
    err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
    printk(KERN_INFO "JLLim[%s:%d] %s to unpack_to_rootfs(0x%p,%ul)\\n", __FUNCTION__, __LINE__,
        err ? "Failed" : "Succeed", __initramfs_start, __initramfs_size
    );
    if (sys_access((const char __user *) "/dev", 0) != 0) {
        pr_info("JLLim[%s:%d] /dev not existed\\n", __FUNCTION__, __LINE__);
    } else {
        pr_info("JLLim[%s:%d] /dev existed\\n", __FUNCTION__, __LINE__);
        if (sys_access((const char __user *) "/dev/console", 0) != 0) {
            pr_info("JLLim[%s:%d] /dev/console not existed\\n", __FUNCTION__, __LINE__);
        } else {
            pr_info("JLLim[%s:%d] /dev/console existed\\n", __FUNCTION__, __LINE__);
        }
    }


EOF


