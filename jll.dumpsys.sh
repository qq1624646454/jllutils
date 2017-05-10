#!/bin/bash
#

echo "逻辑CPU个数"
cat /proc/cpuinfo | grep "pro"|wc -l
echo
echo "多线程支持"
cat /proc/cpuinfo | grep -qi "core id" |echo $?
echo
echo "实际CPU个数"
cat /proc/cpuinfo | grep "physical id" |sort | uniq | wc -l
logical_cpu_per_phy_cpu=$(cat /proc/cpuinfo |grep "siblings"| sort | uniq | awk -F: '{print $2}')
echo
echo "每个物理CPU中逻辑CPU的个数"
echo $logical_cpu_per_phy_cpu


echo
echo "查看代表vCPU的QEMU的线程"
ps -eLo ruser,pid,ppid,lwp,psr,args |grep qemgrep -v grep

echo
echo "查看CPU0的进程数"
ps -eLo psr|grep 0|wc -l



