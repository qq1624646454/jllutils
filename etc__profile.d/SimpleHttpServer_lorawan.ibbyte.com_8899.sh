#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     SimpleHttpServer.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-17 19:13:48
#   ModifiedTime: 2019-01-17 19:26:45

if [ x"$(ps aux | grep -i 'SimpleHttpServer 8899' | grep -v 'grep')" = x ]; then
    cd /ibbyte512MB/projects/LoRa_LongRange
    /ibbyte512MB/.github.com/qq1624646454/jllutils/jll.SimpleHttpServer.sh 8899  &
    cd -
fi

