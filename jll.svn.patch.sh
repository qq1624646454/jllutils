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
for GvPatchS in ${GvPatchRawSources}; do

    GvIsPath=${GvPatchS%/*}
    GvIsFile=${GvPatchS##*/}
    if [ x"${GvIsPath}" != x  -a y"${GvIsFile}" != y ]; then
        if [ x"$(ls -l ${GvIsPath} | grep ${GvIsFile} | grep -e '^d')" = x ]; then

    GvCompSources[GvCompSourceCount]="$(realpath ${GvPatchS})"
    GvCompSourceCount=$[GvCompSourceCount+1]

        fi
    fi
done
unset GvPatchRawSources
unset GvpatchS
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

echo "===== Status ====="
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

SvnPath=${GvRootPath}

PatchPath=${GvCurPath}


EOF


for GvSvnFile in ${GvCompChoice}; do
    
    GvIsPath=${GvSvnFile%/*}
    GvIsFile=${GvSvnFile##*/}
    if [ x"${GvIsPath}" != x  -a y"${GvIsFile}" != y ]; then
        if [ x"$(ls -l ${GvIsPath} | grep ${GvIsFile} | grep -e '^d')" = x ]; then
            targetPath="${GvPatchPath}/SourceFiles/${GvSvnFile##${GvCurPath}}"
            targetPath="${targetPath%/*}"
            [ ! -e "${targetPath}" ] &&  mkdir -pv ${targetPath}
            cp -rvf  ${GvSvnFile}  ${GvPatchPath}/SourceFiles/${GvSvnFile##${GvCurPath}}
            echo "${GvSvnFile}" | tee -a ${GvPatchPath}/FileList.txt
cat >>${GvPatchPath}/ApplySvnPatch.sh<<EOF

echo "\${PatchPath}${GvSvnFile##${GvCurPath}}:"
echo "  [y]:     vimdiff SourceCode Patch"
echo "  [c]:     COPY Patch TO SourceCode"
echo "  [q]:     Quit from current"
echo "  [other]: Skip to next"
read -p "JLLim Choice:  "  -n 1 _CH_
case x"\${_CH_}" in
x"y")
    vim \${PatchPath}${GvSvnFile##${GvCurPath}} -d ${GvPatchPath}/SourceFiles/${GvSvnFile##${GvCurPath}}
    ;;
x"c")
    cp -rvf  ${GvPatchPath}/SourceFiles/${GvSvnFile##${GvCurPath}} \${PatchPath}${GvSvnFile##${GvCurPath}}
    ;;
x"q")
    exit 0
    ;;
*)
    ;; 
esac


EOF
        else
            echo "JLLim: Skipping folder: ${GvSvnFile}"
        fi
    fi
done

chmod +x ${GvPatchPath}/ApplySvnPatch.sh

echo
echo "OKay"
echo      

#################################################################################
