/*
 * Copyright(c) 2016-2100.   JLLim.  All rights reserved.
 */
/*
 * FileName:      riv_xxd.c
 * Author:        Jielong Lin 
 * Email:         493164984@qq.com
 * DateTime:      2020-03-06 10:31:50
 * ModifiedTime:  2020-03-06 10:50:37
 */


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define MSG printf 

#ifndef uint8_t
#    define uint8_t  unsigned char
#endif

/**
 * riv_xxd - dump hex raw data and character data with the specified format 
 *
 * dump hex raw data in the left and character data in the right
 *
 * retval: none
 *
 * For VIM, it is similar to the follows:
 *   :%!xxd -g 1
 */
void riv_xxd(void *data, int len)
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


