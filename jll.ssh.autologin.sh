#!/bin/bash
#

read -p "Done autologin with ssh by generate ~/.ssh/id_dsa if press [y], or exit:   " GvChoice

if [ x"${GvChoice}" = x"y" ]; then

    ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa

    cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

fi

exit 0
####################################################################
#  Copyright (c) 2015.  lin_jie_long@126.com,  All rights reserved.
####################################################################


