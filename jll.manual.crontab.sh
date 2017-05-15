#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 10:03:53
#   ModifiedTime: 2017-05-15 19:33:50

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


more >&1<<EOF

${AC}${Fseablue}
    -------------------------------------------------------------------------------
    非root用户环境下使用脚本将任务写入crontab 
    ------------------------------------------------------------------------------- 
    (0): minute (m), hour (h), day of month (dom), month (mon), day of week (dow)
    (1): m=分钟1～59, 每分钟用*或者 */1表示 
    (2): h=小时1～23(0表示0点)
    (3): dom=日期1～31
    (4): mon=月份1～12
    (5): dow=星期0～6(0表示星期天)
    (6): command=执行的shell命令

    For Example:
        #每天每逢1,3,4,7点执行一次/bin/usershell
          # m  h        dom  mon  dow  command
            *  1,3,5,7  *    *    *    /bin/usershell
        #每天每2小时执行一次/bin/usershell
          # m   h    dom   mon  dow  command
            *   */2  *     *    *    /bin/usershell
        #每天每小时从0到12分钟每分钟执行一次/bin/usershell
          # m     h  dom   mon  dow  command
            0-12  *  *     *    *    /bin/usershell
        #每天每分钟执行一次/bin/usershell
          # m  h  dom  mon  dow  command
            *  *  *    *    *    /bin/usershell

    冲突处理：
        由于日期可以用　月 限定，也可以用　星期 限定，如何两个段(field)有冲突，
        第六段的命令将在匹配任何一个的情况下都运行

    For Example
        #将在每月的1号和15号加每个周五,上午4：30运行
          # m   h  dom   mon  dow  command
            30  4  1,15  *    5    /bin/usershell

    符号"%"
        "%"在Cron文件中,有"结束命令行","换行","重定向"的作用,假如不需要"%"的特殊作用,
        需要使用转义符转义.
${AC}


     # add the new task
     jl@S:~$ ${AC}${Fpink}crontab -l > tsk.crontab ${AC}
     jl@S:~$ ${AC}${Fpink}echo "# m h dom mon dow command" >> tsk.crontab ${AC}
     jl@S:~$ ${AC}${Fpink}echo "  * 1 3   2   1   /usr/bin/touch \${HOME}/test" >> tsk.crontab ${AC}
     jl@S:~$ ${AC}${Fpink}crontab tsk.crontab ${AC}

     # remove all tasks belonged to the user jl 
     jl@S:~$ ${AC}${Fpink}crontab -r ${AC}

     # change the default editor
     jl@S:~$ ${AC}${Fpink}select-editor ${AC}

EOF

