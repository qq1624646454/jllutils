#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 <<EOF

C/C++ (Sorry that backtrace(...) isn't supported in Android) 
================================================================
#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

void jll_backtrace(int i4Depth32, char *pcFmt32, ...)
{
    int     i4Idx;
    int     i4Size;
    char  **ppcData;
    void   *pvData[32];
    char    acPrefix[32];
    va_list pvArgs;

    if (pcFmt32 == NULL) {
        return;
    }
    va_start( pvArgs, pcFmt32 );
    i4Size = vsnprintf( acPrefix, sizeof(acPrefix) - 1, pcFmt32, pvArgs );
    if (i4Size < 0) {
        va_end( pvArgs );
        return;
    }
    acPrefix[i4Size] = 0;
    va_end( pvArgs );

    i4Size = backtrace( pvData, sizeof(pvData) / sizeof(pvData[0]) );
    if (i4Size > 0) {
        if (i4Depth32 > 32) {
            i4Depth32 = 32; 
        }
        i4Depth32 = (i4Depth32 > i4Size) ? i4Size : i4Depth32;
        ppcData = backtrace_symbols( pvData, i4Size );
        for (i4Idx = 0; i4Idx < i4Size; i4Idx++ ) {
            if (acPrefix[0] != 0) {
                printf("%s | %s\n", acPrefix, ppcData[i4Idx]);
            } else {
                printf("%s\n", ppcData[i4Idx]);
            }
        }
        free(ppcData);
    }
}

void JllDumpTest(void)
{
    jll_backtrace(32, "jll@%d:%s", __LINE__, __FUNCTION__);
}

int main(int argc, char **argv)
{
    JllDumpTest();
    return 0;
}

gcc jlldebug.c -o jlldebug -rdynamic -g
addr2line -a 0x400982 -e jlldebug -f -C



EOF

