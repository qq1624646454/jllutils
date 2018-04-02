#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.linux_mem.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-04-02 09:58:02
#   ModifiedTime: 2018-04-02 10:00:01

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more>&1<<EOF

按内存占用从大到小排序
按大写M显示虚拟内存：VSZ表示虚拟内存大小
按大写S显示物理内存：RSS表示物理内存大小

/ # top
Mem: 48016K used, 1656K free, 144K shrd, 0K buff, 4324K cached
CPU:  0.5% usr  3.7% sys  0.0% nic 95.1% idle  0.5% io  0.0% irq  0.0% sirq
Load average: 1.11 0.98 0.60 1/283 1963
  PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
  723     1 root     S <   202m414.8   0  0.0 /usr/bin/thermal-engine
  783     1 root     S     193m395.9   0  0.0 /usr/bin/netmgrd
 1126     1 root     S     129m265.4   0  0.0 mcm_ril_service
 1134     1 root     S    99864199.9   0  0.0 mcm_data_srv
 1129     1 root     S    91104182.3   0  0.5 mcmlocserver
  460     1 root     S    60800121.7   0  0.0 QCMAP_ConnectionManager /data/mobi
  246     1 root     S    57184114.4   0  0.5 /sbin/adbd
 1279  1268 root     S    56880113.8   0  0.0 ReachDemo
  660     1 root     S    55924111.9   0  0.5 /usr/bin/time_daemon
 1320  1318 root     S    55856111.8   0  0.0 ReachDemo
  232     1 root     S    55824111.7   0  0.0 psmd
  464     1 root     S    48252 96.6   0  0.0 /usr/bin/qti
  477     1 root     S    30460 60.9   0  0.0 /sbin/fs-scrub-daemon
  992     1 root     S    23652 47.3   0  0.0 /usr/bin/mbimd
  970     1 root     S    23344 46.7   0  0.0 /usr/bin/atfwd_daemon
  718     1 root     S    13440 26.9   0  0.0 /usr/bin/qmuxd
  993     1 diag     S    12568 25.1   0  0.0 /usr/bin/diagrebootapp
  797     1 root     S     4804  9.6   0  0.0 /usr/bin/qmi_shutdown_modem
 1961  1355 root     R     3508  7.0   0  1.0 {top} /bin/busybox /bin/top
 1355   246 root     S     3508  7.0   0  0.0 {sh} /bin/busybox /bin/sh -


Mem total:49672 anon:13524 map:3188 free:1812
 slab:13604 buf:0 cache:3828 dirty:0 write:0
Swap total:0 free:0
  PID   VSZ VSZRW   RSS^(SHR) DIRTY (SHR) STACK COMMAND
 1129 91104 76976  3588  1216  1512     0   132 mcmlocserver
  783  193m  187m  2592   868  1592     0   132 /usr/bin/netmgrd
 1134 99864 93156  2340  1124  1172     0   132 mcm_data_srv
 1126  129m  122m  2048   936  1004     0   132 mcm_ril_service
  460 60800 52260  1684   744   900     0   132 QCMAP_ConnectionManager /data/m
  723  202m  197m  1592   752   840     0   132 /usr/bin/thermal-engine
  232 55824 50992  1324   676   648     0   132 psmd
  464 48252 42932  1304   624   664     0   132 /usr/bin/qti
 1320 55856 50932  1276   916   356     0   132 ReachDemo
  660 55924 51032  1272   632   620     0   132 /usr/bin/time_daemon
 1279 56880 51008  1260   932   308     0   132 ReachDemo
  718 13440 10116  1196   652   544     0   132 /usr/bin/qmuxd
  477 30460 26396  1148   572   576     0   132 /sbin/fs-scrub-daemon
  246 57184 49860  1092   628   380     0   132 /sbin/adbd
  992 23652 18180  1080   588   492     0   132 /usr/bin/mbimd
 1355  3508   312   888   744   120     0   132 {sh} /bin/busybox /bin/sh -
  970 23344 18972   832   588   244     0   132 /usr/bin/atfwd_daemon
 1268  3508   312   796   692   104     0   132 {sh} /bin/busybox /bin/sh -
 5655  3512   316   796   644   104     0   132 {top} /bin/busybox /bin/top
 1318  3508   312   792   688   104     0   132 {sh} /bin/busybox /bin/sh -




查看/proc/PID/status查看VmRSS（物理内存）和VmSize（虚拟内存）

单个进程各资源占用内存的情况
/ # pmap 723
723: {no such process} /usr/bin/thermal-engine
7f555000     144K r-xp  /usr/bin/thermal-engine
7f57a000       4K r--p  /usr/bin/thermal-engine
7f57b000    3380K rw-p  /usr/bin/thermal-engine
7f8c8000     404K rw-p  [heap]
aa800000       4K ---p    [ anon ]
...



EOF

