#!/bin/bash
# Copyright(C) 2017-2100.  jielong.lin@qq.com.   All rights reserved.
#
# Support for
#   continuable download(-C -)
#   hold the default file name (-O)
#   use proxy server (-x IP:Port)

echo
echo "# Support for"
echo "#   continuable download(-C -)"
echo "#   hold the default file name (-O)"
echo "#   use proxy server (-x IP:Port)"
echo
echo "Usage:"
echo "    $0  [URL_to_be_used_for_download]"
echo "    ----------------------------------"
echo
echo "    curl \\ "
echo "        -x 172.20.30.1:3128 \\ "
echo "        -C - \\ "
echo "        -O $1 "
echo "    ----------------------------------"
echo

if [ x"$1" = x ]; then
    exit 0
fi

curl \
    -x 172.20.30.1:3128 \
    -C - \
    -O $1


