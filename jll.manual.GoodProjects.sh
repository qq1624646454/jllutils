#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.GoodProjects.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-16 14:11:09
#   ModifiedTime: 2017-08-16 14:14:58

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"
more >&1<<EOF


${Fseablue}在播放列表中播放的Android播放器${AC}
${Fyellow}效果是：不管列表有没有滚动，只要页面出现播放器，就会播放节目,类似微博的短视频${AC}
    http://www.open-open.com/lib/view/open1454127563823.html
    https://github.com/danylovolokh/VideoPlayerManager
        git clone https://github.com/danylovolokh/VideoPlayerManager.git 


EOF

