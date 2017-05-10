#!/bin/bash
# Copyright(c) 2016-2100   jielong.lin   All rights reserved.
#

source ./BashShellLibrary

#-----------------------
# The Main Entry Point
#-----------------------

if [ -e "/home/jielong.lin/aosp_6.0.1_r10_selinux" ]; then
    cd /home/jielong.lin/aosp_6.0.1_r10_selinux
    /usr/bin/vicc --auto 
fi

if [ -e "/home/jielong.lin/2k16_mtk_ppr1devprod" ]; then
    cd /home/jielong.lin/2k16_mtk_ppr1devprod
    /usr/bin/vicc --auto 
fi



#################################################################################

