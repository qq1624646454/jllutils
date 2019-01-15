#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

##################################################
#  jielong.lin: Customized Functions 
##################################################


GvResourcePath="/repository/tpv/mediatek/AndrL"

declare -a GvResourceList=(
    "gnu-toolchain_4.8.2_2.6.35_cortex-a9-vfp.tar.gz"
    "gnu-toolchain_4.8.2_2.6.35_cortex-a9-neon.tar.gz"
)
declare -i GvNrResourceList=${#GvResourceList[@]}/1

function Fn_Resources_CheckIfVaild()
{
    for(( LvIdx=0 ; LvIdx<GvNrResourceList ; LvIdx++ )) do
        echo
        echo "Checking for ${GvResourceList[LvIdx]}"
        if [ ! -e "${GvResourcePath}/${GvResourceList[LvIdx]}" ]; then
            Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
                "Failure: Do not exist \" ${GvResourcePath}/${GvResourceList[LvIdx]}\""
            echo
            exit 0 
        fi
    done
    echo
    Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
        "Success: check all resources"
    echo
}
Fn_Resources_CheckIfVaild



echo
echo "Reference to \"  \\\\172.20.30.11\\Dailybuilds\\buildEnv\MTK\\buildEnv\\AndroidM \""
echo

function FN_Ubuntu_12_04_Installation_SOP_External()
{
    apt-get update

    echo "Do you want to install automatically by default if press [y]"
    echo
    read -p "Your Choice: " LvChoice
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        LvOptionByDefault="-y"
    fi 

    declare -a LvSourcelist=(
        "libgl1-mesa-dri:i386"
        "libglapi-mesa:i386"
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
 

    # 1.Install Google-recommended package
    echo
    echo "========================================================"
    echo "Step1: Install Google-Recommended packages if press [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        declare -a LvSourcelist=(
            "git"
            "gnupg"
            "flex"
            "bison"
            "gperf"
            "build-essential"
            "zip"
            "curl"
            "libc6-dev"
            "libncurses5-dev:i386"
            "x11proto-core-dev"
            "libx11-dev:i386"
            "libreadline6-dev:i386"
            "libgl1-mesa-glx:i386"
            "g++-multilib"
            "mingw32"
            "tofrodos"
            "libgl1-mesa-dev"
            "python-markdown"
            "libxml2-utils"
            "xsltproc"
            "zlib1g-dev:i386"
            "procmail"
            "unzip"
            "zip"
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

        if [ -e "/usr/lib/i386-linux-gnu/mesa/libGL.so.1" \
             -a ! -e "/usr/lib/i386-linux-gnu/libGL.so" ]; then 
            ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
        else
            if [ ! -e "/usr/lib/i386-linux-gnu/mesa/libGL.so.1" ]; then 
                Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgRed} \
                "Error-Exit: Can't create Linker from /usr/lib/i386-linux-gnu/mesa/libGL.so.1"
                Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgRed} \
                "Reference to http://source.android.com/source/initializing.html about this step"
                exit 0
            fi
        fi
    fi
    echo
    echo "Reference to http://source.android.com/source/initializing.html about this step"
    echo
    echo "Done: Step1"
    echo 

    # 2.Install JDK
    echo
    echo "========================================================"
    echo "Step2: Install JDK if [y]?"
    echo
    read -p "Your Choice: " LvChoice
    echo "========================================================"
    echo
    if [ x"${LvChoice}" = x"y" ]; then
        declare -a LvSourcelist=(
            "openjdk-7-jdk"
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

        Lfn_File_GetMatchLine LvFileLines "JAVA_HOME" "/etc/profile"
        if [ x"${LvFileLines}" = x ]; then
            if [ ! -e "/etc/profile.original" ]; then
                cp -rvf /etc/profile /etc/profile.original 
            fi
cat >>/etc/profile << EOF
# JDK environment variables such as JAVA_HOME - jielong.lin @ 2016-2-2 
        export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
        export JRE_HOME=\${JAVA_HOME}/jre
        export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib
        export PATH=\${JAVA_HOME}/bin:\$PATH
EOF
        fi
    fi
    echo
    Lfn_Sys_DbgColorEcho ${CvBgBlack}  ${CvFgSeaBule} \
    "Done: JDK Environment Variables have already been registed to /etc/profile, as follows: "
    sed -n '/JAVA_HOME/'p  /etc/profile   # Print the lines matched with AVA_HOME
    echo
    echo "Done: Step2"
    echo

    # 3.Install JDK
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
            "zlib1g-dev"
            "screen"
            "indent"
            "lftp"
            "lvm2"
            "smbfs"
            "realpath"
            "enca"
            "git-email"
            "ant"
            "enca"
            "elinks"
            "gawk"
            "ia32-libs-multiarch"
            "ia32-libs"
            "gconf-2.0"
            "dos2unix"
            "lockfile"
            #"vim"
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

    echo
    echo "Done: All"
    echo
}




function FN_Mediatek_CrossCompilationToolchain()
{
    LvResPath="${GvResourcePath}"
    if [ ! -e "${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-vfp.tar.gz" ]; then
        Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
        "Error-Exit: \"${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-vfp.tar.gz\" donot exist"
        exit 0
    fi
    if [ ! -e "${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-neon.tar.gz" ]; then
        Lfn_Sys_DbgColorEcho ${CvFgRed} ${CvBgBlack} \
        "Error-Exit: \"${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-neon.tar.gz\" donot exist"
        exit 0
    fi
    mkdir -pv /home/tempInstall
    cd $_
    tar -zvxf ${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-vfp.tar.gz -C ./
    mkdir -pv /mtkoss/gnuarm/vfp_4.8.2_2.6.35_cortex-a9-ubuntu/x86_64
    mv * $_
    tar -zvxf ${LvResPath}/gnu-toolchain_4.8.2_2.6.35_cortex-a9-neon.tar.gz -C ./
    mkdir -pv /mtkoss/gnuarm/neon_4.8.2_2.6.35_cortex-a9-ubuntu/x86_64
    mv * $_
    cd /mtkoss
    rm -rvf /home/tempInstall
 
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
}

echo "Run Install SOP External in Ubuntu 12.04 if press [y]"
read -n 1 -p "[Your Choice]" GvYourChoice
if [ x"${GvYourChoice}" = x"y" ]; then
    FN_Ubuntu_12_04_Installation_SOP_External
fi

echo "Run Install Mediatek Cross COmpilation Toolchain in Ubuntu 12.04 if press [y]"
read -n 1 -p "[Your Choice]" GvYourChoice
if [ x"${GvYourChoice}" = x"y" ]; then
    FN_Mediatek_CrossCompilationToolchain 
fi



