#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

###############################
## Java
## note: key.length() < 31
###############################
android.os.SystemProperties.get (String key, String def)
android.os.SystemProperties.getInt (String key, int def)
android.os.SystemProperties.set(String key, String val)

android.os.Debug.getCallers(final int depth)
android.os.Debug.getCallers(final int start, int depth)
android.os.Debug.getCallers(final int depth, String linePrefix)

Example For:
    /*** JLL.S2016043000: CallStack ***/
    int i4JllCalltraceConf=android.os.SystemProperties.getInt ("persist.sys.jll_callstack", 0);
    Log.i(TAG+".jll", "getprop persist.sys.jll_callstack : " + i4JllCalltraceConf);
    if (i4JllCalltraceConf == 1) {
        Log.i(TAG+".jll", android.os.Debug.getCallers(10, "jll# "));
    }
    /*** JLL.E2016043000: CallStack ***/



---------------------------------------------------------------------------

###############################
## C++/C 
## note: key.length() < 31
###############################

/*** JLL.S2016042800: Support for jll_callstack(0) - setprop persist.sys.jll_callstack ***/
#include <string.h>
#include <cutils/properties.h>
#include <utils/CallStack.h>

#ifdef __cplusplus  
extern "C" {  
#endif
static int i4JllCallstackPropVal = property_get_int32("persist.sys.jll_callstack", 0);
#define jll_callstack(bit) \\
            if (i4JllCallstackPropVal && (i4JllCallstackPropVal & (0x1 << (bit)))) { \\
                android::CallStack tCS;                                              \\
                tCS.update();                                                        \\
                tCS.log("jll_callstack");                                            \\
                __android_log_print(ANDROID_LOG_INFO, "JLL",                         \\
                    ">>>>> Above callstack occurred AT %s@%d,%s",                    \\
                    __FUNCTION__, __LINE__, __FILE__);                               \\
            }
#ifdef __cplusplus  
}  
#endif
/*** JLL.E2016042800: Support for jll_callstack(0) - setprop persist.sys.jll_callstack ***/

---------------------------
Android.mk:

### JLL.S2016042800: Support for jll_callstack(0) - setprop persist.sys.jll_callstack
LOCAL_C_INCLUDES +=\$(LOCAL_PATH)/../../../../../system/core/include
LOCAL_SHARED_LIBRARIES += libutils  # Support for android::CallStack
LOCAL_SHARED_LIBRARIES += libcutils # Support for property_get(...)
### JLL.E2016042800: Support for jll_callstack(0) - setprop persist.sys.jll_callstack










---------------------------------------------------------------------------



Reference to system/core/include/utils/CallStack.h
#include <utils/CallStack.h>

________________
For Example:
________________


#include <log/log.h>
#include <utils/CallStack.h>
#define LOG_TAG  "FunctionCallStack"

void  XxxFunction(void)
{
    ALOGD("Func=%s", __FUNCTION__);
    android::CallStackk stack;
    stack.update(1,100);
    stack.dump("test-callstack-by-jll");
}

xxx.mk:
  LOCAL_SHARED_LIBRARIES += libutils

mmm Xxx


EOF

