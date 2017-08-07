#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.manual.pythod.sh
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2017-08-07 11:02:26
#   ModifiedTime: 2017-08-07 11:25:26

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

more >&1<<EOF

${Bgreen}                                                                  ${AC}
${Bgreen} ${AC} For install pip3
${Bgreen}                                                                  ${AC}

jll@S:~# ${Fseablue}cd /usr/local/src${AC}
${Fpink}#Pythod version to be selected to 3.3.6${AC}
jll@S:/usr/local/src# ${Fseablue}\
wget https://www.python.org/ftp/python/3.3.6/Python-3.3.6.tar.xz${AC}
...
jll@S:/usr/local/src# ${Fseablue}xz -d Python-3.3.6.tar.xz${AC}
jll@S:/usr/local/src# ${Fseablue}tar xvf Python-3.3.6.tar.xz${AC}
jll@S:/usr/local/src# ${Fseablue}cd Python-3.3.6/${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}mkdir -pv /usr/local/python3${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}chmod 0777 /usr/local/python3${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}./configure --prefix=/usr/local/pytho3${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}make${AC}
...
${Fred}Python build finished, but the necessary bits to build these modules were not found:${AC}
${Fred}_bz2               _dbm               _gdbm${AC}
${Fred}_lzma              _sqlite3           _tkinter${AC}
${Fred}readline${AC}
${Fred}To find the necessary bits, look in setup.py in detect_modules() for the module's name.${AC}
${Fpink}Please install those lack modules ${AC}
...
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}aptitude install libbz2-dev ${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}aptitude install libgdbm-dev ${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}aptitude install liblzma-dev python-lzma ${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}aptitude install libsqlite3-dev ${AC}
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}aptitude install libreadline-dev ${AC}
...
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}make${AC} #re-compile it by make
jll@S:/usr/local/src/Python-3.3.6# ${Fseablue}make install${AC}
...
jll@S:/usr/local/python3/bin# ${Fseablue}pip3 --version${AC}
Traceback (most recent call last):
  File "/usr/local/bin/pip3", line 5, in <module>
    from pkg_resources import load_entry_point
ImportError: No module named 'pkg_resources'



EOF

