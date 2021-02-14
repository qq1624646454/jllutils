#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-30 15:59:57
#   ModifiedTime: 2019-08-08 22:48:42

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

${Fseablue}#Append the follows to ~/.bashrc and mkdir -pv ~/.bashrc.d${AC}
if [ -d ~/.bashrc.d ]; then
  for i in ~/.bashrc.d/*.sh; do
    if [ -r \$i ]; then
      . \$i
    fi
  done
  unset i
fi

${Fseablue}#Put the file named to_anywhere.sh in ~/.bashrc.d what its content is as follows:${AC}
function to_ws()
{
    cd /repository/corporation/Reachxm
}
export -f to_ws

${Fseablue}#Put the file named audio_on.sh in ~/.bashrc.d what its content is as follows:${AC}
function audio_on()
{
    pulseaudio --start --log-target=syslog
}
export -f audio_on





============================================================================================

${Fseablue}Ctrl + Alt + T ${AC}: populate a new terminate console window
${Fseablue}Ctrl + Shift + T ${AC}: create a new terminate console table in current window

${Fseablue}Volume is too small ${AC}
Run the command:
    pulseaudio --start --log-target=syslog
Suggestion:
    append this command into /etc/rc.local

Modifying the below configurated file:
vim /etc/modprobe.d/alsa-base.conf
   ...
   #add by jllim
   options snd-hda-intel model=auto
   :w
/sbin/alsa force-reload


${Fseablue}Waiting for network configuration…${AC}
The eth0 is not linked on startup stage, so system will run /etc/init/failsafe.conf
${Fred}Solved${AC}
Solution-1: remove the unused eth0
Solution-2: change the sleep time in /etc/init/failsafe.conf

Note: wifi is started so slower is because eth0 is bad to delay checking.
Hence please remove the unused eth0



${Fwhite}${Bgreen} Auto-mount partitions  ${AC}
\$ sudo vi /etc/fstab
...
# <file system> <mount point>   <type>  <options>          <dump>  <pass>
  /dev/sda4     /fight4honor    ext4    errors=remount-ro  0       1
  /dev/sda3     /ibbyte         ext4    errors=remount-ro  0       1
  /dev/sda2     /my             ext4    defaults           0       2 
:w


${Fwhite}${Bgreen} stdin:is not tty when login ${AC}
Error Found when loading /root/.profile:
stdin: is not a tty
${Fred}Solved${AC}
edit /root/.profile
modify the "mesg n" line to "tty -s && mesg n" then reboot system


${Fwhite}${Bgreen} Enable root auto-login after installing Ubuntu-14.04 ${AC}
\$ sudo passwd root
${Bred}${Fyellow}for Ubuntu (using lightdm)${AC}
# vi /etc/lightdm/lightdm.conf
[SeatDefaults]
autologin-guest=false
autologin-user=root
autologin-user-timeout=0
autologin-session=lightdm-autologin
user-session=ubuntu
greeter-session=unity-greeter
:w
修改autologin-user=root

# vi /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
[SeatDefaults]
greeter-session=unity-greeter


${Fwhite}${Bgreen} AutoCompleted cmdline after installing Ubuntu-14.04 ${AC}
Edit ~/.bashrc as follows:
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


${Fwhite}${Bgreen} Install input method by fcitx wubi/pinyin ${AC} 
# apt-get install fcitx-frontend-all fcitx-ui-classic fcitx-table-wubi
# cp -rvf /etc/X11/xinit/xinputrc  /etc/X11/xinit/xinputrc.orig
# im-config 
JLL: Select fcitx and the update for /etc/X11/xinit/xinputrc
# gnome-control-center
JLL: select Input Sources About EN and CN
# /usr/bin/fcitx-autostart
# fcitx-configtool


# reboot


${Fgreen} Which desktop subsystem ${AC}
    echo \$DESKTOP_SESSION


${Fwhite}${Bgreen} Install git tools ${AC}
 apt-get install git git-svn git-doc git-email gitweb git-man 
 git config --global push.default matching 
 git config --global push.default simple 
 git config --global user.name "Jielong Lin"


${Fwhite}${Bgreen} Install ssh tools ${AC} 
 apt-get install openssh-client openssh-server

${Fred} Can't signing in by root ${AC}
Please change "PermitRootLogin without-password" to "PermitRootLogin yes"
in /etc/ssh/sshd_config or /etc/ssh/ssh_config


${Fred} the permission of the setuid helper is not correct解决办法 ${AC}
chmod u+s,a+r /usr/lib/dbus-1.0/dbus-daemon-launch-helper
apt-get -f install


${Fred} How to download Ubuntu 14.04 ${AC}
Open link to https://www.ubuntu.com/download/alternative-downloads
Download BitTorrent and Open BitTorrent to Download Ubuntu image is very fast
I recommend that it is performed by firefox on ubuntu 14.04

EOF


