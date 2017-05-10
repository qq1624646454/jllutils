#!/bin/bash
# Copyright(c) 2016-2100.  jielong.lin.  All rights reserved.
#
#   FileName:     jll.generate.SpliceHexFile.sh 
#   Author:       jielong.lin
#   Email:        493164984@qq.com
#   DateTime:     2016-11-16 19:00:37
#   ModifiedTime: 2016-12-06 11:00:20

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

declare -i GvPageUnit=10
declare -a GvPageMenuUtilsContent=(
    "RESET:  reset dump_dev_by_jll.rescue to dump_dev_by_jll"
    "NEW:    remove dump_dev_by_jll.rescue then copy dump_dev_by_jll to dump_dev_by_jll.rescue"
    "ClEAN:  remove dump_dev_by_jll,dump_dev_by_jll.rescue,dump_orig_by_jll, and so on"
)
Lfn_PageMenuUtils _GvAction "Select" 7 4 "***** Operation Selector (q: quit) *****"

# CLEAN
if [ x"${_GvAction}" = x"${GvPageMenuUtilsContent[2]}" ]; then
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
    [ x"${_GvAction}" != x ] && unset _GvAction
    if [ -e "$(pwd)/dump_dev_by_jll" ]; then
        rm -rvf $(pwd)/dump_dev_by_jll
    fi
    if [ -e "$(pwd)/dump_dev_by_jll.rescue" ]; then
        rm -rvf $(pwd)/dump_dev_by_jll.rescue
    fi
    if [ -e "$(pwd)/dump_orig_by_jll" ]; then
        rm -rvf $(pwd)/dump_orig_by_jll
    fi
    if [ -e "$(pwd)/do_cmp_dev_orig.sh" ]; then
        rm -rvf $(pwd)/do_cmp_dev_orig.sh
    fi
    if [ -e "$(pwd)/cmp_diff_result" ]; then
        rm -rvf $(pwd)/cmp_diff_result
    fi
    if [ -e "$(pwd)/cmp_same_result" ]; then
        rm -rvf $(pwd)/cmp_same_result
    fi
    exit 0
fi

# NEW
if [ x"${_GvAction}" = x"${GvPageMenuUtilsContent[1]}" ]; then
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
    [ x"${_GvAction}" != x ] && unset _GvAction
    if [ ! -e "$(pwd)/dump_dev_by_jll" ]; then
        echo
        echo "JLL: Sorry, Not exist dump_dev_by_jll"
        echo
        exit 0
    fi
    if [ -e "$(pwd)/dump_dev_by_jll.rescue" ]; then
        echo "JLL: REMOVE dump_dev_by_jll.rescue"
        rm -rf $(pwd)/dump_dev_by_jll.rescue
        echo "JLL: COPY dump_dev_by_jll ==> dump_dev_by_jll.rescue"
        cp -rf $(pwd)/dump_dev_by_jll  $(pwd)/dump_dev_by_jll.rescue
    fi
    if [ -e "$(pwd)/dump_orig_by_jll" ]; then
        echo "JLL: REMOVE dump_orig_by_jll"
        rm -rf $(pwd)/dump_orig_by_jll
    fi
    if [ -e "$(pwd)/do_cmp_dev_orig.sh" ]; then
        echo "JLL: REMOVE do_cmp_dev_orig.sh"
        rm -rf $(pwd)/do_cmp_dev_orig.sh
    fi
    if [ -e "$(pwd)/cmp_diff_result" ]; then
        echo "JLL: REMOVE cmp_diff_result"
        rm -rf $(pwd)/cmp_diff_result
    fi
    if [ -e "$(pwd)/cmp_same_result" ]; then
        echo "JLL: REMOVE cmp_same_result"
        rm -rf $(pwd)/cmp_same_result
    fi
fi


# RESET
if [ x"${_GvAction}" = x"${GvPageMenuUtilsContent[0]}" ]; then
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
    [ x"${_GvAction}" != x ] && unset _GvAction
    if [ ! -e "$(pwd)/dump_dev_by_jll" ]; then
        echo
        echo "JLL: Sorry, Not exist dump_dev_by_jll"
        echo
        exit 0
    fi
    if [ ! -e "$(pwd)/dump_dev_by_jll.rescue" ]; then
        echo "JLL: Not exist dump_dev_by_jll.rescue and it is fixed as follows"
        echo "JLL: COPY dump_dev_by_jll ==> dump_dev_by_jll.rescue"
        cp -rf $(pwd)/dump_dev_by_jll  $(pwd)/dump_dev_by_jll.rescue
    else
        echo "JLL: COPY dump_dev_by_jll.rescue ==> dump_dev_by_jll"
        rm -rf  $(pwd)/dump_dev_by_jll
        cp -rf $(pwd)/dump_dev_by_jll.rescue $(pwd)/dump_dev_by_jll
    fi
fi



_GvSourceFile="MPEG-4洋洲梨花 AVC(High@L3.1) AAC(HE-AAC  LC).mp4"

if [ x"${_GvSourceFile}" = x -o ! -e "$(pwd)/${_GvSourceFile}" ]; then
    declare -i GvPageUnit=10
    declare -a GvPageMenuUtilsContent
    i=0
    _GvFLS=$(find . -maxdepth 1 -type f)
    _OldIFS=${IFS}
    IFS=$'\n'
    for _GvFL in ${_GvFLS}; do
        GvPageMenuUtilsContent[i++]="${_GvFL#*./}"
    done
    IFS=${_OldIFS}
    if [ $i -gt 0 ]; then
        Lfn_PageMenuUtils _GvSourceFile  "Select" 7 4 "***** File Selector (q: quit) *****"
    fi
    [ x"${GvPageUnit}" != x ] && unset GvPageUnit
    [ x"${GvPageMenuUtilsContent}" != x ] && unset GvPageMenuUtilsContent
fi
if [ x"${_GvSourceFile}" = x -o ! -e "$(pwd)/${_GvSourceFile}" ]; then
    echo "JLL: Not exist ${_GvSourceFile}"
    echo
    exit 0
fi


declare -a _GvSortFiles
declare -i _GvSortFileIdx=0

echo
echo "JLL:  Collecting all files as named format \"<FileID>.<Offset>---<Length>\"..."
echo
_GvFiles=$(cd $(pwd)/dump_dev_by_jll; ls *.*---*)
for _GvF in ${_GvFiles}; do
    _GvIsDigit=$(echo "${_GvF%%.*}" | sed -n '/^[0-9][0-9]*$/p')
    if [ x"${_GvIsDigit}" != x ]; then
        _GvSortFiles[_GvSortFileIdx++]="${_GvF}"
    else
        echo "JLL: Invalid file format - ${_GvF}"
    fi
done

echo "JLL:  Sorting those Files by ascending..."
echo
for((i=0; i<_GvSortFileIdx; i++)) {
    ___iVal=${_GvSortFiles[i]%%.*}
    for((j=i+1; j<_GvSortFileIdx; j++)) {
        ___jVal=${_GvSortFiles[j]%%.*}
        if [ ${___iVal} -gt ${___jVal} ]; then
            ______GvTemp=${_GvSortFiles[i]}
            _GvSortFiles[i]=${_GvSortFiles[j]}
            _GvSortFiles[j]=${______GvTemp}
            ___iVal=${_GvSortFiles[i]%%.*}
        fi
    }
}

echo "JLL:  Parsing those Files For obtaining FileID, StreamOffset, Length..."
echo
declare -a  _GvOrigs
declare -i  _GvOrigsIdx=0

for((i=0; i<_GvSortFileIdx; i++)) {
    _GvF=${_GvSortFiles[i]}
    _GvTemp="${_GvF%.*}"
    _GvOrigs[_GvOrigsIdx++]="${_GvTemp}"
    _GvTemp="${_GvF#${_GvTemp}.}"
    _GvOrigs[_GvOrigsIdx++]="${_GvTemp%---*}"
    _GvOrigs[_GvOrigsIdx++]="${_GvTemp#*---}"
    #echo "${_GvOrigs[_GvOrigsIdx-3]}|${_GvOrigs[_GvOrigsIdx-2]}---${_GvOrigs[_GvOrigsIdx-1]}"
    sed '1,4d' -i $(pwd)/dump_dev_by_jll/${_GvF}
}
[ x"${_GvSortFiles}" != x ] && unset _GvSortFiles
[ x"${_GvSortFileIdx}" != x ] && unset _GvSortFileIdx

echo
_GvFileCount=$((_GvOrigsIdx/3))
echo "Total Files is ${_GvFileCount}"
echo
if [ -e "$(pwd)/dump_orig_by_jll" ]; then
    rm -rf $(pwd)/dump_orig_by_jll
fi
mkdir -p  $(pwd)/dump_orig_by_jll

[ -e "$(pwd)/cmp_diff_result" ] && rm -rf $(pwd)/cmp_diff_result
[ -e "$(pwd)/cmp_same_result" ] && rm -rf $(pwd)/cmp_same_result
echo > $(pwd)/do_cmp_dev_orig.sh
chmod +x $(pwd)/do_cmp_dev_orig.sh
echo "#!/bin/bash" >> $(pwd)/do_cmp_dev_orig.sh
echo "# Copyright (c) 2016-2100.  jielong_lin.  All rights reserved." >> $(pwd)/do_cmp_dev_orig.sh
echo "# Automatically generate file." >> $(pwd)/do_cmp_dev_orig.sh

for((i=0; i<_GvFileCount; i++)) {
    _GvOffset=${_GvOrigs[i*3+1]};
    _GvLength=${_GvOrigs[i*3+2]};
    _GvTargetFile="${_GvOrigs[i*3+0]}.${_GvOffset}---${_GvLength}"
    echo "JLL-Generating:  ${_GvSourceFile} ==> dump_orig_by_jll/${_GvTargetFile}"
    xxd -c 10 -g 1 -s +${_GvOffset} -l ${_GvLength}  "${_GvSourceFile}" \
        dump_orig_by_jll/${_GvTargetFile}
    echo
cat >> $(pwd)/do_cmp_dev_orig.sh <<EOF

cmp -s $(pwd)/dump_dev_by_jll/${_GvTargetFile} $(pwd)/dump_orig_by_jll/${_GvTargetFile}
if [ \$? -ne 0 ]; then
    #vim -d $(pwd)/dump_dev_by_jll/${_GvTargetFile} $(pwd)/dump_orig_by_jll/${_GvTargetFile}
    echo "Difference for ${_GvTargetFile}" >> $(pwd)/cmp_diff_result
    echo "  vim -d $(pwd)/dump_dev_by_jll/${_GvTargetFile} \\\\" >> $(pwd)/cmp_diff_result
    echo "         $(pwd)/dump_orig_by_jll/${_GvTargetFile}"   >> $(pwd)/cmp_diff_result
    echo >> $(pwd)/cmp_diff_result
else
    echo "Same for ${_GvTargetFile}" >> $(pwd)/cmp_same_result
fi

EOF

}

#if [ -e "$(pwd)/dump_dev_by_jll.rescue" ]; then
    #rm -rf  $(pwd)/dump_dev_by_jll
    #mv -f  $(pwd)/dump_dev_by_jll.rescue  $(pwd)/dump_dev_by_jll
#fi

[ x"${_GvFileCount}" != x ] && unset _GvFileCount
[ x"${_GvFiles}" != x ] && unset _GvFiles
[ x"${_GvOrigs}" != x ] && unset _GvOrigs
[ x"${_GvOrigsIdx}" != x ] && unset _GvOrigsIdx
 

