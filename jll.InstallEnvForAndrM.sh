#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

##################################################
#  jielong.lin: Customized Functions 
##################################################

echo
echo "Reference to \"  \\\\172.20.30.11\\Dailybuilds\\buildEnv\MTK\\buildEnv\\AndroidM \""
echo


function FN_Ubuntu_14_04_Installation_SOP_External()
{
    apt-get update

    echo "Do you want to install automatically by default if press [y]"
    echo
    read -p "Your Choice: " LvChoice
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        LvOptionByDefault="-y"
    fi 

    # 1.Install Base
    echo
    echo "========================================================"
    echo "Step1: Install Base if press [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        declare -a LvSourcelist=(
                   "ubuntu-desktop"
                   "autofs"
        )
        declare -i LvSourceCount=${#LvSourcelist[@]}/1 
        for(( LvIdx=0 ; LvIdx<LvSourceCount ; LvIdx++ )) do
            LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
            if [ x"${LvStatus}" = x ]; then
                apt-get install ${LvOptionByDefault} "${LvSourcelist[LvIdx]}"
                LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
                if [ x"${LvStatus}" = x ]; then
                    Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
                    "Installation-Failure: ${LvSourcelist[LvIdx]}"
                    echo
                    echo "Do you continue to installation next if press [y],or Exit"
                    echo
                    read -p "Your Choice: " LvChoice
                    echo
                    if [ x"${LvChoice}" != x"y" ]; then
                        exit 0 
                    fi
                fi
            fi
            Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
            "Installation-Success: ${LvSourcelist[LvIdx]}"
        done
        unset LvSourcelist
        unset LvSourceCount
    fi 
    echo
    echo "Done: Step1"
    echo 


    # 2.Install Google-recommended package
    echo
    echo "========================================================"
    echo "Step2: Install Google-Recommended packages if press [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        declare -a LvSourcelist=(
                   "bison"
                   "g++-multilib"
                   "git"
                   "gperf"
                   "libxml2-utils"
                   "make"
                   "zlib1g-dev:i386"
                   "zip"
                   "python-networkx"
                   "git-core"
                   "gnupg"
                   "flex"
                   "gperf"
                   "build-essential"
                   "curl"
                   "zlib1g-dev"
                   "gcc-multilib"
                   "libc6-dev-i386"
                   "lib32ncurses5-dev"
                   "x11proto-core-dev"
                   "libx11-dev"
                   "lib32z-dev"
                   "ccache"
                   "libgl1-mesa-dev"
                   "xsltproc"
                   "unzip"
        )
        declare -i LvSourceCount=${#LvSourcelist[@]}/1 
        for(( LvIdx=0 ; LvIdx<LvSourceCount ; LvIdx++ )) do
            LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
            if [ x"${LvStatus}" = x ]; then
                apt-get install ${LvOptionByDefault} "${LvSourcelist[LvIdx]}"
                LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
                if [ x"${LvStatus}" = x ]; then
                    Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
                    "Installation-Failure: ${LvSourcelist[LvIdx]}"
                    echo
                    echo "Do you continue to installation next if press [y],or Exit"
                    echo
                    read -p "Your Choice: " LvChoice
                    echo
                    if [ x"${LvChoice}" != x"y" ]; then
                        exit 0 
                    fi
                fi
            fi
            Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
            "Installation-Success: ${LvSourcelist[LvIdx]}"
        done
        unset LvSourcelist
        unset LvSourceCount

    fi
    echo
    echo "Reference to http://source.android.com/source/initializing.html about this step"
    echo
    echo "Done: Step2"
    echo 


    # 3.Install Other Tools 
    echo
    echo "========================================================"
    echo "Step3: Install Other Tools if [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        declare -a LvSourcelist=(
                   "gitg"
                   "git-gui"
                   "lzop"
                   "screen"
                   "indent"
                   "lftp"
                   "lvm2"
                   "cifs-utils"
                   "realpath"
                   "git-email"
                   "enca"
                   "vim"
                   "elinks"
                   "sshfs"
                   "mingw32"
                   "bonnie++"
                   "doxygen"
                   "gzip"
                   "joe"
                   "libncurses5-dev"
                   "libncurses5"
                   "libgmp3-dev"
                   "libmpfr-dev"
                   "libmpc-dev"
                   "libcloog-ppl-dev"
                   "attr"
                   "gawk"
                   "libaio1:amd64"
                   "libhdb9-heimdal:amd64"
                   "libkdc2-heimdal:amd64"
                   "python-dnspython"
                   "tdb-tools"
                   "wbritish"
                   "procmail"
                   "libssl-dev"
                   "dos2unix"
        )
        declare -i LvSourceCount=${#LvSourcelist[@]}/1 
        for(( LvIdx=0 ; LvIdx<LvSourceCount ; LvIdx++ )) do
            LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
            if [ x"${LvStatus}" = x ]; then
                apt-get install ${LvOptionByDefault} "${LvSourcelist[LvIdx]}"
                LvStatus=$(dpkg --get-selections | grep -i "${LvSourcelist[LvIdx]}")
                if [ x"${LvStatus}" = x ]; then
                    Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
                    "Installation-Failure: ${LvSourcelist[LvIdx]}"
                    echo
                    echo "Do you continue to installation next if press [y],or Exit"
                    echo
                    read -p "Your Choice: " LvChoice
                    echo
                    if [ x"${LvChoice}" != x"y" ]; then
                        exit 0 
                    fi
                fi
            fi
            Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
            "Installation-Success: ${LvSourcelist[LvIdx]}"
        done
        unset LvSourcelist
        unset LvSourceCount
    fi
    echo
    echo "Done: Step3"
    echo


    # 4.Linker Libraries or Environment 
    echo
    echo "========================================================"
    echo "Step4: Linker libraries or Environment if press [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
#         if [ -e "/usr/lib/x86_64-linux-gnu" \
#              -a -e "/lib/i386-linux-gnu/libncurses.so.5" \
#              -a -e "/lib/x86_64-linux-gnu/libncurses.so.5" \
#              -a -e "/lib/x86_64-linux-gnu/libz.so.1" \
#              -a -e "/bin/bash" ]; then
            ln -s  /usr/lib/x86_64-linux-gnu/crt*.o      /usr/lib
            ln -sf /lib/i386-linux-gnu/libncurses.so.5   /usr/lib32/libncurses.so
            ln -sf /lib/x86_64-linux-gnu/libncurses.so.5 /usr/lib/libncurses.so
            ln -s  /lib/x86_64-linux-gnu/libz.so.1       /usr/lib/libz.so
            ln -sfn /bin/bash /bin/sh
#        else
#            Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgRed} "Error-Exit: Can't setup Linker libraries"
#            Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgRed} \
#            "Reference to http://source.android.com/source/initializing.html about this step"
#            exit 0
#        fi
    fi
    echo
    echo "Done: Step4"
    echo


    echo
    echo "Done: All"
    echo
}

function FN_Mediatek_CrossCompilationToolchain()
{
    LvResPath="/repository/tpv/mediatek/AndrM"
    if [ ! -e "${LvResPath}/mtkeda.tar" ]; then
        Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
        "Failure: \"${LvResPath}/mtkeda.tar\" donot exist"
        while [ 1 -eq 1 ]; do
            echo ""
            echo "Please  specify the location where the \"mtkeda.tar\" is stored"
            echo ""
            read -p "ResourcePath=" LvResPath
            echo ""
            if [ -e "${LvResPath}/mtkeda.tar" ]; then
                break;
            fi
        done
    fi
    if [ ! -e "${LvResPath}/mtkoss.tar" ]; then
        Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
        "Failure: \"${LvResPath}/mtkoss.tar\" donot exist"
        while [ 1 -eq 1 ]; do
            echo ""
            echo "Please  specify the location where the \"mtkoss.tar\" is stored"
            echo ""
            read -p "ResourcePath=" LvResPath
            echo ""
            if [ -e "${LvResPath}/mtkoss.tar" ]; then
                break;
            fi
        done
    fi
    mkdir -pv /home/tempInstall
    cd $_
    tar -vxf ${LvResPath}/mtkeda.tar -C /
    tar -vxf ${LvResPath}/mtkoss.tar -C /
 
    LvStatus=$(dpkg --get-selections | grep -i "tree")
    if [ x"${LvStatus}" = x ]; then
        apt-get install "tree"
        LvStatus=$(dpkg --get-selections | grep -i "tree")
        if [ x"${LvStatus}" = x ]; then
            Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
            "Warning: Cannot find tree package for installation"
        else
            tree /mtkoss -L 4 -lh
        fi
    else
        tree /mtkoss -L 4 -lh
    fi

    # JDK
    echo
    echo "========================================================"
    echo " Configurate the Environment if [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then

        Lfn_File_GetMatchLine LvFileLines "JAVA_HOME" "/etc/profile"
        if [ x"${LvFileLines}" = x ]; then
            if [ ! -e "/etc/profile.original" ]; then
                cp -rvf /etc/profile /etc/profile.original 
            fi
cat >>/etc/profile << EOF
# JDK environment variables such as JAVA_HOME - jielong.lin @ 2016-2-2 
       # export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
       # export JRE_HOME=\${JAVA_HOME}/jre
       # export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib
        export PATH=/mtkeda/dtv/tools/make-3.82:\$PATH
        export PATH=/mtkoss/openjdk/1.7.0_55-ubuntu-12.04/x86_64/bin:\$PATH
EOF
        fi
    fi
    echo
    Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgSeaBule} \
    "Done: JDK Environment Variables have already been registed to /etc/profile, as follows: "
    sed -n '/JAVA_HOME/'p  /etc/profile   # Print the lines matched with JAVA_HOME
    echo
    echo "Done: JDK Environment"
    echo
 
}


echo "Run Install SOP External in Ubuntu 14.04 if press [y]"
read -n 1 -p "[Your Choice]" GvYourChoice
if [ x"${GvYourChoice}" = x"y" ]; then
    FN_Ubuntu_14_04_Installation_SOP_External
fi

echo "Run Install Mediatek Cross COmpilation Toolchain in Ubuntu 12.04 if press [y]"
read -n 1 -p "[Your Choice]" GvYourChoice
if [ x"${GvYourChoice}" = x"y" ]; then
    FN_Mediatek_CrossCompilationToolchain 
fi




