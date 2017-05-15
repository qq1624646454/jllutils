#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     ._______auto_sync_by_GIT__in_crontab.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-05-11 14:34:27
#   ModifiedTime: 2017-05-15 11:34:06

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

__RemoteRepository=$(/usr/bin/git remote show origin | /bin/grep -E '^[ ]{0,}Push[ ]{1,}URL:')
__RemoteRepository=${__RemoteRepository#*:}
[ x"${__RemoteRepository}" = x ] && __RemoteRepository="remote.${JLLSELF}"

cd ${JLLPATH}
/bin/echo "synchronizing with ${__RemoteRepository} @${__DT}"        >  _______auto_sync_by_GIT__in_crontab.log
__GitCHANGE="$(/usr/bin/git status -s)"
if [ x"${__GitCHANGE}" != x ]; then
    /usr/bin/git status -s                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git add    -A                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git commit -m \
'
  Changes as follows: 
      ${__GitCHANGE}
'    >> _______auto_sync_by_GIT__in_crontab.log
    /bin/echo                                                        >> _______auto_sync_by_GIT__in_crontab.log
    /bin/echo "Push Changes to '${__RemoteRepository}' by git push"  >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git push                                                >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git status -s                                           >> _______auto_sync_by_GIT__in_crontab.log
    /usr/bin/git log                                                 >> _______auto_sync_by_GIT__in_crontab.log
    /bin/echo                                                        >> _______auto_sync_by_GIT__in_crontab.log
fi
/bin/echo                                                            >> _______auto_sync_by_GIT__in_crontab.log
/bin/echo "Pull Changes from '${__RemoteRepository}' by git pull "   >> _______auto_sync_by_GIT__in_crontab.log
/usr/bin/git pull                                                    >> _______auto_sync_by_GIT__in_crontab.log
/usr/bin/git log                                                     >> _______auto_sync_by_GIT__in_crontab.log
/bin/echo                                                            >> _______auto_sync_by_GIT__in_crontab.log
cd - >/dev/null

