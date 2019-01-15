#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.dumpdata.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-29 13:54:53
#   ModifiedTime: 2018-12-29 13:57:09

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

#define MSG  ALOGI

void JLLim_DumpData(void *data, int len)
{
    int i;
    int j;
    uint8_t *payload;
#define PREFIX_FORMAT  "        " 
    payload = data;
    i = 0;
    if (len > 7) {
        for (; i+8<=len; i+=8) {
            MSG(PREFIX_FORMAT "%02X %02X %02X %02X %02X %02X %02X %02X -- %c%c%c%c%c%c%c%c\r\n",
                payload[i],
                payload[i+1],
                payload[i+2],
                payload[i+3],
                payload[i+4],
                payload[i+5],
                payload[i+6],
                payload[i+7],
                isprint(payload[i]) ? payload[i] : '.', 
                isprint(payload[i+1]) ? payload[i+1] : '.', 
                isprint(payload[i+2]) ? payload[i+2] : '.', 
                isprint(payload[i+3]) ? payload[i+3] : '.', 
                isprint(payload[i+4]) ? payload[i+4] : '.',
                isprint(payload[i+5]) ? payload[i+5] : '.',
                isprint(payload[i+6]) ? payload[i+6] : '.',
                isprint(payload[i+7]) ? payload[i+7] : '.' 
            );
        }
    }   
    switch (len - i) {
    case 1:
        MSG(PREFIX_FORMAT "%02X                      -- %c\n",
            payload[i],
            isprint(payload[i]) ? payload[i] : '.' 
        );
        break;
    case 2:
        MSG(PREFIX_FORMAT "%02X %02X                   -- %c%c\n",
            payload[i],
            payload[i+1],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.'
        );
        break;
    case 3:
        MSG(PREFIX_FORMAT "%02X %02X %02X                -- %c%c%c\n",
            payload[i],
            payload[i+1],
            payload[i+2],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.',
            isprint(payload[i+2]) ? payload[i+2] : '.'
        );
        break;
    case 4:
        MSG(PREFIX_FORMAT "%02X %02X %02X %02X             -- %c%c%c%c\n",
            payload[i],
            payload[i+1],
            payload[i+2],
            payload[i+3],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.',
            isprint(payload[i+2]) ? payload[i+2] : '.',
            isprint(payload[i+3]) ? payload[i+3] : '.'
        );
        break;
    case 5:
        MSG(PREFIX_FORMAT "%02X %02X %02X %02X %02X          -- %c%c%c%c%c\n",
            payload[i],
            payload[i+1],
            payload[i+2],
            payload[i+3],
            payload[i+4],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.',
            isprint(payload[i+2]) ? payload[i+2] : '.',
            isprint(payload[i+3]) ? payload[i+3] : '.',
            isprint(payload[i+4]) ? payload[i+4] : '.'
        );
        break;
    case 6:
        MSG(PREFIX_FORMAT "%02X %02X %02X %02X %02X %02X       -- %c%c%c%c%c%c\n",
            payload[i],
            payload[i+1],
            payload[i+2],
            payload[i+3],
            payload[i+4],
            payload[i+5],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.',
            isprint(payload[i+2]) ? payload[i+2] : '.',
            isprint(payload[i+3]) ? payload[i+3] : '.',
            isprint(payload[i+4]) ? payload[i+4] : '.',
            isprint(payload[i+5]) ? payload[i+5] : '.'
        );
        break;
    case 7:
        MSG(PREFIX_FORMAT "%02X %02X %02X %02X %02X %02X %02X    -- %c%c%c%c%c%c%c\n",
            payload[i],
            payload[i+1],
            payload[i+2],
            payload[i+3],
            payload[i+4],
            payload[i+5],
            payload[i+6],
            isprint(payload[i]) ? payload[i] : '.',
            isprint(payload[i+1]) ? payload[i+1] : '.',
            isprint(payload[i+2]) ? payload[i+2] : '.',
            isprint(payload[i+3]) ? payload[i+3] : '.',
            isprint(payload[i+4]) ? payload[i+4] : '.',
            isprint(payload[i+5]) ? payload[i+5] : '.',
            isprint(payload[i+6]) ? payload[i+6] : '.'
        );
        break;
    default:
        break;
    }
}

EOF


