#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     ._______audo_sync_by_git_pull__in_crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 14:34:27
#   ModifiedTime: 2017-05-11 14:47:21

JLLPATH="$(/usr/bin/which $0)"
JLLSELF="$(/usr/bin/basename ${JLLPATH})"
JLLPATH="$(/usr/bin/dirname ${JLLPATH})"

__DT=$(/bin/date +%Y-%m-%d_%H:%M:%S)

if [ -e "${JLLPATH}/.git" ]; then
    echo
    /bin/rm -rf ${HOME}/cron.*.log
    echo
    echo "JLL: Error because not present \"${JLLPATH}/.git\"" > ${HOME}/cron.${JLLSELF}@${__DT}.log 
    echo
    exit 0
fi
cd ${JLLPATH}
/usr/bin/git pull
/bin/echo "updated by git pull @${__DT}" > _______audo_sync_by_git_pull__in_crontab.log
cd - >/dev/null

