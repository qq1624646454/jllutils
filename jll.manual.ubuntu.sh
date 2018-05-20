#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2017-10-30 15:59:57
#   ModifiedTime: 2017-11-05 14:42:06

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF




${Fseablue}Ctrl + Alt + T ${AC}: populate a new terminate console window
${Fseablue}Ctrl + Shift + T ${AC}: create a new terminate console table in current window

${Fseablue}Volume is too small ${AC}
Run the command:
    pulseaudio --start --log-target=syslog
Suggestion:
    append this command into /etc/rc.local


${Fseablue}Waiting for network configuration…${AC}
The eth0 is not linked on startup stage, so system will run /etc/init/failsafe.conf
${Fred}Solved${AC}
Solution-1: remove the unused eth0
Solution-2: change the sleep time in /etc/init/failsafe.conf

Note: wifi is started so slower is because eth0 is bad to delay checking.
Hence please remove the unused eth0


${Fseablue}Enable root login after installing Ubuntu-14.04${AC}
sudo passwd root
vi /usr/share/lightdm/lightdm.conf.d/50-unity-greeter.conf
[SeatDefaults]
greeter-session=unity-greeter
usertDefaults]
greeter-session=unity-greeter
user-session=ubuntu
greeter-show-manual-login=true
${Fred}all-guest=false-session=ubuntu${AC}
${Fred}greeter-show-manual-login=true${AC}
${Fred}all-guest=false${AC}



${Fseablue}stdin:is not tty when login${AC}
Error Found when loading /root/.profile:
stdin: is not a tty
${Fred}Solved${AC}
edit /root/.profile
modify the "mesg n" line to "tty -s && mesg n" then reboot system


${Fseablue}AutoCompleted cmdline after installing Ubuntu-14.04${AC}
Edit ~/.bashrc as follows:
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi





EOF


