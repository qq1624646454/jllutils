#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

JLLCONF_unDefine_DRM_LOGCAT is not defined.

#ifdef JLLCONF_unDefine_DRM_LOGCAT
        ALOGV("Key: %s | Value: %s", keyString.string(), valueString.string());
#else
        ALOGV(
            "Key: %s | Value: %s is added to drmInfoReq", keyString.string(), valueString.string()
        );
#endif




============================================================
1. Varargs Macros In Android Native
   Only get property value one times for every source file
============================================================

---------------------------------
 YourAndroidNative.cpp
---------------------------------
/*** JLL.S2016mmddxx: Support for Jll Android Logcat ***/
#include <android/log.h>
#include <cutils/properties.h>
#ifdef __cplusplus
extern "C" {
#endif
static int i4JllAlogPropVal = property_get_int32("persist.sys.jll_alog", 0);
#define jll_alog(bit, fmt, ...)                                                       \\
            if (i4JllAlogPropVal && (i4JllAlogPropVal & (0x1 << (bit))))              \\
                __android_log_print(ANDROID_LOG_INFO, "JLL", "%s@%d,%s | " fmt,       \\
                                    __FUNCTION__, __LINE__, __FILE__, ##__VA_ARGS__);
#ifdef __cplusplus
}
#endif
/*** JLL.E2016mmddxx: Support for Jll Android Logcat ***/


---------------------------------------------------------------------------------------
Android.mk
  Note: 1.Please append the below code
  Note: 2.If the above YourAndroidNative.cpp is compiled to static library, You should
          append the below code in all Android.mk which contains this static library. 
---------------------------------------------------------------------------------------
#===== JLL.S2016mmddxx: Support for Jll Android Logcat =====#
\$(info JLL: Android.mk located in CurrentPATH=\$(LOCAL_PATH))
PhilipsTV_AndrLib=\$(TOP)/out/target/product/\$(TARGET_PRODUCT)/system/lib/
HAVE_TEST_JLL_REQUIRED_FILES := \$(shell test -f \$(PhilipsTV_AndrLib)/libcutils.so && echo cutils)
ifeq (\$(HAVE_TEST_JLL_REQUIRED_FILES),cutils)
    \$(info JLL: Found \$(PhilipsTV_AndrLib)/libcutils.so)
    HAVE_TEST_JLL_REQUIRED_FILES := \$(shell test -f \$(PhilipsTV_AndrLib)/liblog.so && echo log)
    ifeq (\$(HAVE_TEST_JLL_REQUIRED_FILES),log)
        \$(info JLL: Found \$(PhilipsTV_AndrLib)/liblog.so)
    else
        \$(info JLL: Not Found \$(PhilipsTV_AndrLib)/liblog.so)
    endif
else
    \$(info JLL: Not Found \$(PhilipsTV_AndrLib)/libcutils.so)
endif
LOCAL_C_INCLUDES += \$(TOP)/system/core/include
LOCAL_SHARED_LIBRARIES += libcutils # Support for property_get_int32(...)
LOCAL_SHARED_LIBRARIES += liblog    # Support for __android_log_print(...)
#===== JLL.E2016mmddxx: Support for Jll Android Logcat =====#




==================================================-=
2. Varargs Macros In Android Native
   Get property value for every call jll_alog(...)
====================================================

---------------------------------
 YourAndroidNative.cpp
---------------------------------
/*** JLL.S2016mmddxx: Support for Jll Android Logcat ***/
#include <android/log.h>
#include <cutils/properties.h>
#ifdef __cplusplus
extern "C" {
#endif
#define jll_alog(bit, fmt, ...)                                                           \\
            do {                                                                          \\
                int i4JllAlogPropVal = property_get_int32("persist.sys.jll_alog", 0);     \\
                if (i4JllAlogPropVal && (i4JllAlogPropVal & (0x1 << (bit))))              \\
                    __android_log_print(ANDROID_LOG_INFO, "JLL", "%s@%d,%s | " fmt,       \\
                                        __FUNCTION__, __LINE__, __FILE__, ##__VA_ARGS__); \\
            } while (0)
#ifdef __cplusplus
}
#endif
/*** JLL.E2016mmddxx: Support for Jll Android Logcat ***/


---------------------------------------------------------------------------------------
Android.mk
  Note: 1.Please append the below code
  Note: 2.If the above YourAndroidNative.cpp is compiled to static library, You should
          append the below code in all Android.mk which contains this static library. 
---------------------------------------------------------------------------------------
#===== JLL.S2016mmddxx: Support for Jll Android Logcat =====#
\$(info JLL: Android.mk located in CurrentPATH=\$(LOCAL_PATH))
PhilipsTV_AndrLib=\$(TOP)/out/target/product/\$(TARGET_PRODUCT)/system/lib/
HAVE_TEST_JLL_REQUIRED_FILES := \$(shell test -f \$(PhilipsTV_AndrLib)/libcutils.so && echo cutils)
ifeq (\$(HAVE_TEST_JLL_REQUIRED_FILES),cutils)
    \$(info JLL: Found \$(PhilipsTV_AndrLib)/libcutils.so)
    HAVE_TEST_JLL_REQUIRED_FILES := \$(shell test -f \$(PhilipsTV_AndrLib)/liblog.so && echo log)
    ifeq (\$(HAVE_TEST_JLL_REQUIRED_FILES),log)
        \$(info JLL: Found \$(PhilipsTV_AndrLib)/liblog.so)
    else
        \$(info JLL: Not Found \$(PhilipsTV_AndrLib)/liblog.so)
    endif
else
    \$(info JLL: Not Found \$(PhilipsTV_AndrLib)/libcutils.so)
endif
LOCAL_C_INCLUDES += \$(TOP)/system/core/include
LOCAL_SHARED_LIBRARIES += libcutils # Support for property_get_int32(...)
LOCAL_SHARED_LIBRARIES += liblog    # Support for __android_log_print(...)
#===== JLL.E2016mmddxx: Support for Jll Android Logcat =====#





==================================
3. Print the frequently used Code 
==================================
>>> String8::string()
  String8  plugInId; 
  ALOGE("JLL: %s,%d@%s | plugInId=%s", __FUNCTION__, __LINE__, __FILE__, plugInId.string());





==================================
4. Show the address the object in
   Android SP 
==================================
For Example:
    sp<DecryptHandle> mDecryptHandle;
    ALOGE("DecryptHandle=%p", mDecryptHandle.get());






==================================
5. Dump UUID 
==================================
/*** JLL.S2016mmddxx: Support for Dump UUID by Jll Android Logcat ***/
#include <android/log.h>
#include <string.h>
#include <cutils/properties.h>
#include <utils/CallStack.h>

#ifdef __cplusplus
extern "C" {
#endif
static int i4JllAlogPropVal = property_get_int32("persist.sys.jll_alog", 0);
#define jll_alog(bit, fmt, ...)                                                           \\
                if (i4JllAlogPropVal && (i4JllAlogPropVal & (0x1 << (bit))))              \\
                    __android_log_print(ANDROID_LOG_INFO, "JLL", "%s@%d,%s | " fmt,       \\
                                        __FUNCTION__, __LINE__, __FILE__, ##__VA_ARGS__);
int memcmp(const void *buf1, const void *buf2, unsigned int count);
#ifndef UUID_WIDEVINE
#define UUID_WIDEVINE  "\xed\xef\x8b\xa9\x79\xd6\x4a\xce\xa3\xc8\x27\xdc\xd5\x1d\x21\xed"
#endif
#ifndef UUID_PLAYREADY
#define UUID_PLAYREADY "\x9a\x04\xf0\x79\x98\x40\x42\x86\xab\x92\xe6\x5b\xe0\x88\x5f\x95"
#endif
#ifndef UUID_MARLIN
#define UUID_MARLIN    "\x5E\x62\x9A\xF5\x38\xDA\x40\x63\x89\x77\x97\xFF\xBD\x99\x02\xD4"
#endif

#define jll_dump_uuid(uuid)   \\
            jll_alog(0, "UUID= 0x%x 0x%x 0x%x 0x%x - 0x%x 0x%x 0x%x 0x%x\r\n"  \\
                        "      0x%x 0x%x 0x%x 0x%x - 0x%x 0x%x 0x%x 0x%x\r\n", \\
                     uuid[0], uuid[1], uuid[2],  uuid[3],  uuid[4],  uuid[5],  uuid[6],  uuid[7],   \\
                     uuid[8], uuid[9], uuid[10], uuid[11], uuid[12], uuid[13], uuid[14], uuid[15]); \\
            jll_alog(0, "UUID is %s", !memcmp(uuid, UUID_WIDEVINE, 16)?"UUID_WIDEVINE":    \\
                                      !memcmp(uuid, UUID_PLAYREADY, 16)?"UUID_PLAYREADY":  \\
                                      !memcmp(uuid, UUID_MARLIN, 16)?"UUID_MARLIN":"Unknown_UUID");
#ifdef __cplusplus
}
#endif
/*** JLL.E2016mmddxx: Support for Dump UUID by Jll Android Logcat ***/




/*JLLim.S reach Revision tracking */
#define LOG_TAG "lora_app"
#include "cutils/log.h"

#define int_YEAR ((((__DATE__ [7] - '0') * 10  \\
                    + (__DATE__ [8] - '0')) * 10 \\
                    + (__DATE__ [9] - '0')) * 10 \\
                    + (__DATE__ [10] - '0'))
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

#ifdef MSG 
#    undef  MSG
#    define MSG(fmt, ...) ((void)ALOG(LOG_INFO, LOG_TAG, "R%d%02d%02d." fmt, \\
                          int_YEAR, int_MONTH, int_DAY, ##__VA_ARGS__))
#endif


MSG("hello"); //I/lora_app(13975): R20190108.ERROR: hello

/*JLLim.E reach Revision tracking */



EOF

