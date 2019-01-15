#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.gcc.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-07-26 10:22:46
#   ModifiedTime: 2018-07-26 10:33:24

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Bgreen}${Fblack} cd ./EnvForRD/GCC/LinuxOS/gcc-arm-none-eabi-7-2017-q4-major           ${AC}
${Bgreen}${Fblack} find . -type f -a -name libgcc* | xargs nm -SA | grep -i __aeabi_dadd ${AC}
${Bgreen}${Fblack}                                                                       ${AC}
./lib/gcc/arm-none-eabi/7.2.1/libgcc.a:_arm_addsubdf3.o:0000000c 00000310 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/hard/libgcc.a:_arm_addsubdf3.o:0000000c 00000310 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5/softfp/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5/hard/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/softfp/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/softfp/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/softfp/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/hard/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/hard/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.main/fpv5-sp/hard/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/libgcc.a:_arm_addsubdf3.o:0000000c 00000310 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv5/softfp/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv5/hard/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/softfp/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/softfp/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/softfp/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/hard/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/hard/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7e-m/fpv4-sp/hard/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-m/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-m/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-m/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-ar/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-ar/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-ar/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-ar/fpv3/softfp/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v7-ar/fpv3/hard/libgcc.a:_arm_addsubdf3.o:0000000d 00000276 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_arm_addsubdf3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_floatdisf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_floatdidf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_floatundisf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:_floatundidf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v6-m/libgcc.a:adddf3.o:00000001 00000638 T ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_arm_addsubdf3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_muldc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_divdc3.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_floatdisf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_floatdidf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_floatundisf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:_floatundidf.o:         U ${Fred}__aeabi_dadd${AC}
./lib/gcc/arm-none-eabi/7.2.1/thumb/v8-m.base/libgcc.a:adddf3.o:00000001 00000680 T ${Fred}__aeabi_dadd${AC}




${Bgreen}${Fblack} cd ./EnvForRD/GCC/LinuxOS/gcc-arm-none-eabi-7-2017-q4-major  ${AC}
${Bgreen}${Fblack} ./bin/arm-none-eabi-gcc -print-multi-lib                     ${AC}
${Bgreen}${Fblack}                                                              ${AC}
.;
thumb;@mthumb
hard;@mfloat-abi=hard
thumb/v6-m;@mthumb@march=armv6s-m
thumb/v7-m;@mthumb@march=armv7-m
thumb/v7e-m;@mthumb@march=armv7e-m
thumb/v7-ar;@mthumb@march=armv7
thumb/v8-m.base;@mthumb@march=armv8-m.base
thumb/v8-m.main;@mthumb@march=armv8-m.main
thumb/v7e-m/fpv4-sp/softfp;@mthumb@march=armv7e-m@mfpu=fpv4-sp-d16@mfloat-abi=softfp
thumb/v7e-m/fpv4-sp/hard;@mthumb@march=armv7e-m@mfpu=fpv4-sp-d16@mfloat-abi=hard
thumb/v7e-m/fpv5/softfp;@mthumb@march=armv7e-m@mfpu=fpv5-d16@mfloat-abi=softfp
thumb/v7e-m/fpv5/hard;@mthumb@march=armv7e-m@mfpu=fpv5-d16@mfloat-abi=hard
thumb/v7-ar/fpv3/softfp;@mthumb@march=armv7@mfpu=vfpv3-d16@mfloat-abi=softfp
thumb/v7-ar/fpv3/hard;@mthumb@march=armv7@mfpu=vfpv3-d16@mfloat-abi=hard
thumb/v8-m.main/fpv5-sp/softfp;@mthumb@march=armv8-m.main@mfpu=fpv5-sp-d16@mfloat-abi=softfp
thumb/v8-m.main/fpv5-sp/hard;@mthumb@march=armv8-m.main@mfpu=fpv5-sp-d16@mfloat-abi=hard
thumb/v8-m.main/fpv5/softfp;@mthumb@march=armv8-m.main@mfpu=fpv5-d16@mfloat-abi=softfp
thumb/v8-m.main/fpv5/hard;@mthumb@march=armv8-m.main@mfpu=fpv5-d16@mfloat-abi=hard


EOF

