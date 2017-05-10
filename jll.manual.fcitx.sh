#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary


more >&1 << EOF

# aptitude install fcitx-frontend-all
# aptitude install fcitx-ui-classic
# aptitude install fcitx-table-wubi

# cp -rvf /etc/X11/xinit/xinputrc  /etc/X11/xinit/xinputrc.orig
# im-config 
JLL: Select fcitx and the update for /etc/X11/xinit/xinputrc

# gnome-control-center
JLL: select Input Sources About EN and CN

# /usr/bin/fcitx-autostart
# fcitx-configtool



EOF

