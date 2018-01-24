#!/bin/bash
# Copyright(c) 2016-2100   jielong.lin   All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary

##################################################
#  jielong.lin: Customized Functions 
##################################################


function Fn_Usage()
{
cat >&1 << EOF

[DESCRIPTION]
    Help user to learn about more usage of ${CvScriptName}
    Version: v1 - 2016-2-2 


[USAGE-DETAILS] 

    ${CvScriptName} [help]
        Offer user for that how to use this command.

    ${CvScriptName} -s=<Symbol> -f=<FileType> [-f=<FileType> ... ] [-m=<0|1>] 
        -s equal to specify a symbol, such as Variable or Function Name.
        -f equal to specify a file type for filterring, such as *.c, and it 
           support for the multilse file type options.
        -m equal to specify a mode between 0 and 1.
            0 - precise (default)
            1 - comprehensive 
     Example:
        ${CvScriptName} -s=main -f=*.c -f=*.cpp -f=*.java -f=*.s -m=0
        ${CvScriptName} -s="KeyboardInputMapper::processKey() keyCode=" -f="*.c" -f=*.cpp -f=*.java -f=*.cc -m=0

EOF
}



function Fn_App_Handle()
{
    while [ $# -ne 0 ]; do
        case $1 in
        xx)
            echo "xx"
        ;;
        yy|zz)
            echo "yy|zz"
        ;;
        *)
            Fn_Usage | more
            exit 0 
        ;;
        esac
        shift
    done
}

function Fn_App_Handle2()
{
    for ac_arg; do
        case $ac_arg in
            --hello=*)
                echo "ac_arg: $ac_arg"
                GvHello=`echo $ac_arg | sed -e "s/--hello=//g" -e "s/,/ /g"`
                echo "value: $GvHello"
            ;;
            *)
            ;;
        esac
    done
}


if [ x"$(which realpath)" = x ]; then
    Lfn_Sys_DbgEcho "Sorry, Exit due to not fount realpatch command"
    Lfn_Sys_DbgEcho "Suggestion:   apt-get install realpath"
    exit 0
fi


#-----------------------
# The Main Entry Point
#-----------------------
GvPatchRootPath=${HOME}
if [ ! -e "${GvPatchRootPath}" ]; then
    Lfn_Sys_DbgEcho "Sorry, Exit due to dont exist user \"~\" path"
    exit 0
fi
GvPatchRootPath="${GvPatchRootPath}/svn.patchs"
if [ ! -e "${GvPatchRootPath}" ]; then
    mkdir -pv ${GvPatchRootPath}
    chmod -R 0777 ${GvPatchRootPath}
fi


#
# Find the same level path which contains .git folder
#

Lfn_Sys_GetSameLevelPath  GvRootPath ".svn"
if [ ! -e "${GvRootPath}" ]; then
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Path=\"${GvRootPath}\"" 
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

echo "JLLim: Found SVN Root Path is \"${GvRootPath}\"" 
echo "JLLim: Enter PATH:\"${GvRootPath}\" if press [y], or stay in current path  "
read -p "JLLim: Your Choice is " -n 1 GvYourChoice
echo
if [ x"${GvYourChoice}" = x"y" ]; then
    cd ${GvRootPath}
fi
tree -a -h -L 1  

GvCurPath=$(pwd)

echo
echo

#
# Dump all difference contains modification based on the current svn repository
#
echo "=== svn status ===" 
svn status
echo 

#
# Collect all different files to array list
#
declare -a GvCompSources
declare -i GvCompSourceCount=0
GvPatchRawSources=$(svn status | awk '{print $NF}')



#Handling ignored filter
echo
read -n 1 -p "JLLim: to handle someone ignored in filter if press [y], or skip:  " _choice_y
if [ x"${_choice_y}" = x"y" ]; then
    if [ ! -e "${GvCurPath}/ignore.for.jll.svn.patch.sh" ]; then
cat >${GvCurPath}/ignore.for.jll.svn.patch.sh<<EOF
#!/bin/bash

declare -a _JLLim_Ignore_List=(
    "ignore\.for\.jll\.svn\.patch\.sh"
#
# reference
#
    "modem_proc"
    "tmp-glibc"
    "sstate-cache"
    "pseudodone"
    "bitbake\.lock"
    "*\.done"
    "build\/cache"
    "\.dirstamp"
    "*\.ubi"
    "*\.ubifs"
    "*\.cmm"
    "*\.mbn"
    "*\.deps"
    "*\.dirstamp"
)

EOF
        chmod +x ${GvCurPath}/ignore.for.jll.svn.patch.sh
    fi
    vim ${GvCurPath}/ignore.for.jll.svn.patch.sh
    source ${GvCurPath}/ignore.for.jll.svn.patch.sh 
fi
[ x"${_choice_y}" != x ] && unset _choice_y

if [ x"${_JLLim_Ignore_List}" != x ]; then
    _IGNORE_CNT=${#_JLLim_Ignore_List[@]}
else
    _IGNORE_CNT=0
fi

#Collect all legal resources
for GvPatchS in ${GvPatchRawSources}; do

    if [ ! -e "${GvCurPath}/${GvPatchS}" ]; then
        #[ x"${GvPatchS}" != x ] && 
        echo -e "JLLim: [31m\"${GvCurPath}/${GvPatchS}\" is not found[0m"
        continue
    fi
    _GvPatchS="$(realpath ${GvPatchS} 2>/dev/null)"
    if [ x"${_GvPatchS}" = x -o ! -e "${_GvPatchS}" ]; then
        #[ x"${GvPatchS}" != x ] && 
        echo -e "JLLim: [31m\"${GvPatchS}\" is invalid[0m"
        continue
    fi

    _chk_=""
    #Check if entry should be ignored or not
    for((_I=0; _I<_IGNORE_CNT; _I++)) {
        _chk_=$(echo "${GvPatchS}" | grep -E "${_JLLim_Ignore_List[_I]}")
        if [ x"${_chk_}" != x ]; then
            echo -e "JLLim: [31m\"${GvPatchS}\" should be ignored.[0m"
            break
        fi
    }
    if [ x"${_chk_}" != x ]; then
        echo -e "JLLim: [31m met ignore list entry \"${_chk_}\""
        continue
    fi

    GvCompSources[GvCompSourceCount]="${GvPatchS}"
    GvCompSourceCount=$[GvCompSourceCount+1]
done
[ x"${GvPatchRawSources}" != x ] && unset GvPatchRawSources
[ x"${GvPatchS}" != x ] && unset GvPatchS
[ x"${_GvPatchS}" != x ] && unset _GvPatchS
[ x"${_I}" != x ] && unset _I
[ x"${_chk_}" != x ] && unset _chk_
[ x"${_IGNORE_CNT}" != x ] && unset _IGNORE_CNT

if [ ${GvCompSourceCount} -lt 1 ]; then
    Lfn_Sys_DbgEcho "JLLim: Dont find any different files exist and then exit" 
    unset GvCompSources
    unset GvCompSourceCount
    exit 0
fi


#
# Choice Component
# Please select Your Patch Sources contain modification files
#
GvCompX="0"
GvCompY="0"
GvCompChoice=""
GvCompFlag=1
Lfn_Cursor_Mov "${GvCompY}" "down"
while [ ${GvCompFlag} -eq 1 ]; do
    Lfn_Cursor_Mov "${GvCompX}" "right"
    echo "=====[ File Type (q: Quit) ]=====" 
    GvCompFlag=0
    for (( GvCompIdx=0 ; GvCompIdx<GvCompSourceCount ; GvCompIdx++ )) do
        if [ ! -z "${GvCompChoice}" ]; then 
            for GvCompItem in ${GvCompChoice}; do
                if [ x"${GvCompItem}" = x"${GvCompSources[GvCompIdx]}" ]; then 
                    GvCompItem="Hit.DontDisplay"
                    break
                fi
            done
        fi
        if [ x"${GvCompItem}" = x"Hit.DontDisplay" ]; then
            continue
        fi
        Lfn_Cursor_Mov "${GvCompX}" "right"
        if [ x"$((GvCompIdx % 2))" = x"0" ]; then
            echo -e "├── ${GvCompIdx}:[36m${GvCompSources[GvCompIdx]}[0m" 
        else
            echo -e "├── ${GvCompIdx}:[35m${GvCompSources[GvCompIdx]}[0m" 
        fi
        #echo "├── ${GvCompIdx}: ${GvCompSources[GvCompIdx]}" 
        GvCompFlag=1
    done
    if [ ${GvCompFlag} -ne 1 ]; then
        break;
    fi
    Lfn_Cursor_Mov "${GvCompX}" "right"
    echo "[Your Choice]   "
    Lfn_Cursor_Mov "${GvCompX}" "right"
    echo "========================================" 
    Lfn_Cursor_Mov "2" "up"
    Lfn_Cursor_Mov "$(( GvCompX + 20 ))" "right"
    read GvCompAnChoice
    if [ -z "${GvCompAnChoice}" ]; then
        continue
    fi
    if [ x"${GvCompAnChoice}" = x"q" ]; then
        break
    fi
    for (( GvCompIdx=0 ; GvCompIdx<GvCompSourceCount ; GvCompIdx++ )) do
        if [ ${GvCompAnChoice} -eq ${GvCompIdx} ]; then
            if [ x"${GvCompChoice}" != x ]; then
                for GvCompChoiceEntry in ${GvCompChoice}; do
                    if [ x"${GvCompChoiceEntry}" = x"${GvCompSources[GvCompAnChoice]}" ]; then 
                        GvCompItem="Hit.DontDisplay"
                        break
                    fi
                done
                if [ x"${GvCompChoiceEntry}" != x"${GvCompSources[GvCompAnChoice]}" ]; then 
                    GvCompChoice="${GvCompChoice} ${GvCompSources[GvCompAnChoice]}"
                fi
                unset GvCompChoiceEntry
            else
                GvCompChoice="${GvCompSources[GvCompAnChoice]}"
            fi
        fi
    done
done
if [ x"${GvCompChoice}" = x ]; then
    Lfn_Sys_DbgEcho "JLLim: Exit due to invalid choice" 
    exit 0
fi

GvPatchDate="$(date +%Y.%m.%d___%H.%M.%S)"
GvPatchPath="${GvPatchRootPath}/R_${GvPatchDate}"
if [ ! -e "${GvPatchPath}" ]; then
    mkdir -pv ${GvPatchPath}
    chmod -R 0777 ${GvPatchPath}
fi

cat > ${GvPatchPath}/FileList.txt <<EOF

===== Readme by jielong.lin @ $(date +%Y/%m/%d\ %H:%M:%S) =====

 Please do the follows if apply this patch
   (1) Enter the root of the git reposity :
   (2) Check the patch 
   (3) Apply the patch

 File Tree:
 ├── SourceFiles
 │   ├── ... (Note: Store all Modification Files)
 │ 
 ├── FileList.txt (Note: Record all Modification Files)
 ├── ... 

EOF

echo "===== svn status ====="
svn status | tee -a ${GvPatchPath}/FileList.txt
echo       | tee -a ${GvPatchPath}/FileList.txt
echo "===== Dump Commit Files As Follows ===== "  | tee -a ${GvPatchPath}/FileList.txt
echo       | tee -a ${GvPatchPath}/FileList.txt

if [ ! -e "${GvPatchPath}/SourceFiles" ]; then
    mkdir -pv ${GvPatchPath}/SourceFiles
    chmod -R 0777 ${GvPatchPath}/SourceFiles
fi

cat >${GvPatchPath}/ApplySvnPatch.sh << EOF
#!/bin/bash
# Copyright(c) 2016-2100.   jielong.lin.   All rights reserved.
#
# The script will used to apply the patch

SvnPath=${GvRootPath}  #Reseverd for unuse at present

ProjectPath=${GvCurPath}

#CMPTOOL="vim -d"
CMPTOOL="bcompare"

EOF


for GvSvnFile in ${GvCompChoice}; do

    _GvSvnFile="${GvCurPath}/${GvSvnFile}"
    GvParent=${_GvSvnFile%/*}
    GvThis=${_GvSvnFile##*/}
    
    if [ x"${GvParent}" != x -a y"${GvThis}" != y ]; then
        if [ x"$(ls -l ${GvParent} | grep ${GvThis} | grep -e '^-')" != x ]; then #be file
            GvSvnFile=$(realpath "${GvSvnFile}")
            targetPath="${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}"
            targetPath="${targetPath%/*}"
            [ ! -e "${targetPath}" ] &&  mkdir -pv ${targetPath}
            cp -rvf  ${GvSvnFile}  ${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}
            echo "${GvSvnFile}" | tee -a ${GvPatchPath}/FileList.txt
cat >>${GvPatchPath}/ApplySvnPatch.sh<<EOF

######################################################################################
    #Found patch file
    _PATCH_FILE=""
    while [ 1 -eq 1 ]; do 
        if [ -e "${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}" ]; then
            _PATCH_FILE="${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}"
            break
        fi
        if [ -e "\$(pwd)/SourceFiles${GvSvnFile##${GvCurPath}}" ]; then
            _PATCH_FILE="\$(pwd)/SourceFiles${GvSvnFile##${GvCurPath}}"
            break
        fi
        echo "JLLim Error: Not found the PatchFile"
        echo "             ${GvSvnFile##${GvCurPath}}"
        echo
        read -p "JLLim Choice: Skip this for continuing next if [y], or Quit:  "  -n 1 _SEL_
        if [ x"\${_SEL_}" = x"y" ]; then
            break
        fi
        exit 0
    done

    #Found source file
    while [ x"\${_PATCH_FILE}" != x -a -e "\${_PATCH_FILE}" ]; do
        _SOURCE_FILE="\${ProjectPath}${GvSvnFile##${GvCurPath}}"
        if [ -e "\${_SOURCE_FILE}" ]; then
            break
        fi
        echo "JLLim: Not found the PatchFile, and to use COPY for applying patch"
        echo "       \${_SOURCE_FILE}"
        echo
        break
    done

    if [ x"\${_PATCH_FILE}" != x -a -e "\${_PATCH_FILE}" ]; then
        echo
        echo -e "${AC}${Byellow}${Fblack}Patch=\${_PATCH_FILE}${AC}"
        echo -e "${AC}${Byellow}${Fblack}Source=\${_SOURCE_FILE}${AC}"
 
        if [ x"\${_SOURCE_FILE}" != x -a -e "\${_SOURCE_FILE}" ]; then
            echo "  [v]:     \${CMPTOOL}  \\\${Patch}  \\\${Source}"
        fi
        echo     "  [c]:     cp -rvf  \\\${Patch}  \\\${Source}"
        echo     "  [q]:     quit from current"
        echo     "  [other]: skip current to next"
        read -p  "JLLim: Choice="  -n 1 _CH_
        echo
        case x"\${_CH_}" in
        x"v")
            \${CMPTOOL} \${_PATCH_FILE} \${_SOURCE_FILE}
            ;;
        x"c")
            cp -rvf \${_PATCH_FILE} \${_SOURCE_FILE}
            ;;
        x"q")
            exit 0
            ;;
        *)
            ;; 
        esac
    fi

EOF
        fi

        #For svn, it is dir to indicate a new folder
        if [ x"$(ls -l ${GvParent} | grep ${GvThis} | grep -e '^d')" != x ]; then #be dir 
            GvSvnFile=$(realpath "${GvSvnFile}")
            targetPath="${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}"
            targetPath="${targetPath%/*}"
            [ ! -e "${targetPath}" ] &&  mkdir -pv ${targetPath}
            cp -rvf  ${GvSvnFile}  ${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}
            echo "${GvSvnFile}" | tee -a ${GvPatchPath}/FileList.txt
cat >>${GvPatchPath}/ApplySvnPatch.sh<<EOF

######################################################################################
    #Found patch file
    _PATCH_FILE=""
    while [ 1 -eq 1 ]; do 
        if [ -e "${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}" ]; then
            _PATCH_FILE="${GvPatchPath}/SourceFiles${GvSvnFile##${GvCurPath}}"
            break
        fi
        if [ -e "\$(pwd)/SourceFiles${GvSvnFile##${GvCurPath}}" ]; then
            _PATCH_FILE="\$(pwd)/SourceFiles${GvSvnFile##${GvCurPath}}"
            break
        fi
        echo "JLLim Error: Not found the PatchFile"
        echo "             ${GvSvnFile##${GvCurPath}}"
        echo
        read -p "JLLim Choice: Skip this for continuing next if [y], or Quit:  "  -n 1 _SEL_
        if [ x"\${_SEL_}" = x"y" ]; then
            break
        fi
        exit 0
    done

    #Found source file
    while [ x"\${_PATCH_FILE}" != x -a -e "\${_PATCH_FILE}" ]; do
        _SOURCE_FILE="\${ProjectPath}${GvSvnFile##${GvCurPath}}"
        if [ -e "\${_SOURCE_FILE}" ]; then
            break
        fi
        echo "JLLim: Not found the PatchFile, and to use COPY for applying patch"
        echo "       \${_SOURCE_FILE}"
        echo
        break
    done

    if [ x"\${_PATCH_FILE}" != x -a -e "\${_PATCH_FILE}" ]; then
        echo
        echo -e "${AC}${Byellow}${Fblack}Patch=\${_PATCH_FILE}${AC}"
        echo -e "${AC}${Byellow}${Fblack}Source=\${_SOURCE_FILE}${AC}"
 
        #if [ x"\${_SOURCE_FILE}" != x -a -e "\${_SOURCE_FILE}" ]; then
        #    echo "  [v]:     \${CMPTOOL}  \\\${Patch}  \\\${Source}"
        #fi
        echo     "  [c]:     cp -rvf  \\\${Patch}  \\\${Source}"
        echo     "  [q]:     quit from current"
        echo     "  [other]: skip current to next"
        read -p  "JLLim: Choice="  -n 1 _CH_
        echo
        case x"\${_CH_}" in
        #x"v")
        #    \${CMPTOOL} \${_PATCH_FILE} \${_SOURCE_FILE}
        #    ;;
        x"c")
            cp -rvf \${_PATCH_FILE} \${_SOURCE_FILE}
            ;;
        x"q")
            exit 0
            ;;
        *)
            ;; 
        esac
    fi

EOF
        fi


        if [ x"$(ls -l ${GvParent} | grep ${GvThis} | grep -e '^l')" != x ]; then #be linker
            #      link name ---> link to target
            # /l/m/n/
            #        A ----------> /l/m/n/A1
            #        A ----------> /x/y/A2
            #        A ----------> A3
            _link_to_target=$(readlink "${GvSvnFile}")
            targetPath="${GvPatchPath}/SourceFiles/${_link_to_target##${GvCurPath}}"
            targetPath="${targetPath%/*}"
            [ ! -e "${targetPath}" ] &&  mkdir -pv ${targetPath}
            cp -rvf ${_link_to_target}  ${targetPath}
            _link_to_target="${targetPath}/${_link_to_target##*/}"
 
            _link_name="${GvSvnFile}"
            targetPath="${GvPatchPath}/SourceFiles/${_link_name##${GvCurPath}}"
            targetPath="${targetPath%/*}"
            [ ! -e "${targetPath}" ] && mkdir -pv ${targetPath}
            #cp -rvf ${_link_name} ${targetPath}
            ln -sv ${_link_to_target}  ${targetPath}/${_link_name##*/}
            _link_name=${targetPath}/${_link_name##*/}

            echo "${_link_name}" | tee -a ${GvPatchPath}/FileList.txt
            echo "${_link_to_target}" | tee -a ${GvPatchPath}/FileList.txt
cat >>${GvPatchPath}/ApplySvnPatch.sh<<EOF

######################################################################################
    #Found patch file
    _PATCH_LINK_NAME=""
    while [ 1 -eq 1 ]; do
        #Linker File
        if [ -e "${_link_name}" ]; then
            _PATCH_LINK_NAME="${_link_name}"
            break
        fi
        if [ -e "\$(pwd)/SourceFiles/${_link_name##*/SourceFiles/}" ]; then
            _PATCH_LINK_NAME="\$(pwd)/SourceFiles/${_link_name##*/SourceFiles/}"
            break
        fi
        echo "JLLim Error: Not found the PatchFile"
        echo "             Linker File=${_PATCH_LINK_NAME}"
        echo
        read -p "JLLim Choice: Skip this for continuing next if [y], or Quit:  "  -n 1 _SEL_
        if [ x"\${_SEL_}" = x"y" ]; then
            break
        fi
        exit 0
    done

    while [ x"\${_PATCH_LINK_NAME}" != x ]; do
        #Linker to Target 
        if [ -e "${_link_to_target}" ]; then
            _PATCH_LINK_TO_TARGET="${_link_to_target}"
            break
        fi
        if [ -e "\$(pwd)/SourceFiles/${_link_to_target##*/SourceFiles/}" ]; then
            _PATCH_LINK_TO_TARGET="\$(pwd)/SourceFiles/${_link_to_target##*/SourceFiles/}"
            break
        fi

        echo "JLLim Error: Not found the PatchFile"
        echo "             Linker to Target=${_PATCH_LINK_TO_TARGET}"
        echo
        read -p "JLLim Choice: Skip this for continuing next if [y], or Quit:  "  -n 1 _SEL_
        if [ x"\${_SEL_}" = x"y" ]; then
            break
        fi
        exit 0
    done

    #Found source file
    while [ x"\${_PATCH_LINK_NAME}" != x -a -e "\${_PATCH_LINK_NAME}" \
            -a y"\${_PATCH_LINK_TO_TARGET}" != y -a -e "\${_PATCH_LINK_TO_TARGET}" ]; do
        _SOURCE_FILE="\${ProjectPath}${GvSvnFile##${GvCurPath}}"
        if [ -e "\${_SOURCE_FILE}" ]; then
            break
        fi
        echo "JLLim: Not found the PatchFile, and to use COPY for applying patch"
        echo "       \${_SOURCE_FILE}"
        echo
        break
    done

    if [ x"\${_PATCH_LINK_NAME}" != x -a -e "\${_PATCH_LINK_NAME}" \
            -a y"\${_PATCH_LINK_TO_TARGET}" != y -a -e "\${_PATCH_LINK_TO_TARGET}" ]; then
        echo
        echo -e "${AC}${Byellow}${Fblack}Patch=\${_PATCH_LINK_NAME}${AC}"
        echo -e "${AC}${Byellow}${Fblack}Source=\${_SOURCE_FILE}${AC}"
 
        if [ x"\${_SOURCE_FILE}" != x -a -e "\${_SOURCE_FILE}" ]; then
        #    echo "  [v]:     \${CMPTOOL}  \\\${Patch}  \\\${Source}"
            rm -rvf \${_SOURCE_FILE} 
        fi
        echo     "  [c]:     cp -rvf  \\\${Patch}  \\\${Source}"
        echo     "  [q]:     quit from current"
        echo     "  [other]: skip current to next"
        read -p  "JLLim: Choice="  -n 1 _CH_
        echo
        case x"\${_CH_}" in
        #x"v")
        #    \${CMPTOOL} \${_PATCH_FILE} \${_SOURCE_FILE}
        #    ;;
        x"c")
            cp -rvf \${_PATCH_LINK_NAME} \${_SOURCE_FILE}
            ;;
        x"q")
            exit 0
            ;;
        *)
            ;; 
        esac
    fi

EOF

        fi
 

    fi
done

chmod +x ${GvPatchPath}/ApplySvnPatch.sh

echo
echo "OKay"
echo      

#################################################################################

