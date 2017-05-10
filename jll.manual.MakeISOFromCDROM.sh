#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

echo -e
echo -e "root@TpvUbuntu:~/Desktop# df -h"
echo -e "Filesystem      Size  Used Avail Use% Mounted on"
echo -e "udev            1.7G  4.0K  1.7G   1% /dev"
echo -e "tmpfs           350M  1.9M  348M   1% /run"
echo -e "/dev/sda3       246G  142G   92G  61% /"
echo -e "none            4.0K     0  4.0K   0% /sys/fs/cgroup"
echo -e "none            5.0M     0  5.0M   0% /run/lock"
echo -e "none            1.8G  8.0K  1.8G   1% /run/shm"
echo -e "none            100M   44K  100M   1% /run/user"
echo -e "/dev/sda1        81G   56G   25G  70% /microsoft"
echo -e "\033[0m\033[31m\033[43m/dev/sr0\033[0m       2.5G  2.5G     0 100% /media/root/UDF Volume"
echo -e
echo -e "root@TpvUbuntu:~/Desktop# \033[0m\033[31m\033[43mdd if=/dev/sr0  of=/root/Desktop/Windows7.iso\033[0m"
echo -e "5086464+0 records in"
echo -e "5086464+0 records out"
echo -e "2604269568 bytes (2.6 GB) copied, 432.583 s, 6.0 MB/s"
echo -e


