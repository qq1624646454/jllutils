#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

=========================
 import android.util.Log;
=========================
Java: @frameworks/base/core/java/android/util/Log.java

    Log.v(String tag, String msg)
    Log.v(String tag, String msg, Throwable tr)
    Log.d(String tag, String msg)
    Log.d(String tag, String msg, Throwable tr)
    Log.i(String tag, String msg)
    Log.i(String tag, String msg, Throwable tr)
    Log.w(String tag, String msg)
    Log.w(String tag, String msg, Throwable tr)
    Log.e(String tag, String msg)
    Log.e(String tag, String msg, Throwable tr)

  不是所有都会打印出log，系统默认INFO,WARN,ERROR,ASSERT会打印.  
  The default level of any tag is set to INFO
  This means that any level above and including 
  INFO will be logged.Change the default level by:
  'setprop log.tag.<YOUR_LOG_TAG> <LEVEL>'

  一般的，在Java程序中用Log的方法打印Log之前，应先用
  isLoggable()判断一下，该级别是否能被记录

    android.util.Log.println(int priority, String tag, String msg)
                 Log.VERBOSE = 2,
                 Log.DEBUG = 3
                 Log.INFO = 4
                 Log.WARN = 5
                 Log.ERROR = 6
                 Log.ASSERT = 7

Java: @ org/droidtv/nettvbrowser
    
    # debug: enable or disable log for Utility.SMTVLOGD
    # verbose: enable or disable log for Utility.SMTVLOGV or Utility.SMTVLOGW 
    Utility.setLoglevel(boolean debug,boolean verbose)

    Utility.SMTVLOGD(String tag, String msg) will be logged
    Utility.SMTVLOGE(String tag, String msg)
    Utility.SMTVLOGI(String tag, String msg)
    ---> Log.i(tag, msg);
    Utility.SMTVLOGV(String tag, String msg) will be logged
    ---> Log.v(tag, msg);
    Utility.SMTVLOGW(String tag, String msg)

Java: Slog.d(...) use Log.println(...) and so on  




#include <cutils/log.h>
    __android_log_write(ANDROID_LOG_INFO, "TvPlayer_JNI", "JNI_OnLoad");



PathFile: system/core/include/log/log.h
=========================================

"LOG_TAG" - Specify the local tag used for the following simplified logging macros.

|==============================================
|  ALOGV - Enable should define LOG_NDEBUG 0
|==============================================
#ifndef ALOGV
#    define  __ALOGV(...) ((void)ALOG(LOG_VERBOSE, LOG_TAG, __VA_ARGS__))
#    if LOG_NDEBUG
#        define ALOGV(...) { if (0) { __ALOGV(__VA_ARGS__); } } while (0)
#    else
#        define ALOGV(...) __ALOGV(__VA_ARGS__)
#    endif
#endif

"LOG_NDEBUG" - Turn on ALOGV(...) to output the logcat if LOG_NDEBUG is defined to 0 


|==============================================
|  ALOGD - It can always output logcat 
|==============================================
#ifndef ALOGD
#    define ALOGD(...) ((void)ALOG(LOG_DEBUG, LOG_TAG, __VA_ARGS__))
#endif


|==============================================
|  ALOGI - It can always output logcat 
|==============================================
#ifndef ALOGI
#    define ALOGI(...) ((void)ALOG(LOG_INFO, LOG_TAG, __VA_ARGS__))
#endif



|==============================================
|  ALOGW - It can always output logcat 
|==============================================
#ifndef ALOGW
#    define ALOGW(...) ((void)ALOG(LOG_WARN, LOG_TAG, __VA_ARGS__))
#endif



|==============================================
|  ALOGE - It can always output logcat 
|==============================================
#ifndef ALOGE
#    define ALOGE(...) ((void)ALOG(LOG_ERROR, LOG_TAG, __VA_ARGS__))
#endif




EOF

