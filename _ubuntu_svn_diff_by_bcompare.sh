#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     _ubuntu_svn_diff_by_bcompare.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2018-01-19 15:14:09
#   ModifiedTime: 2018-01-19 15:14:09


# Configure your favorite diff program here.
DIFF=/usr/bin/bcompare

# Subversion provides the paths we need as the sixth and seventh 
# parameters.
LEFT=${6}
RIGHT=${7}

# Call the diff command (change the following line to make sense for
# your merge program).
$DIFF --left $LEFT --right $RIGHT

# Return an errorcode of 0 if no differences were detected, 1 if some were.
# Any other errorcode will be treated as fatal.
