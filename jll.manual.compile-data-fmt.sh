#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.compile-data-fmt.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-08 18:42:31
#   ModifiedTime: 2019-01-08 18:42:31

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

/*JLLim.S reach Revision tracking */
#define int_YEAR ((((__DATE__ [7] - '0') * 10  \\
                    + (__DATE__ [8] - '0')) * 10 \\
                    + (__DATE__ [9] - '0')) * 10 \\
                    + (__DATE__ [10] - '0'))

//__DATE__[0,1,2]={Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec}
//January
//February
//March
//April
//May
//June 
//July
//August
//September
//October
//November
//December
#define int_MONTH  ( __DATE__ [2] == 'c' ? 12 \\
                     : __DATE__ [2] == 'b' ? 2 \\
                     : __DATE__ [2] == 'r' ? (__DATE__ [0] == 'M' ? 3 : 4) \\
                     : __DATE__ [2] == 'y' ? 5 \\
                     : __DATE__ [2] == 'n' ? (__DATE__ [1] == 'a' ? 1 : 6) \\
                     : __DATE__ [2] == 'l' ? 7 \\
                     : __DATE__ [2] == 'g' ? 8 \\
                     : __DATE__ [2] == 'p' ? 9 \\
                     : __DATE__ [2] == 't' ? 10 \\
                     : __DATE__ [2] == 'v' ? 11 : 0)
#define int_DAY  ( (__DATE__ [4] == ' ' ? 0 : __DATE__ [4] - '0') * 10 + (__DATE__ [5] - '0') )

/*JLLim.E reach Revision tracking */


int main(int argc, char **argv)
{
    printf("%d-%02d-%02d\\r\\n", int_YEAR, int_MONTH, int_DAY);

    //0-1-2-3-4-5-6-7-8-9-10
    //J-a-n- - -8- -2-0-1-9
    printf(
        "%c-%c-%c-%c-%c-%c-%c-%c-%c-%c-%c\r\n",
         __DATE__[0],
         __DATE__[1],
         __DATE__[2],
         __DATE__[3],
         __DATE__[4],
         __DATE__[5],
         __DATE__[6],
         __DATE__[7],
         __DATE__[8],
         __DATE__[9],
         __DATE__[10]
    );
    return 0;
}





EOF

