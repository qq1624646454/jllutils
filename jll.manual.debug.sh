#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.debug.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-15 09:14:38
#   ModifiedTime: 2019-01-16 17:10:33

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


--------------------------------------------------
 @kernel/msm-3.18/drivers/video/fbdev/s3c2410fb.c
--------------------------------------------------
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

/* Debugging stuff */
#ifdef CONFIG_FB_S3C2410_DEBUG
static int debug    = 1; 
#else
static int debug;
#endif

#define dprintk(msg...) \
do { \
    if (debug) \
        pr_debug(msg); \
} while (0)
--------------------------------------------------




--------------------------------------------------
 Format String With Function Line to locate code position
--------------------------------------------------
#ifndef JLLimLOGE
#define JLLimLOGE(fmt, ...) printf("E %-*s %05u " fmt, 24, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#ifndef JLLimLOGI
//#define JLLimLOGI(fmt, args...)  printf("I %s,%d " fmt, __FUNCTION__, __LINE__, args)
#define JLLimLOGI(fmt, ...) printf("I %-24.24s %05u " fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif



EOF

