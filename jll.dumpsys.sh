#!/bin/bash
#

# adapt to more/echo/less and so on
  ESC=
  AC=${ESC}[0m
  Fblack=${ESC}[30m
  Fred=${ESC}[31m
  Fgreen=${ESC}[32m
  Fyellow=${ESC}[33m
  Fblue=${ESC}[34m
  Fpink=${ESC}[35m
  Fseablue=${ESC}[36m
  Fwhite=${ESC}[37m
  Bblack=${ESC}[40m
  Bred=${ESC}[41m
  Bgreen=${ESC}[42m
  Byellow=${ESC}[43m
  Bblue=${ESC}[44m
  Bpink=${ESC}[45m
  Bseablue=${ESC}[46m
  Bwhite=${ESC}[47m



echo
echo -ne "${Fseablue}逻辑CPU个数:${AC}  "
cat /proc/cpuinfo | grep "pro" 2>/dev/null |wc -l
echo
echo -ne "${Fseablue}多线程支持:${AC}  "
cat /proc/cpuinfo | grep -qi "core id" 2>/dev/null |echo $?
echo
echo -ne "${Fseablue}实际CPU个数:${AC}  "
cat /proc/cpuinfo | grep "physical id" 2>/dev/null |sort | uniq | wc -l
echo
logical_cpu_per_phy_cpu=$(cat /proc/cpuinfo |grep "siblings"| sort | uniq | awk -F: '{print $2}')
echo -ne "${Fseablue}每个物理CPU中逻辑CPU的个数:${AC}  "
echo ${logical_cpu_per_phy_cpu}
echo
if [ x"$(which free)" != x ]; then
    echo -e "${Bseablue}${Fblack}当前内存使用情况  ${AC}"
    free -g
    echo -e "${Bseablue}${Fblack}                  ${AC}"
fi
echo -ne "${Fseablue}查看代表vCPU的QEMU的线程:${AC}  "
ps -eLo ruser,pid,ppid,lwp,psr,args |grep qemgrep -v grep 2>/dev/null

echo
echo -ne "${Fseablue}查看CPU0的进程数:${AC}  "
ps -eLo psr|grep 0 2>/dev/null |wc -l


echo
echo ""


