#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     SimpleHttpServer.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-01-17 19:13:48
#   ModifiedTime: 2019-01-22 09:28:30

if [ x"$(ps aux | grep -i 'SimpleHttpServer 8080' | grep -v 'grep')" = x ]; then
    cd /ibbyte512MB/projects/L170/Products
    /ibbyte512MB/.github.com/qq1624646454/jllutils/jll.SimpleHttpServer.sh  8080 &
    cd -
fi

