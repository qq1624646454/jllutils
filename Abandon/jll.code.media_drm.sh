#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

GvDate=$(date +%Y%m%d)

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

function Lfn_Sys_GetEachUpperLevelPath()
{
    if [ -z "$1" ]; then
        echo "Error and Exit | Lfn_Sys_GetEachUpperLevelPath() - usage is incorrect "
        exit 0
    fi

    LvGadoulPaths=""
    LvGadoulPath=`pwd`
    while [ x"${LvGadoulPath}" != x -a x"${LvGadoulPath}" != x"/" ]; do
        if [ -z "${LvGadoulPaths}" ]; then
            LvGadoulPaths="${LvGadoulPath}"
        else
            LvGadoulPaths="${LvGadoulPaths}:${LvGadoulPath}"
        fi

        #LvGadoulBasename=`basename "${LvGadoulPath}"`
        #LvGadoulPath=`echo "${LvGadoulPath}" | sed "s/\/${LvGadoulBasename}//"`
        LvGadoulPath=`cd ${LvGadoulPath}/..;pwd`
    done

    LvGadoulPaths=`echo "${LvGadoulPaths}" | sed "s/\ /\\\\\ /g"`
    if [ -z "${LvGadoulPaths}" ]; then
        echo "Fail to find the required PATH and Exit"
        exit 0
    fi

    eval $1="${LvGadoulPaths}"
}




function Lfn_Sys_GetSameLevelPath()
{
    if [ $# -ne 2 -o -z "$2" ]; then
        echo "Error and Exit | Lfn_Sys_GetSameLevelPath() - usage is incorrect "
        exit 0
    fi

    LvSgslpKeywords="$2"
    eval $1=""

    # visit every location from the tails of the current path
    Lfn_Sys_GetEachUpperLevelPath LvSgslpPaths
    OldIFS=$IFS
    IFS=:
    for LvSgslpPath in ${LvSgslpPaths}; do
        IFS=$OldIFS
        echo
        echo "Matching:\"${LvSgslpKey}\""
        echo "  ├──SearchPath= \"${LvSgslpPath}\""
        for LvSgslpKey in ${LvSgslpKeywords}; do
            LvSgslpEntrys="$(ls -a ${LvSgslpPath})"
            for LvSgslpEntry in ${LvSgslpEntrys}; do
                if [ x"${LvSgslpEntry}" = x"${LvSgslpKey}" ]; then
        echo "  │  ├──Matching= \"${LvSgslpEntry}\" (Hit)"
                    LvSgslpPath=`echo "${LvSgslpPath}" | sed "s/\ /\\\\\ /g"`
                    eval $1="${LvSgslpPath}"
                    IFS=$OldIFS
        echo
        echo "Done-Success: \"${LvSgslpPath}\""
                    echo
                    return 0
                fi
        echo "  │  ├──Matching= \"${LvSgslpEntry}\""
            done
        done
        IFS=:
    done
    IFS=$OldIFS
    echo
    echo "Done-Failure: FinalPath=\"${LvSgslpPath}\""
    echo
    return 0
}





#
# Find the same level path which contains .git folder
#

Lfn_Sys_GetSameLevelPath  GvPrjRootPath ".repo"
if [ ! -e "${GvPrjRootPath}" ]; then
    echo "Path=\"${GvPrjRootPath}\"" 
    echo "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

cd ${GvPrjRootPath}

#GvPathPrefix="/mnt/localdata/localhome/jielong.lin/workspace/aosp_6.0.1_r10_selinux"
GvPathPrefix="${GvPrjRootPath}"

GvShareLibraryRoot=${GvPathPrefix}/ShareLibrary_mediaplayer_drm
GvShareLibrary_MP_Drm=${GvShareLibraryRoot}/out
GvShareLibrary_log=${GvShareLibraryRoot}/log
if [ -e "${GvShareLibraryRoot}" ]; then
    rm -rvf ${GvShareLibraryRoot}
fi
mkdir -pv ${GvShareLibraryRoot}
mkdir -pv ${GvShareLibrary_MP_Drm}
mkdir -pv ${GvShareLibrary_log}
chmod 0777 -R ${GvShareLibraryRoot}

GvLogForCodeChange="${GvShareLibrary_log}/Code_Change_List.log"
GvLogForCompile="${GvShareLibrary_log}/Code_Compile_Report.log"
GvLibrary=${GvShareLibrary_MP_Drm}

declare -a arPaths=(
    "${GvPathPrefix}/frameworks/av/media/libmedia"
    "${GvPathPrefix}/frameworks/av/media/libmediaplayerservice"
    "${GvPathPrefix}/frameworks/av/media/libstagefright"
    "${GvPathPrefix}/frameworks/av/drm/common"
    "${GvPathPrefix}/frameworks/av/drm/drmserver"
    "${GvPathPrefix}/frameworks/av/drm/libdrmframework"
    "${GvPathPrefix}/frameworks/av/media/ndk"
    "${GvPathPrefix}/frameworks/av/media/utils"
    "${GvPathPrefix}/frameworks/base/drm/jni"
    "${GvPathPrefix}/frameworks/base/media/jni"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/external/opensource/ffmpeg"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/external/opensource/libdash"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/asta_ffmetadataretriever"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/asta_ffmpegextractor"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/ASTAmediaplayer"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/ASTAtimedtext"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/chromium_http"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/drm"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/httputilservice"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/mediacodecRM"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/mooplayer_utils"
    "${GvPathPrefix}/device/tpvision/common/plf/mediaplayer/av/comps/ASTAmooplayer"
)
declare -i arPathsSize=${#arPaths[@]}

GvLibraryOutPath="${GvPathPrefix}/out/target/product/QM16XE_U/system/lib"
declare -a arLibraries=(
    "libmedia.so"
    "libmediaplayerservice.so"
    "libstagefright \
     libstagefright_soft_aacdec.so \
     libstagefright_soft_aacenc.so \
     libstagefright_amrnb_common.so \
     libstagefright_soft_amrdec.so \
     libstagefright_soft_amrnbenc.so \
     libstagefright_soft_amrwbenc.so \
     libstagefright_avc_common.so \
     libstagefright_soft_h264enc.so \
     libstagefright_soft_avcdec.so \
     libstagefright_soft_avcenc.so \
     libstagefright_enc_common.so \
     libstagefright_soft_flacenc.so \
     libstagefright_soft_g711dec.so \
     libstagefright_soft_gsmdec.so \
     libstagefright_soft_hevcdec.so \
     libstagefright_soft_mpeg4dec.so \
     libstagefright_soft_mpeg4enc.so \
     libstagefright_soft_mp3dec.so \
     libstagefright_soft_mpeg2dec.so \
     libstagefright_soft_vpxdec.so \
     libstagefright_soft_vpxenc.so \
     libstagefright_soft_h264dec.so \
     libstagefright_soft_opusdec.so \
     libstagefright_soft_rawdec.so \
     libstagefright_soft_vorbisdec.so \
     libstagefright_foundation.so \
     libstagefright_http_support.so \
     libstagefright_omx.so \
     libstagefright_wfd.so \
     libstagefright_yuv.so"
    "NULL"
    "NULL"
    "libdrmframework.so"
    "libmediandk.so"
    "libmediautils.so"
    "libdrmframework_jni.so"
    "libmedia_jni.so"
    "libffmpeg_avcodec.so libffmpeg_avformat.so libffmpeg_swresample.so libffmpeg_swscale.so libffmpeg_avutil.so"
    "libdash.so"
    "libasta_ffmetadataretriever.so"
    "libasta_ffmpegextractor.so"
    "libASTAmediaplayer.so libASTA_mediaplayerinterface.so libASTA_abstract_hdmi_passthru_player.so"
    "libASTA_timedtext.so"
    "libasta_chromium_http.so"
    "libdrmplayreadyplugin.so"
    "libhttputilservice.so"
    "libmediacodecRM.so"
    "libmooplayer_utils.so"
    "libASTAmooplayer.so"
)
declare -i arLibrariesSize=${#arLibraries[@]}


> ${GvLogForCodeChange}

function FN_TurnON_Android_LOG()
{
    if [ ! -e "$1" ]; then
        echo -e "Error: Don't exist path:\"$1\"" | tee -a ${GvLogForCodeChange}
        return;
    fi
    if [ $# -ne 2 ]; then
        echo -e "Error: Don't provide the second parameter" | tee -a ${GvLogForCodeChange}
        return;
    fi

    LvNewContent="#define LOG_NDEBUG 0 \/\* JLL\.R${GvDate}\: Enable ALOGV\(\.\.\.\) \*\/"
    LvNewCont=$(echo "${LvNewContent}" | sed -e 's#\\\/#\/#g' \
                                             -e 's#\\\*#\*#g' \
                                             -e 's#\\\.#\.#g' \
                                             -e 's#\\\:#\:#g' \
                                             -e "s#\\\(#\(#g" \
                                             -e "s#\\\)#\)#g")

    echo -e "\r\nPath: ${1##${GvPathPrefix}/}" | tee -a ${GvLogForCodeChange}
    LvRet=0 
    LvCppFiles=$(find $1 -type f | grep -Ei "*.cpp")
    for LvCppF in ${LvCppFiles}; do
        LvFlag=$(sed -n '/\/\/[ -t]*\#[ -t]*define[ -t]\{1,\}LOG_NDEBUG[ -t]\{1,\}0/=' ${LvCppF})
        if [ x"${LvFlag}" != x ]; then
            sed "s://[ -t]*#[ -t]*define[ -t]\{1,\}LOG_NDEBUG[ -t]\{1,\}0:${LvNewContent}:g" -i ${LvCppF} 
            echo -e "@${LvCppF##${GvPathPrefix}/}" | tee -a ${GvLogForCodeChange}
            echo -e "Modify L${LvFlag}:${LvNewCont}" | tee -a ${GvLogForCodeChange}
            LvRet=1
        else
            LvFlag=$(sed -n '/[ -t]*\#[ -t]*define[ -t]\{1,\}LOG_NDEBUG[ -t]\{1,\}0/p' ${LvCppF})
            if [ x"${LvFlag}" != x ]; then
                echo -e "Nothing@ ${LvCppF##${GvPathPrefix}/}"  | tee -a ${GvLogForCodeChange}
            else
                sed "1 i${LvNewContent}" -i ${LvCppF} 
                echo -e "@${LvCppF##${GvPathPrefix}/}" | tee -a ${GvLogForCodeChange}
                echo -e "Insert L1:${LvNewCont}" | tee -a ${GvLogForCodeChange}
                LvRet=1
            fi
        fi
    done
    eval $2=${LvRet}
}



GvShareLibrary_MP_Drm_install=${GvShareLibrary_MP_Drm}/install.sh

echo "#!/sbin/sh" >${GvShareLibrary_MP_Drm_install}
echo "if [ $# -ne 1 ]; then" >>${GvShareLibrary_MP_Drm_install}
echo "    " >>${GvShareLibrary_MP_Drm_install}
cat >${GvShareLibrary_MP_Drm_install} <<EOF
#!/bin/sh
if [ $# -ne 1 ]; then
    echo ""
    echo " Usage:"
    echo "     install.sh  <YourLibrariesPath>"
    echo ""
    echo " Example:"
    echo "     install.sh  /storage/592C-4944/ShareLibrary_mediaplayer_drm/out"
    echo ""
    echo " Note:"
    echo "     please first copy install.sh into /system/lib/"
    exit 0
fi
EOF

declare -a arHash
declare -i szHash=0
for(( i=0; i<arPathsSize; i++)) {
    FN_TurnON_Android_LOG "${arPaths[i]}" GvIsCompiled
    if [ ${GvIsCompiled} -eq 1 ]; then
        arHash[szHash]=$i
        ((szHash+=1))
    fi
}

echo
read -p "Partially Compile the code Change if press [y]:   "  GvChoice
if [ x"${GvChoice}" = x"y" ]; then

    cd ${GvPrjRootPath}
    if [ ! -e "${GvPrjRootPath}/build/envsetup.sh" ]; then
        echo "Sorry, don't exist: ${GvPrjRootPath}/build/envsetup.sh "
        exit 0
    fi
    source build/envsetup.sh
    lunch QM16XE_U-userdebug

    echo "$(date +%Y-%m-%d\ %H:%M:%S)" >${GvLogForCompile}
    for(( j=0; j<szHash; j++)) {
        i=${arHash[j]}

        if [ x"${arPaths[i]}" = x"${GvPathPrefix}/frameworks/av/media/libstagefright" ]; then
            echo -e "\n\n\n@@@@@ Compile \"audio_utils\" first before compile libstagefright.so @@@@@" >>${GvLogForCompile}
            echo -e "\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n ${GvPathPrefix}/system/media/audio_utils\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n" >>${GvLogForCompile}
            cd ${GvPathPrefix}/system/media/audio_utils
            mm -B    2>&1 | tee ${GvShareLibrary_log}/${i}_COMPILE.audio_utils.log
            GvCompileFlag=$(sed -n "/make completed successfully/p" ${GvShareLibrary_log}/${i}_COMPILE.audio_utils.log)
            if [ x"${GvCompileFlag}" = x ]; then
                echo -e " REPORT: Make failure\n" >>${GvLogForCompile}
                cd ${GvShareLibraryRoot}
                rm -rvf ${GvShareLibrary_MP_Drm}
                break
            fi
            echo -e " REPORT: Make successfully\n" >>${GvLogForCompile}
        fi

        echo -e "\n\n\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n ${arPaths[i]}\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n" >>${GvLogForCompile}
        #ls -l ${GvPathPrefix}/device/mediatek_common/vm_linux/android/mediatek/device/prebuilt/libbinder.hwcomposer.mt5890.so  >>${GvLogForCompile}
        #ls -l ${GvPathPrefix}/device/tpvision/QM16XE_U/DTV_OUT/shares_libraries/libmtal.so >>${GvLogForCompile} >>${GvLogForCompile} 
        #echo -e "\n" >>${GvLogForCompile}
        cd ${arPaths[i]}
        GvTempLogFile=$(basename ${arPaths[i]})
        GvTempLogFile=${GvShareLibrary_log}/${i}_COMPILE_${GvTempLogFile}
        mm -B     2>&1 | tee ${GvTempLogFile}
        GvCompileFlag=$(sed -n "/make completed successfully/p" ${GvTempLogFile})
        if [ x"${GvCompileFlag}" = x ]; then
            echo -e " REPORT: Make failure\n" >>${GvLogForCompile}
            cd ${GvShareLibraryRoot}
            rm -rvf ${GvShareLibrary_MP_Drm}
            break
        fi
        echo -e " REPORT: Make successfully\n" >>${GvLogForCompile}
        for GvLib in ${arLibraries[i]}; do
            if [ -e "${GvLibraryOutPath}/${GvLib}" ]; then
                cp -rvf ${GvLibraryOutPath}/${GvLib} ${GvShareLibrary_MP_Drm} | tee -a ${GvLogForCompile}
cat >>${GvShareLibrary_MP_Drm_install} <<EOF

if [ -e /system/lib/${GvLib} -a -e \$1/${GvLib} ]; then
    mv -vf /system/lib/${GvLib} /system/lib/${GvLib}.orig
    cp -rvf \$1/${GvLib} /system/lib/
    chmod 0777 /system/lib/${GvLib}
fi

EOF
            else
                echo "Sorry, Don't exist:${GvLibraryOutPath}/${GvLib}"  | tee -a ${GvLogForCompile}
            fi
        done
    }
    chmod 0777 ${GvShareLibrary_MP_Drm_install}

fi

unset arHash
unset szHash
unset arLibraries
unset arLibrariesSize
unset arPaths
unset arPathsSize

exit 0

