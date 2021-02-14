#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     frpc__freenat.bid.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-12-07 20:57:11
#   ModifiedTime: 2019-01-17 19:13:12

#frpc_path="/workspace2/jllproject/.github.com/linjielong/reachutils/howto/LocalAreaNetworkPassthrough/frp/frp_0.16.1_linux_amd64/"

frpc_path="/ibbyte512MB/projects/LocalAreaNetworkPassthrough/frp/frp_0.16.1_linux_amd64"

${frpc_path}/frpc -c ${frpc_path}/frpc__freenat.bid &

