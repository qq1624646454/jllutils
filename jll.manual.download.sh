#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.download_by_wget_curl.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-03-09 15:56:24
#   ModifiedTime: 2017-05-26 11:45:37

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

cat >&1 <<EOF

${AC}${Fseablue}
# Obtain the website specified by URL${AC}
wget -c -r -np -k --timeout=3  URL
${AC}${Fseablue}
  e.g:
      wget -c -r -np -k --timeout=3   www.baidu.com
      w3m www.baidu.com/index.html
${AC}


${AC}${Fseablue}
# Obtain
# Obtain the tpvision logcat specified by URL${AC}
wget -c -t0 -T3  URL
${AC}${Fseablue}
  e.g:
      wget -c -t0 -T3 \
          "https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip"
${AC}







${AC}${Fwhite}
==================================================================
    Download a file on https site by wget
        :: Self-signed certificate encountered 
        :: cannot verify developers.tpvision.com's certificate'
==================================================================${AC}
jielong.lin@TpvServer:~/test\$${Fyellow}wget -c -t0 -T3 "https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip"${Fgreen}
--2017-05-26 09:33:09--  https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip
Resolving developers.tpvision.com (developers.tpvision.com)... 172.27.221.45
Connecting to developers.tpvision.com (developers.tpvision.com)|172.27.221.45|:443... connected.
WARNING: cannot verify developers.tpvision.com's certificate, issued by '/C=IN/ST=KARNATAKA/L=BANGALORE/O=TPVISION INDIA PVT LTD/OU=IT/CN=indbrlx023.tpvision.com/emailAddress=sharath.babu@tpvision.com':
  Self-signed certificate encountered.
    WARNING: certificate common name 'indbrlx023.tpvision.com' doesn't match requested host name 'developers.tpvision.com'.
HTTP request sent, awaiting response... No data received.
Retrying.
${AC}${Fblue}
Solve:
${AC}
jielong.lin@TpvServer:~/test$ ${Fyellow} curl -O  https://developers.tpvision.com/istreams/data/2017-05-25_14-05-53_TPVisionDebug.zip ${Fgreen}
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
 27 19.0M   27 5312k    0     0  33455      0  0:09:55  0:02:42  0:07:13     0
${AC}${Fred}
-O: let saved file name is the same to the remote file. ${AC}


${AC}${Fblue}
Solve: Please switch to execute it on 172.20.30.6 if the above still failure.
${AC}


EOF
