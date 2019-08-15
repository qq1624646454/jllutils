#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu-18.04.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2019-02-21 21:37:24
#   ModifiedTime: 2019-02-27 22:41:26

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

more >&1<<EOF

----------------------------------------------------------
Settings for basic
----------------------------------------------------------
jllim@ibbyte:.$ sudo passwd root 
  password for jllim
  type new password for root
  re-type new password for root
jllim@ibbyte:.$ su - root
root@ibbyte:.#
root@ibbyte:.# apt-get install aptitude
root@ibbyte:.# apt-get install git
root@ibbyte:.#
root@ibbyte:.# cd ~/
root@ibbyte:.# mkdir -pv gitee.com/jllim
root@ibbyte:.# cd gitee.com/jllim
root@ibbyte:.# git clone https://gitee.com/jllim/vicc_for_linux64_installer.git
root@ibbyte:.# cd vicc_for_linux64_installer/
root@ibbyte:.# ./vicc_installer_over_linux64.sh
root@ibbyte:.# 
root@ibbyte:.# 
root@ibbyte:.# cd ~/
root@ibbyte:.# mkdir -pv github.com/qq1624646454/
root@ibbyte:.# cd github.com/qq1624646454/
root@ibbyte:.# git clone https://github.com/qq1624646454/jllutils.git
root@ibbyte:.# cd jllutils/
root@ibbyte:.# ./____install_jllutils.sh
root@ibbyte:.# 
root@ibbyte:.# 

#for command ifconfig
aptitude install net-tools -y

#for vim
apt-get install libpython2.7-dev -y

----------------------------------------------------------
Settings for wubi input-method
----------------------------------------------------------
root@ibbyte:.# aptitude install fcitx-frontend-all
root@ibbyte:.# aptitude install fcitx-ui-classic
root@ibbyte:.# aptitude install fcitx-table-wubi
root@ibbyte:.# cp -rvf /etc/X11/xinit/xinputrc  /etc/X11/xinit/xinputrc.orig
root@ibbyte:.# im-config 
  Select fcitx and the update for /etc/X11/xinit/xinputrc
root@ibbyte:.# gnome-control-center
  select Input Sources About EN and CN
root@ibbyte:.# 
root@ibbyte:.# /usr/bin/fcitx-autostart
root@ibbyte:.# fcitx-configtool




----------------------------------------------------------
Login with root by auto-login
----------------------------------------------------------
root@ibbyte:.# cd /usr/share/lightdm/lightdm.conf.d/
root@ibbyte:.# cp -rvf 50-ubuntu.conf __50-ubuntu.conf.orig
root@ibbyte:.# vi 50-ubuntu.conf
  [Seat:*]
  greeter-show-manual-login=true
  user-session=ubuntu
  all-guest=false

root@ibbyte:.# cd /etc/pam.d/
root@ibbyte:.# 
root@ibbyte:.# cp -rvf gdm-password gdm-password.orig
root@ibbyte:.# cp -rvf gdm-password 
  ...
  #auth   required    pam_succeed_if.so user != root quiet_succes
  ...
root@ibbyte:.# cp -rvf gdm-autologin gdm-autologin.orig
root@ibbyte:.# vi gdm-autologin
  ...
  #auth	required	pam_succeed_if.so user != root quiet_success
  ...

root@ibbyte:.# cd /etc/pam.d/
root@ibbyte:.# 
root@ibbyte:.# cp -rvf gdm-autologin gdm-autologin.orig
root@ibbyte:.# vi gdm-autologin
  ...
  # Enabling automatic login
  #  AutomaticLoginEnable = true
  #  AutomaticLogin = user1
  AutomaticLoginEnable = true
  AutomaticLogin = root
  ...

root@ibbyte:.#
root@ibbyte:.# vim /root/.profile
  ...
  if [ "\$BASH" ]; then
    if [ -f ~/.bashrc ]; then
      . ~/.bashrc
    fi
  fi

  tty -s && mesg n || true


----------------------------------------------------------
Permit root login by ssh
----------------------------------------------------------
root@ibbyte.# aptitude install openssh-server
root@ibbyte.#
root@ibbyte.# vim /etc/ssh/sshd_config
  append the follows:
  PermitRootLogin yes 
root@ibbyte.#
root@ibbyte.# /etc/init.d/ssh restart
root@ibbyte.# ssh root@localhost



----------------------------------------------------------
non-audio or volume too small no matter firefox or system
----------------------------------------------------------
root@ibbyte:.# aptitude install pavucontrol
root@ibbyte:.#
root@ibbyte:.# pulseaudio --start --log-target=syslog
root@ibbyte:.#
root@ibbyte:.# pavucontrol
  It is Volume Control
  1.Set Built-in Audio Profile to Analog Stereo Duplex (unplugged) 
        from Configuration
  2.Set Port: Line Out (unplugged) from Output Devices
    #Set Advanced to PCM,AC3,EAC3,DTS,MPEG,AAC and Show:Hardware Output
    #Devices from Output Devices
root@ibbyte:.# alsamixer
    Setting parameters for audio device, nothing to do by me


----------------------------------------------------------
Customize some initialized startup utils 
Suggestion as follows:
----------------------------------------------------------
It seems to not be initialized for profile on ubuntu-18,
so those startup utils will be taken into bashrc.
root@ibbyte:.#
root@ibbyte:.# cd ~ 
root@ibbyte:.# mkdir -pv .bashrc.d 
root@ibbyte:.# cd .bashrc.d 
root@ibbyte:.#
root@ibbyte:.# vim audio_on.sh
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     audio_on.sh
#   Author:       JLLim 
#   Email:        493164984@qq.com
#   DateTime:     2019-02-14 21:43:49
#   ModifiedTime: 2019-02-14 21:44:46

function audio_on()
{
    pulseaudio --start --log-target=syslog
}
export -f audio_on

root@ibbyte:.#
root@ibbyte:.# vim to_anywhere.sh
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     to_anywhere.sh
#   Author:       JLLim 
#   Email:        493164984@qq.com
#   DateTime:     2019-01-11 00:15:03
#   ModifiedTime: 2019-01-22 23:17:37

function to_ws()
{
    cd /rescue/projects 
}
export -f to_ws

function to_L170L_2plus1()
{
    cd /repository/corporation/Reachxm/L170L_2plus1 
}
export -f to_L170L_2plus1


root@ibbyte:.#
root@ibbyte:.#
root@ibbyte:.#


EOF

