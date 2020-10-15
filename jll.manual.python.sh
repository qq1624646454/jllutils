#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.python.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-07 11:02:26
#   ModifiedTime: 2020-06-11 01:03:33

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF


---------------------------------
for ubuntu-14.04 :
---------------------------------

aptitude install -y libbz2-dev libgdbm-dev liblzma-dev libsqlite3-dev libreadline-dev libssl-dev tk-dev
#./configure --prefix=/usr/local/python3
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




#ls /usr/bin/python3 -al
#rm -rvf /usr/bin/python3
#ln -sv /usr/local/python3/bin/python3 /usr/bin/python3
#ln -sv /usr/local/python3/bin/pip3 /usr/bin/pip3
#python3 --version
#pip3 --version


















${Bgreen}                                                                  ${AC}
${Bgreen} ${AC} For install pip3
${Bgreen}                                                                  ${AC}

root@S:~# ${Fseablue}cd /usr/local/src${AC}
${Fpink}#Pythod version to be selected to 3.6.2 with pip3 setuptools${AC}
root@S:/usr/local/src# \
${Fseablue}wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tgz${AC}
...
root@S:/usr/local/src# 
${Fseablue}tar zxvf Python-3.6.2.tgz${AC}
${Fseablue}cd Python-3.6.2${AC}
${Fseablue}mkdir -pv /usr/local/python3${AC}
${Fseablue}chmod 0777 /usr/local/python3${AC}
${Fseablue}./configure --prefix=/usr/local/python3${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}make${AC}
...
${Fred}Python build finished, but the necessary bits to build these modules were not found:${AC}
${Fred}_bz2               _dbm               _gdbm${AC}
${Fred}_lzma              _sqlite3           _tkinter${AC}
${Fred}readline           _ssl${AC}
${Fred}To find the necessary bits, look in setup.py in detect_modules() for the module's name.${AC}
${Fpink}Please install those lack modules ${AC}
...
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install libbz2-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install libgdbm-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install liblzma-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install libsqlite3-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install libreadline-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install libssl-dev ${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}aptitude install tk-dev ${AC}
...
root@S:/usr/local/src/Python-3.6.2#
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}make${Fpink} #re-compile it by make${AC}
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}make install${AC}
...
${Fred}Collecting setuptools${AC}
${Fred}Collecting pip${AC}
${Fred}Installing collected packages: setuptools, pip${AC}
${Fred}Successfully installed pip-9.0.1 setuptools-28.8.0${AC}
root@S:/usr/local/src/Python-3.6.2#
root@S:/usr/local/src/Python-3.6.2# \
${Fseablue}ln -sv /usr/local/python3/bin/python3 /usr/bin/python3${AC}
'/usr/bin/python3' -> '/usr/local/python3/bin/python3'
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}ln -sv /usr/local/python3/bin/pip3 /usr/bin/pip3${AC}
'/usr/bin/pip3' -> '/usr/local/python3/bin/pip3'
root@S:/usr/local/src/Python-3.6.2#
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}pip3 --version${AC}
pip 9.0.1 from /usr/local/python3/lib/python3.6/site-packages (python 3.6)
root@S:/usr/local/src/Python-3.6.2# ${Fseablue}python3 --version${AC}
Python 3.6.2

在python（>=3.4）版本开始，pip和setuptools默认会安装的，
如果在安装过程中python的安装环境不正确，可能就会导致pip和setuptools安装失败。
例如在make的时候会输出丢失的模块。





subprocess.CalledProcessError: Command 'lsb_release -a' returned non-zero exit status 1.
cp -rvf /usr/lib/python3/dist-packages/lsb_release.py  /usr/local/python3/lib/python3.6/ 










root@S:/usr/local/src/Python-3.6.2# ${Fseablue}vi /usr/bin/lsb_release${AC}
#! /usr/bin/python3.4m -Es

pip3 install --upgrade pip

${Fpink}在python（>=3.4）版本开始，pip和setuptools默认会安装的，${AC}
${Fpink}如果在安装过程中python的安装环境不正确，可能就会导致pip和setuptools安装失败。${AC}
${Fpink}例如在make的时候会输出丢失的模块。${AC}



#
# for python3.7
#
# issue: ModuleNotFoundError: No module named ‘_ctypes’
apt-get install libffi-dev

EOF

