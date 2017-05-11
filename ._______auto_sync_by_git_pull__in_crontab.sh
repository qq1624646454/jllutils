#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     ._______auto_sync_by_git_pull__in_crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 14:34:27
#   ModifiedTime: 2017-05-11 22:09:33

JLLPATH="$(/usr/bin/which $0)"
JLLPATH="$(/usr/bin/dirname ${JLLPATH})"
JLLPATH=$(cd ${JLLPATH} >/dev/null;pwd)
JLLSELF="$(/usr/bin/basename ${JLLPATH})"
if [ x"${JLLSELF}" = x ]; then
    JLLSELF=$(/bin/pwd)
    JLLSELF="$(/usr/bin/basename ${JLLSELF})"
    [ x"${JLLSELF}" = x ] && JLLSELF=unknown
fi

__DT=$(/bin/date +%Y-%m-%d_%H:%M:%S)

if [ ! -e "${JLLPATH}/.git" ]; then
    echo
    /bin/rm -rf ${HOME}/cron.*.log
    echo
    echo "JLL: Error because not present \"${JLLPATH}/.git\"" > ${HOME}/cron.${JLLSELF}@${__DT}.log 
    echo "JLL: FOR ${JLLSELF}" >> ${HOME}/cron.${JLLSELF}@${__DT}.log 
    echo
    exit 0
fi
cd ${JLLPATH}
/usr/bin/git pull
/bin/echo "updated by git pull @${__DT}" > _______auto_sync_by_git_pull__in_crontab.log
cd - >/dev/null

