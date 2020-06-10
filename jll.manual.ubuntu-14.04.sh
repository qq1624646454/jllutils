#!/bin/bash
# Copyright(c) 2016-2100.  root.  All rights reserved.
#
#   FileName:     jll.manual.ubuntu-14.04.sh
#   Author:       root
#   Email:        493164984@qq.com
#   DateTime:     2020-06-11 00:16:15
#   ModifiedTime: 2020-06-11 00:56:13

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"


more >&1<<EOF

${Fred} How to download Ubuntu 14.04 ${AC}
Open link to https://www.ubuntu.com/download/alternative-downloads
Download BitTorrent and Open BitTorrent to Download Ubuntu image is very fast
I recommend that it is performed by firefox on ubuntu 14.04



${Fseablue} network tool such as ifconfig ${AC}
apt-get install net-tools -y


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

${Bred}${Fyellow}for Ubuntu (default by using lightdm)${AC}
lightdm.conf can be created if it not exist

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


${Fwhite}${Bgreen}  update apt-source ${AC}
JLLim@S.#
JLLim@S.# mv /etc/apt/sources.list /etc/apt/sources.list.orig
JLLim@S.#
JLLim@S.# apt-get clean 
clean /var/cache/apt/archives/
 
JLLim@S.#
JLLim@S.# vi /etc/apt/sources.list 
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse

JLLim@S.#
JLLim@S.# apt-get update
JLLim@S.#
JLLim@S.# apt-get install -y aptitude
JLLim@S.#



${Fwhite}${Bgreen} Install development for mdm9x07 ${AC}
apt-get update

apt-get install -y openjdk-7-jdk \\
                   gnupg \\
                   flex \\
                   bison \\
                   gperf \\
                   build-essential \\
                   zip \\
                   curl \\
                   zlib1g-dev \\
                   gcc-multilib \\
                   g++-multilib \\
                   libc6-dev-i386 \\
                   lib32ncurses5-dev \\
                   x11proto-core-dev \\
                   libx11-dev \\
                   lib32z1-dev \\
                   ccache \\
                   libgl1-mesa-dev \\
                   libxml2-utils \\
                   xsltproc \\
                   chrpath \\
                   coreutils \\
                   cvs \\
                   diffstat \\
                   docbook-utils \\
                   fakeroot \\
                   g++ \\
                   gawk \\
                   gcc \\
                   git \\
                   git-core \\
                   help2man \\
                   libgmp3-dev \\
                   libmpfr-dev \\
                   libreadline6-dev \\
                   libtool \\
                   libxml2-dev \\
                   make \\
                   python-pip \\
                   python-pysqlite2 \\
                   quilt \\
                   sed \\
                   subversion \\
                   texi2html \\
                   texinfo \\
                   unzip \\
                   wget \\
                   openssh-client \\
                   openssh-server

 git config --global push.default matching 
 git config --global push.default simple 
 git config --global user.name "Jielong Lin"


${Fred} Can't signing in by root ${AC}
Please change "PermitRootLogin without-password" to "PermitRootLogin yes"
in /etc/ssh/sshd_config or /etc/ssh/ssh_config


${Fred}---------------------------------${AC}
${Fred} python3.6 for ubuntu-14.04 :    ${AC}
${Fred}---------------------------------${AC}

apt-get install -y libbz2-dev libgdbm-dev liblzma-dev libsqlite3-dev libreadline-dev libssl-dev tk-dev
./configure --with-ssl
make
make install

update-alternatives --install /usr/bin/python python /usr/local/bin/python3.6 1
update-alternatives --install /usr/bin/python python /usr/bin/python3.4 2
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 3
update-alternatives --config python
python --version

update-alternatives --install /usr/bin/pip pip /usr/bin/pip2 2
update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.6 1
update-alternatives --config pip
pip --version

lsb_release -a


EOF



