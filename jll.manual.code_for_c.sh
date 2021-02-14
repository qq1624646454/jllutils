#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.code_for_c.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-09 11:22:20
#   ModifiedTime: 2019-12-16 12:37:16

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

//#define xxx 1
//#define xxx 0
#define xxx 1

int _xxx_main(int argc, char *argv[])
{

#if !defined(xxx) || (xxx != 1)
    printf("xxx\\n");
#else
    printf("xxx=1\\n");
#endif
    return 0;
}


int main(int argc, char **argv)
{
    int x,y,z;

    x = 10;
    y = 9;
    z = 8;  
    x > y ? printf("1") : y > z ? printf("2") : printf("3");
    printf("\\r\\n");
    (x > y) ? printf("1") : (y > z) ? printf("2") : printf("3");
    printf("\\r\\n");
    (x > y) ? printf("1") : ((y > z) ? printf("2") : printf("3"));
    printf("\\r\\n");

    _xxx_main(argc, argv);

    return 0;
}

gcc test.c -o test
./test
1
1
1

EOF

