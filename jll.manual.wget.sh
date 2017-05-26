#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.wget.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-03-09 15:56:24
#   ModifiedTime: 2017-03-09 15:59:09

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

# Obtain the website specified by URL
wget -c -r -np -k --timeout=3  URL
  e.g:
      wget -c -r -np -k --timeout=3   www.baidu.com
      w3m www.baidu.com/index.html


==================================
jielong.lin@TpvServer:~/test$ wget --no-check-certificate https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip
--2017-05-26 09:33:09--  https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip
Resolving developers.tpvision.com (developers.tpvision.com)... 172.27.221.45
Connecting to developers.tpvision.com (developers.tpvision.com)|172.27.221.45|:443... connected.
WARNING: cannot verify developers.tpvision.com's certificate, issued by `/C=IN/ST=KARNATAKA/L=BANGALORE/O=TPVISION INDIA PVT LTD/OU=IT/CN=indbrlx023.tpvision.com/emailAddress=sharath.babu@tpvision.com':
  Self-signed certificate encountered.
    WARNING: certificate common name `indbrlx023.tpvision.com' doesn't match requested host name `developers.tpvision.com'.
HTTP request sent, awaiting response... No data received.
Retrying.































EOF

