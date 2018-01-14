#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.debug_kernel.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-11-21 19:42:13
#   ModifiedTime: 2018-01-11 13:42:51

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF


#ifdef pr_debug
#undef pr_debug
#endif
#define pr_debug(fmt, ...) \\
            printk(KERN_INFO "JLLim.D.%d-%s| " fmt, __LINE__, __FUNCTION__, ##__VA_ARGS__)



#ifdef pr_debug
#undef pr_debug
#define pr_debug(fmt, ...) \\
            printk(KERN_INFO "JLLim.D.%d-%s| " fmt, __LINE__, __FUNCTION__, ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...)
#endif





=================================================================================================
/*JLLim.S 20171124 add for user selection to debugging */
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/syscalls.h>
#include <linux/fcntl.h>
#include <asm/uaccess.h>

/**
 * Get Char Value from /etc/JLLim_Kern_Prop/keyFile_limit256
 *
 * User is in charge of setting char value to /etc/JLLim_Kern_Prop/keyFile_limit256 in User Space;
 * Kernel is in charge of getting char value from /etc/JLLim_Kern_Prop from Kernel Space;
 *
 * Called Runtime Environment should in Kernel Space with interrupt enable 
 * For Example:
 *      switch (JLLim_Kern_getProp("usb_mounted_delay_ms")) {
 *      case '0':
 *          printk(KERN_INFO "Not delay to mount usb device\n");
 *          break;
 *      case '1':
 *          printk(KERN_INFO "Delay 100ms then mount usb device\n");
 *          break;
 *      default:
 *          printk(KERN_INFO "Default by not delay to mount usb device\n");
 *          break;
 *      }
 */
static char JLLim_Kern_getProp(char *keyFile_limit256)
{
    int  fd;
    char filename[256];
    char buf = 0;
    int  len = 0;

    if (NULL == keyFile_limit256)
        return 0;

    len = snprintf(filename, 255, "/etc/JLLim_Kern_Prop/%s", keyFile_limit256);
    filename[len] = 0;

    mm_segment_t old_fs = get_fs();
    set_fs(KERNEL_DS);

    fd = sys_open(filename, O_RDONLY, 0);
    if (fd >= 0) {
        printk(KERN_INFO);
        sys_read(fd, &buf, 1);
        printk(KERN_INFO "JLLim_Kern_getProp(%s)=%c\n", filename, buf);
        sys_close(fd);
    } else {
        printk(KERN_INFO "Failed to JLLim_Kern_getProp(%s)\n", filename);
    }
    set_fs(old_fs);

    return buf;
}
/*JLLim.E 20171124 add for user selection to debugging */


EOF

