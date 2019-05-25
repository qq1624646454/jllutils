#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.syscall.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-05-25 16:10:53
#   ModifiedTime: 2019-05-25 17:26:33

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

Usage()
{
more >&1<<EOF

  USAGE:
    ${0##*/} <syscall-function-name>

    ${0##*/} <syscall-function-name> [ignored_subdirectory_list]
 
  ForExample:
    sw/L170L_baseline/apps_proc/kernel# jll.syscall.sh socket

    sw/L170L_baseline/apps_proc/kernel# jll.syscall.sh socket drivers
    sw/L170L_baseline/apps_proc/kernel# jll.syscall.sh socket tools Documentation include

EOF

}

if [ $# -lt 1 ]; then
  Usage
  exit 0
fi

start=$(date +%s%N)
start_ms=${start:0:16}

if [ $# -eq 1 ]; then
cat >&1<<EOF

-----------------------------------------------------------------------
RUNing the followwing command
-----------------------------------------------------------------------
  find . -type f -a -name *.c \\
    | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} \\
    | grep "$1[ ]\{0,\}," --color
-----------------------------------------------------------------------

EOF

  find . -type f -a -name *.c | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} \
    | grep "$1[ ]\{0,\}," --color
else
  CONF_ARGS1="-path ./$2"
  for((i=3;i<=$#;i++)) {
    CONF_ARGS1="${CONF_ARGS1} -o -path "./$(eval echo "$"$i)
  }

#  find . \( ${CONF_ARGS1} \) -prune \
#         -o \( -type f  -a  -name '*.C' -print \
#         -o -name '*.c' -print \
#         -o -name '*.cpp' -print \
#         -o -name '*.cc' -print \
#         -o -name '*.vc' -print \
#         -o -name '*.s' -print \
#         -o -name '*.S' -print \
#         -o -name '*.h' -print \
#         -o -name '*.H' -print \
#         -o -name '*.java' -print \) \
#    | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} \
#    | grep "$1[ ]\{0,\}," --color

cat >&1<<EOF

-----------------------------------------------------------------------
RUNing the followwing command
-----------------------------------------------------------------------
  find . \( ${CONF_ARGS1} \) -prune \\
         -o \( -type f  -a  -name '*.C' -print \\
         -o -name '*.c' -print \\
         -o -name '*.cpp' -print \\
         -o -name '*.s' -print \\
         -o -name '*.S' -print \) \\
    | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} \\
    | grep "$1[ ]\{0,\}," --color
-----------------------------------------------------------------------

EOF

  find . \( ${CONF_ARGS1} \) -prune \
         -o \( -type f  -a  -name '*.C' -print \
         -o -name '*.c' -print \
         -o -name '*.cpp' -print \
         -o -name '*.s' -print \
         -o -name '*.S' -print \) \
    | xargs -i grep "SYSCALL_DEFINE[0-9]\{1,\}[ ]\{0,\}(" -nH {} \
    | grep "$1[ ]\{0,\}," --color

  [ x"${CONF_ARGS1}" != x ] && unset CONF_ARGS1
fi

end=$(date +%s%N)
end_ms=${end:0:16}
cost_time=$(echo "scale=6;($end_ms - $start_ms)/1000000" | bc)

echo
echo "=========================================="
echo "JLLim| COST TIME is: ${cost_time} s"
echo "=========================================="
echo

[ x"${start}" != x ] && unset start 
[ x"${start_ms}" != x ] && unset start_ms 
[ x"${end}" != x ] && unset end 
[ x"${end_ms}" != x ] && unset end_ms 
[ x"${cost_time}" != x ] && unset cost_time
