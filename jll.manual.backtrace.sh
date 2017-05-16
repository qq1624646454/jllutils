#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.backtrace.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-16 09:56:24
#   ModifiedTime: 2017-05-16 10:20:16

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF


${AC}${Fred}
backtrace:
    #00 pc 000423c4  /system/lib/libc.so (tgkill+12)
    #01 pc 0003ffd1  /system/lib/libc.so (pthread_kill+32)
    #02 pc 0001c75f  /system/lib/libc.so (raise+10)
    #03 pc 00019911  /system/lib/libc.so (__libc_android_abort+34)
    #04 pc 000174d0  /system/lib/libc.so (abort+4)
    #05 pc 003b7158  /system/lib/libffmpeg_avcodec.so
    #06 pc 001a9440  /system/lib/libffmpeg_avcodec.so
    #07 pc 004a5e80  /system/lib/libffmpeg_avcodec.so (avcodec_decode_video2+552)
    #08 pc 000aa6dc  /system/lib/libffmpeg_avformat.so
    #09 pc 000b1724  /system/lib/libffmpeg_avformat.so (avformat_find_stream_info+2740)
${Fyellow}
Call Flow:
    --->#09: avformat_find_stream_info
        --->#08: unknown function (As logically Analyzed, it should be try_decode_frame)
            --->#07: avcodec_decode_video2
                --->#06: unknown function
                    --->#05: unknown function
                        ...
${Fseablue}
    I think the below cases perhaps display none in backtrace:
    (1): static function, such as try_decode_frame
    (2): function pointer
    (3): not function prototype
${AC}

EOF

