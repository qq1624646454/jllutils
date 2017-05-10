
# PhilipsTVUtils.DebugInfo.prepare.sh

function Fn_Get_Udisk()
{
    LvList=$(df | grep -E "^\/storage" | grep -v "emulated" | cut -d' ' -f 1)
    LvTable=""
    LvIdx=0
    for LvL in ${LvList}; do
        if [ x"${LvL#*storage}" = x ]; then
            continue
        fi
        if [ x"${LvTable}" = x ]; then
            LvTable="${LvL}"
            echo "${LvTable}"
        else
            LvTable="${LvTable} ${LvL}"
            echo "${LvTable}"
        fi
        ((LvIdx+=1))
    done
}

echo
echo "### JLL.S$(date +%Y%m%d%H%M%S): Probe the u-disk " 
echo
GvUDiskList=$(Fn_Get_Udisk)
if [ x"${GvUDiskList}" = x ]; then
    echo "### JLL.E$(date +%Y%m%d%H%M%S): Probe the u-disk | failure " 
    echo "JLL: Exit 0 because I can't probe any U-Disk"
    exit 0
fi
for GvL in ${GvUDiskList}; do
    echo "  UDISK=${GvL}"
    echo
done
echo "### JLL.E$(date +%Y%m%d%H%M%S): Probe the u-disk | sucessfully " 
echo

### Please use one
GvIdx=0
for GvL in ${GvUDiskList}; do
    ((GvIdx+=1))
done

if [ ${GvIdx} -ne 1 ]; then
    echo "JLL: Exit 0 because I don't support for more than 1 U-Disk"
    exit 0
fi
GvUDisk=${GvL}

### Avoid upgrade another version
if [ -e "${GvUDisk}/upgrade_loader.pkg" ]; then
    mv -vf ${GvUDisk}/upgrade_loader.pkg  ${GvUDisk}/upgrade_loader.pkg.$(date +%Y_%m_%d__%H_%M_%S)
fi

### Customize properties
echo
echo ">>>>>>>>>>>>>>>>>>>>"
read -p "Enable jll.CallStack if press [y] or Disable it?    " -n 1 -t 10 GvChoice
if [ x"${GvChoice}" = x"y" ]; then
    setprop persist.jll.CallStack.C_CPP 1
    setprop persist.jll.CallStack.JAVA  1
    echo "  Eanble jll.CallStack"
    echo "      setprop persist.jll.CallStack.C_CPP 1"
    echo "      setprop persist.jll.CallStack.JAVA  1"
else
    setprop persist.jll.CallStack.C_CPP 0
    setprop persist.jll.CallStack.JAVA  0
    echo "  Disable jll.CallStack"
    echo "      setprop persist.jll.CallStack.C_CPP 0"
    echo "      setprop persist.jll.CallStack.JAVA  0"
fi

### Clean all under /data/debugdump
rm -rf /data/debugdump/*

### Enable TPVIsionDebug
if [ -e "${GvUDisk}/TPVisionDebug" ]; then
    mv -vf ${GvUDisk}/TPVisionDebug ${GvUDisk}/TPVisionDebug.$(date +%Y_%m_%d__%H_%M_%S)
fi

if [ ! -e "${GvUDisk}/TPVisionDebug.cookie" ]; then
    if [ -e "${GvUDisk}/TPVisionDebug.cookie.jll" ]; then
        cp -rvf ${GvUDisk}/TPVisionDebug.cookie.jll ${GvUDisk}/TPVisionDebug.cookie
    else
        touch  ${GvUDisk}/TPVisionDebug.cookie
    fi
fi

### re-capture the logcat
reboot

