#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

more >&1 << EOF

The Information will be stored in "/dev/socket/property_service", and it
is virtual device file rather than exist in flash/NVM storage device.


|======================
| Expose Interfaces:
|     #include <cutils/properties.h> 

#define PROPERTY_KEY_MAX    PROP_NAME_MAX    //32
#define PROPERTY_VALUE_MAX  PROP_VALUE_MAX   //92

int property_get(const char *key, char *value, const char *default_value);
int property_set(const char *key, const char *value);



For Example - persist storage information in flash:
    property_get("persist.sys.tpapi_infra.log", arEnableLogs, "0");
    property_set("persist.sys.tpapi_infra.log", "0"); 

For Example - storage information in RAM:
    property_set("sys.xxx", "0");



For Example - Got int value 
    /*** JLL.S2016042400: Solution to can't get IP from DHCP Server ***/
    i4PropValue=property_get_int32("persist.jll.dhcp.timeout", 30);
    snprintf("jll-dhcp", 8, "Got the dhcp request timeout is %d", i4PropValue);
    /*** JLL.E2016042400: Solution to can't get IP from DHCP Server ***/



 236     long   lMask;
 237     char   arEnableLogs[PROPERTY_VALUE_MAX];
 241
 242     memset(arEnableLogs, '\0', PROPERTY_VALUE_MAX);
 243     /* Logcat is on/off for TPAPI_INFRA_PRINT according to property */
 244     property_get("persist.sys.tpapi_infra.log", arEnableLogs, "0");
 245     lMask = strtol(arEnableLogs,NULL,16);
 246     if (strlen(arEnableLogs) < 16) {
 247         if (lMask & TPAPI_INFRA_LOG_MASK) {
 248             gEnableInfraLog |= TPAPI_INFRA_LOG_MASK;
 249         } else {
 250             gEnableInfraLog &= ~(TPAPI_INFRA_LOG_MASK);
 251         }
 252     }



|======================
| Detail Review 
|======================


Real Path File:
    system/core/include/cutils/properties.h


 /* property_get: returns the length of the value which will never be
 ** greater than PROPERTY_VALUE_MAX - 1 and will always be zero terminated.
 ** (the length does not include the terminating zero).
 **
 ** If the property read fails or returns an empty value, the default
 ** value is used (if nonnull).
 */
 int property_get(const char *key, char *value, const char *default_value);


 /* property_set: returns 0 on success, < 0 on failure
  */
 int property_set(const char *key, const char *value);


_____________________________________
system/core/libcutils/properties.c
_____________________________________
112 int property_set(const char *key, const char *value)
113 {
114     return __system_property_set(key, value);
115 }
116
117 int property_get(const char *key, char *value, const char *default_value)
118 {
119     int len;
120
121     len = __system_property_get(key, value);
122     if(len > 0) {
123         return len;
124     }
125     if(default_value) {
126         len = strlen(default_value);
127         if (len >= PROPERTY_VALUE_MAX) {
128             len = PROPERTY_VALUE_MAX - 1;
129         }
130         memcpy(value, default_value, len);
131         value[len] = '\0';
132     }
133     return len;
134 }


_________________________________________
bionic/libc/bionic/system_properties.cpp
_________________________________________
621 int __system_property_get(const char *name, char *value)
622 {
623     const prop_info *pi = __system_property_find(name);
624
625     if (pi != 0) {
626         return __system_property_read(pi, 0, value);
627     } else {
628         value[0] = 0;
629         return 0;
630     }
631 }

/* jll:
 *      send_prop_msg(&msg) -  Write "msg" to /dev/socket/property_service by unix socket 
 *
 */
633 int __system_property_set(const char *key, const char *value)
634 {
635     if (key == 0) return -1;
636     if (value == 0) value = "";
637     if (strlen(key) >= PROP_NAME_MAX) return -1;
638     if (strlen(value) >= PROP_VALUE_MAX) return -1;
639
640     prop_msg msg;
641     memset(&msg, 0, sizeof msg);
642     msg.cmd = PROP_MSG_SETPROP;
643     strlcpy(msg.name, key, sizeof msg.name);
644     strlcpy(msg.value, value, sizeof msg.value);
645
646     const int err = send_prop_msg(&msg);
647     if (err < 0) {
648         return err;
649     }
650
651     return 0;
652 }



====================================================================================================
Java: @ frameworks/base/core/java/android/os/SystemProperties.java

android.os.SystemProperties可以操作Android系统属性

public class SystemProperties {
    public static final int PROP_NAME_MAX = 31;
    public static final int PROP_VALUE_MAX = 91;
    public static String get(String key) {...}
    public static String get(String key, String def) {...}
    public static int getInt(String key, int def) {...}
    public static long getLong(String key, long def) {...}
    //Values 'n', 'no', '0', 'false' or 'off' are considered false
    //Values 'y', 'yes', '1', 'true' or 'on' are considered true.
    public static boolean getBoolean(String key, boolean def) {...}
    public static void set(String key, String val) {...}
    ...
}


For Example:

  persist.jll.xxx : persist storage whatever power is on/off
  other is temporant property, namely the property item disappear after power is off then on.

    /*== JLL.Start: Debug if persist.jll.TAG.RANGE is valid ===*/
    static {
        if (0 == android.os.SystemProperties.getInt("persist.jll." + TAG + ".0t2",0)) {
            //android.os.SystemProperties.set("persist.jll." + TAG +"." + "0t2", "1");
        }
    }
    /*== JLL.End:   Debug if persist.jll.TAG.RANGE is valid ===*/

    /*== JLL.Start: Debug if persist.jll.TAG.RANGE is valid ===*/
        int i4JllSysPropVal = android.os.SystemProperties.getInt("persist.jll." + TAG + ".0t2",0);
        switch (i4JllSysPropVal) {
        case 2:
            break;
        default:
            break;
        }
    /*== JLL.End:   Debug if persist.jll.TAG.RANGE is valid ===*/

    /*== JLL.Start: Debug if persist.jll.TAG.RANGE is valid ===*/
        if (2 == (int)android.os.SystemProperties.getInt("persist.jll." + TAG + ".0t2",0)) {
            (void)0;
        }
    /*== JLL.End:   Debug if persist.jll.TAG.RANGE is valid ===*/

    /*== JLL.Start: Debug if persist.jll.TAG.RANGE is valid ===*/
        int i4JllSysPropVal = android.os.SystemProperties.getInt("persist.jll." + TAG + ".0t2",0);
        if (i4JllSysPropVal == 2) {
            (void)0;
        }
    /*== JLL.End:   Debug if persist.jll.TAG.RANGE is valid ===*/



        import android.os.SystemProperties;
        boolean isSet=SystemProperties.get("tv_log_keyevent", "false").equals("true");
        int intValue=SystemProperties.getInt("ro.mtk.4k2k.photo",0);
        SystemProperties.set("persist.sys.deviceprovisioned", "true");
        String prodId = SystemProperties.get("ro.tpvision.product.id");
        SystemProperties.set("persist.sys.power_currentstate", "DDR_STANDBY");

 
EOF



