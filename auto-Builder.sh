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

JLLCONF_source=/vita/source
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
        read -n 1 __Choice_
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
      read -n 1 -p "* JLL: installing binutils if press [y]?  "  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    [ x"$(ls ${JLLCONF_build}/binutils-2.23.1 2>/dev/null)" != x ] \
        && rm -rvf ${JLLCONF_build}/binutils-2.23.1
    [ x"$(ls ${JLLCONF_build}/binutils-build 2>/dev/null)" != x ] \
        && rm -rvf ${JLLCONF_build}/binutils-build
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
  echo  "JLL: exit due to Failure - not found ${CROSS_TOOL}/bin/i686-none-linux-gnu-as"
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
      read -n 1 -p "* JLL: installing gcc if press [y]?  "  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    [ x"$(ls ${JLLCONF_build}/gcc-4.7.2 2>/dev/null)" != x ] \
        && rm -rvf ${JLLCONF_build}/gcc-4.7.2
    [ x"$(ls ${JLLCONF_build}/gcc-build 2>/dev/null)" != x ] \
        && rm -rvf ${JLLCONF_build}/gcc-build
 
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
    if [ ! -e "$CROSS_GCC_TMP/lib/gcc/i686-none-linux-gnu/4.7.2/libgcc.a" ]; then
        echo
        echo "JLL: exit because not found $CROSS_GCC_TMP/lib/gcc/i686-none-linux-gnu/4.7.2/libgcc.a" 
        echo
        exit 0
    fi
    if [ ! -e "$CROSS_GCC_TMP/lib/gcc/i686-none-linux-gnu/4.7.2/libgcc_eh.a" ]; then
        ln -s libgcc.a $CROSS_GCC_TMP/lib/gcc/i686-none-linux-gnu/4.7.2/libgcc_eh.a
    fi
  fi
fi

if [ ! -e "$CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc" ]; then
  echo
  echo  "JLL: exit due to Failure - not found $CROSS_GCC_TMP/bin/i686-none-linux-gnu-gcc"
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
      read -n 1 -p "* JLL: installing kernel headers if press [y]?  "  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    [ x"$(ls ${JLLCONF_build}/linux-3.7.4 2>/dev/null)" != x ] \
        && rm -rvf ${JLLCONF_build}/linux-3.7.4

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
  echo  "JLL: exit due to Failure - not found $SYSROOT/usr/include"
  echo
  exit 0
fi







if [ x"$(dpkg --get-selections | grep gawk)" = x ]; then
    sudo apt-get install -y gawk
fi

more >&1<<EOF

**********
********** ${AC}${Fred} glibc is made by freestanding c compiler ${AC}
**********
*
* JLL: Checking if ${AC}${Fyellow}${SYSROOT}/lib${AC} is present
*
EOF

if [ x"$(ls ${SYSROOT}/lib 2>/dev/null)" = x ]; then
  if [ x"${__Choice}" != x"y" ]; then
    read -n 1 -p "* JLL: installing glic is made by freestanding c compiler if press [y]?  "  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    [ x"$(ls ${JLLCONF_build}/glibc-2.15 2>/dev/null)" != x ] && rm -rvf ${JLLCONF_build}/glibc-2.15
    [ x"$(ls ${JLLCONF_build}/glibc-build 2>/dev/null)" != x ] && rm -rvf ${JLLCONF_build}/glibc-build

    cd /vita/build
    tar xvf ../source/glibc-2.15.tar.xz
    cd glibc-2.15
    if [ x"$(ls ${JLLCONF_source}/glibc-2.15-cpuid.patch 2>/dev/null)" != x ]; then
        patch -p1 < ${JLLCONF_source}/glibc-2.15-cpuid.patch
    fi
    if [ x"$(ls ${JLLCONF_source}/glibc-2.15-s_frexp.patch 2>/dev/null)" != x ]; then
        patch -p1 < ${JLLCONF_source}/glibc-2.15-s_frexp.patch
    fi
    cd - >/dev/null
    mkdir -pv glibc-build
    cd glibc-build
    ../glibc-2.15/configure \
        --prefix=/usr \
        --host=$TARGET \
        --enable-kernel=3.7.4 \
        --enable-add-ons \
        --with-headers=$SYSROOT/usr/include \
        libc_cv_forced_unwind=yes \
        libc_cv_c_cleanup=yes \
        libc_cv_ctors_header=yes
    make
    make install_root=$SYSROOT install
  fi
fi

if [ x"$(ls ${SYSROOT}/lib 2>/dev/null)" = x ]; then
  echo
  echo  "JLL: exit due to Failure - not found $SYSROOT/lib"
  echo
  exit 0
fi





more >&1<<EOF

**********
********** ${AC}${Fred} Now Building complete cross-compiler ${AC}
**********
*
* JLL: Checking if ${AC}${Fyellow}${CROSS_TOOL}/bin/i686-none-linux-gnu-gcc${AC} is present
*
EOF

if [ x"$(ls ${CROSS_TOOL}/bin/i686-none-linux-gnu-gcc 2>/dev/null)" = x ]; then
  if [ x"${__Choice}" != x"y" ]; then
      read -n 1 -p "* JLL: installing complete cross-compiler if press [y]?  "  __Choice_
  fi
  if [ x"${__Choice}" = x"y" -o x"${__Choice_}" = x"y" ]; then
    [ x"$(ls ${JLLCONF_build}/gcc-build 2>/dev/null)" != x ] && rm -rvf ${JLLCONF_build}/gcc-build
    [ ! -e "${JLLCONF_build}/gcc-build" ] && mkdir -pv ${JLLCONF_build}/gcc-build

    cd ${JLLCONF_build}/gcc-build
    ../gcc-4.7.2/configure \
        --prefix=$CROSS_TOOL \
        --target=$TARGET  \
        --with-sysroot=$SYSROOT \
        --with-mpfr-include=$JLLCONF_build/gcc-4.7.2/mpfr/src \
        --with-mpfr-lib=$JLLCONF_build/gcc-build/mpfr/src/.libs \
        --enable-languages=c,c++ \
        --enable-threads=posix
 
    make
    make install
  fi
fi 

if [ x"$(ls ${CROSS_TOOL}/bin/i686-none-linux-gnu-gcc 2>/dev/null)" = x ]; then
  echo
  echo  "JLL: exit due to Failure - not found $CROSS_TOOL/bin/i686-none-linux-gnu-gcc"
  echo
  exit 0
fi

