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
if [ x"$(which wc)" != x ]; then
echo -ne "${Fseablue}逻辑CPU个数:${AC}  "
cat /proc/cpuinfo | grep -i "pro" 2>/dev/null |wc -l
fi
echo -ne "${Fseablue}多线程支持:${AC}  "
cat /proc/cpuinfo | grep -qi "core id" 2>/dev/null && echo "yes" || echo "no"

if [ x"$(which sort)" != x -a y"$(which uniq)" != y -a z"$(which wc)" != z ]; then
echo -ne "${Fseablue}实际CPU个数:${AC}  "
cat /proc/cpuinfo | grep -i "physical id" 2>/dev/null |sort | uniq | wc -l
logical_cpu_per_phy_cpu=$(cat /proc/cpuinfo |grep -i "siblings" 2>/dev/null \
                          | sort | uniq | awk -F: '{print $2}')
echo -ne "${Fseablue}每个物理CPU中逻辑CPU的个数:${AC}  "
echo ${logical_cpu_per_phy_cpu}
fi

echo -ne \
"${Fseablue}查看代表vCPU的QEMU的线程(lwp-light weight process,thread; psr-assign to which):${AC}  "
ps -eLo ruser,pid,ppid,lwp,psr,args 2>/dev/null|grep -i qemu | grep -v grep 2>/dev/null
echo
if [ x"$(which wc)" != x ]; then
echo -ne "${Fseablue}查看CPU0的进程数:${AC}  "
ps -eLo psr 2>/dev/null|grep 0 2>/dev/null |wc -l
fi
echo
if [ x"$(which free)" != x ]; then
echo -e \
"${Bseablue}${Fblack}当前内存使用情况(MB)                                                     ${AC}"
free -t -m
#echo -e \
#"${Bseablue}${Fblack}                                                                       ${AC}"
fi
echo
if [ x"$(which ps)" != x -a y"$(which sort)" != y -a z"$(which head)" != z -a w"$(which tail)" != w ]; 
then
echo -e \
"${Bseablue}${Fblack}内存占用率前6名的进程(VSZ=虚拟内存-KB,RSZ=实际内存-KB,STIME=进程启动时间)${AC}"
#ps ax -o "pid,pmem,vsz,rsz,pcpu,stime,user,uid,comm,args"|head -1;
#ps ax -o "pid,pmem,vsz,rsz,pcpu,stime,user,uid,comm,args"|sort -rn -k2|head -6
ps ax -o "pid,pmem,vsz,rsz,pcpu,stime,user,uid,comm"|head -1;
ps ax -o "pid,pmem,vsz,rsz,pcpu,stime,user,uid,comm" | tail -n +2 |sort -rn -k2|head -6
echo -e \
"${Bseablue}${Fblack}CPU占用率前6名的进程                                                     ${AC}"
#ps ax -o "pid,pcpu,pmem,vsz,rsz,stime,user,uid,comm,args"|head -1;
#ps ax -o "pid,pcpu,pmem,vsz,rsz,stime,user,uid,comm,args"|sort -rn -k2|head -6
ps ax -o "pid,pcpu,pmem,vsz,rsz,stime,user,uid,comm"|head -1;
ps ax -o "pid,pcpu,pmem,vsz,rsz,stime,user,uid,comm" | tail -n +2 |sort -rn -k2|head -6
fi
echo
echo -ne "${Fseablue}当前使用的图形环境启动器:${AC}   "
cat  /etc/X11/default-display-manager
echo

echo
