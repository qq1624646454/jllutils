#!/bin/bash

# Adapt to more/echo/less and so on
  ESC=
  AC=${ESC}[0m
  Fblack=${ESC}[30m
  Fred=${ESC}[31m
  Fgreen=${ESC}[32m
  Fyellow=${ESC}[33m
  Fblue=${ESC}[34m
  Fpink=${ESC}[35m
  Fseablue=${ESC}[36m
  Fwhite=${ESC}[37m
  Bblack=${ESC}[40m
  Bred=${ESC}[41m
  Bgreen=${ESC}[42m
  Byellow=${ESC}[43m
  Bblue=${ESC}[44m
  Bpink=${ESC}[45m
  Bseablue=${ESC}[46m
  Bwhite=${ESC}[47m

JLLCONF_build=/vita/build
JLLCONF_cross_tool=/vita/cross-tool
JLLCONF_cross_gcc_tmp=/vita/cross-gcc-tmp
JLLCONF_sysroot=/vita/sysroot

more >&1<<EOF
*
* Version - R20170516.V001
*
* ${AC}${Fred} Automatically perform all actions if press [y] ${AC}
*
EOF
read -n 1 __Choice





more >&1<<EOF

**********
********** ${AC}${Fred} Prepare ${AC}
**********
*
EOF
[ x"$(ls ${JLLCONF_build} 2>/dev/null)" = x ] \
    && __JLLCONF_build=0 || __JLLCONF_build=1;
[ x"$(ls ${JLLCONF_cross_tool} 2>/dev/null)" = x ] \
    && __JLLCONF_cross_tool=0 || __JLLCONF_cross_tool=1;
[ x"$(ls ${JLLCONF_cross_gcc_tmp} 2>/dev/null)" = x ] \
    && __JLLCONF_cross_gcc_tmp=0 || __JLLCONF_cross_gcc_tmp=1;
[ x"$(ls ${JLLCONF_sysroot} 2>/dev/null)" = x ] \
    && __JLLCONF_sysroot=0 || __JLLCONF_sysroot=1;

if [ ${__JLLCONF_build} -eq 1 \
  -o ${__JLLCONF_cross_tool} -eq 1 \
  -o ${__JLLCONF_cross_gcc_tmp} -eq 1 \
  -o ${__JLLCONF_sysroot} -eq 1 ]; then
more >&1<<EOF
*
* ${AC}${Fseablue}${JLLCONF_build}${AC}
* ${AC}${Fseablue}${JLLCONF_cross_tool}${AC}
* ${AC}${Fseablue}${JLLCONF_cross_gcc_tmp}${AC}
* ${AC}${Fseablue}${JLLCONF_sysroot}${AC}
EOF
    if [ x"${__Choice}" != x"y" ]; then
        echo "* JLL: rebuild the above if press [y], or skip ?"
        read __Choice_
    fi
    if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
        rm -rvf ${JLLCONF_build}
        rm -rvf ${JLLCONF_cross_tool}
        rm -rvf ${JLLCONF_cross_gcc_tmp}
        rm -rvf ${JLLCONF_sysroot}
    fi
else
echo "*"
fi 

[ ! -e "${JLLCONF_build}" ] && mkdir -pv ${JLLCONF_build}
[ ! -e "${JLLCONF_cross_tool}" ] && mkdir -pv ${JLLCONF_cross_tool}
[ ! -e "${JLLCONF_cross_gcc_tmp}" ] && mkdir -pv ${JLLCONF_cross_gcc_tmp}
[ ! -e "${JLLCONF_sysroot}" ] && mkdir -pv ${JLLCONF_sysroot}






more >&1<<EOF

**********
********** ${AC}${Fred} binutils ${AC}
**********
*
* JLL: Checking if ${AC}${Fyellow}${CROSS_TOOL}/bin/i686-none-linux-gnu-as${AC} is present
*
EOF

if [ ! -e "${CROSS_TOOL}/bin/i686-none-linux-gnu-as" ]; then
  if [ x"${__Choice}" != x"y" ]; then
      read -p "* JLL: installing binutils"  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    cd /vita/build
    tar xvf ../source/binutils-2.23.1.tar.bz2
    mkdir -pv binutils-build
    cd binutils-build/
    ../binutils-2.23.1/configure --prefix=$CROSS_TOOL --target=$TARGET --with-sysroot=$SYSROOT
    make
    make install
  fi
fi

if [ ! -e "${CROSS_TOOL}/bin/i686-none-linux-gnu-as" ]; then
  echo
  echo  "JLL: exit due to Failure - ${CROSS_TOOL}/bin/i686-none-linux-gnu-as"
  echo
  exit 0
fi








more >&1<<EOF

**********
********** ${AC}${Fred} gcc ${AC}
**********
*
* JLL: Checking if ${AC}${Fyellow}$CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc${AC} is present
*
EOF

if [ ! -e "$CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc" ]; then
  if [ x"${__Choice}" != x"y" ]; then
      read -p "* JLL: installing gcc"  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    cd /vita/build
    tar xvf ../source/gcc-4.7.2.tar.bz2
    cd gcc-4.7.2/
    tar xvf ../../source/gmp-5.0.5.tar.bz2
    mv gmp-5.0.5/ gmp
    tar xvf ../../source/mpfr-3.1.1.tar.bz2
    mv mpfr-3.1.1/ mpfr
    tar xvf ../../source/mpc-1.0.1.tar.gz
    mv mpc-1.0.1/ mpc
    cd /vita/build
    mkdir -pv gcc-build
    cd gcc-build/
    ../gcc-4.7.2/configure --prefix=$CROSS_GCC_TMP --target=$TARGET --with-sysroot=$SYSROOT --with-newlib --enable-languages=c --with-mpfr-include=/vita/build/gcc-4.7.2/mpfr/src --with-mpfr-lib=/vita/build/gcc-build/mpfr/src/.libs --disable-shared --disable-threads --disable-decimal-float --disable-libquadmath --disable-libmudflap --disable-libgomp --disable-nls --disable-libssp
    make
    make install
  fi
fi

if [ ! -e "$CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc" ]; then
  echo
  echo  "JLL: exit due to Failure - $CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc"
  echo
  exit 0
fi








more >&1<<EOF

**********
********** ${AC}${Fred} kernel headers ${AC}
**********
*
* JLL: Checking if ${AC}${Fyellow}$SYSROOT/usr/include${AC} is present
*
EOF

if [ ! -e "$SYSROOT/usr/include" ]; then
  if [ x"${__Choice}" != x"y" ]; then
      read -p "* JLL: installing kernel headers"  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    cd /vita/build
    tar xvf ../source/linux-3.7.4.tar.xz
    cd linux-3.7.4/
    make mrproper
    make ARCH=i386 headers_check
    make ARCH=i386 INSTALL_HDR_PATH=$SYSROOT/usr/ headers_install
  fi
fi

if [ ! -e "$SYSROOT/usr/include" ]; then
  echo
  echo  "JLL: exit due to Failure - $SYSROOT/usr/include"
  echo
  exit 0
fi




