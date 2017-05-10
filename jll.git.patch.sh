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


#-----------------------
# The Main Entry Point
#-----------------------
GvPatchRootPath=$(realpath ~)
if [ ! -e "${GvPatchRootPath}" ]; then
    Lfn_Sys_DbgEcho "Sorry, Exit due to dont exist user \"~\" path"
    exit 0
fi
GvPatchRootPath="${GvPatchRootPath}/GitFormatPatch"
if [ ! -e "${GvPatchRootPath}" ]; then
    mkdir -pv ${GvPatchRootPath}
    chmod -R 0777 ${GvPatchRootPath}
fi


#
# Find the same level path which contains .git folder
#

Lfn_Sys_GetSameLevelPath  GvPrjRootPath ".repo"
if [ ! -e "${GvPrjRootPath}" ]; then
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Path=\"${GvPrjRootPath}\"" 
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

Lfn_Sys_GetSameLevelPath  GvRootPath ".git"
if [ ! -e "${GvRootPath}" ]; then
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Path=\"${GvRootPath}\"" 
    Lfn_Sys_DbgColorEcho ${CvBgBlack} ${CvFgRed}  "Error-Exit: Cannot find Git Root Path" 
    exit 0
fi
echo

GvRepoPath="${GvRootPath##${GvPrjRootPath}}"

echo "jll: Found Git Root Path is \"${GvRootPath}\"" 
echo "jll: Enter PATH:\"${GvRootPath}\" if press [y], or exit "
read -p "jll: Your Choice is " GvYourChoice
echo
if [ x"${GvYourChoice}" != x"y" ]; then
    echo "jll: Exit due to your choice" 
    exit 0
fi

cd ${GvRootPath}
tree -a -h -L 1  

echo
echo

#
# Dump all difference contains modification based on the current git reposity 
#
echo "=== git status ===" 
git status -s 
echo 
echo "=== git difference list ===" 
git diff --stat
echo 
echo "=== git difference details ===" 
git diff 
echo 


#
# Collect all different files to array list
#
declare -a GvCompSources
declare -i GvCompSourceCount=0
GvPatchRawSources=$(git status -s | awk '{print $NF}')
for GvPatchS in ${GvPatchRawSources}; do
    GvCompSources[GvCompSourceCount]="$(realpath ${GvPatchS})"
    GvCompSourceCount=$[GvCompSourceCount+1]
done
unset GvPatchRawSources
unset GvpatchS
if [ ${GvCompSourceCount} -lt 1 ]; then
    Lfn_Sys_DbgEcho "jll: Dont find any different files exist and then exit" 
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
        echo "├── ${GvCompIdx}: ${GvCompSources[GvCompIdx]}" 
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
    Lfn_Sys_DbgEcho "jll: Exit due to invalid choice" 
    exit 0
fi

echo
echo "jll: \"git add\" the above choices if press [y], or exit " 
read -p "jll: Your Choice is " GvYourChoice
echo
if [ x"${GvYourChoice}" != x"y" ]; then
    echo "jll: Exit due to your choice" 
    exit 0
fi

GvPatchDate="$(date +%Y.%m.%d_%H.%M.%S)"
GvPatchPath="${GvPatchRootPath}/${GvPatchDate}"
if [ ! -e "${GvPatchPath}" ]; then
    mkdir -pv ${GvPatchPath}
    chmod -R 0777 ${GvPatchPath}
fi

cat > ${GvPatchPath}/FileList.txt <<EOF

===== Readme by jielong.lin @ $(date +%Y/%m/%d %H:%M:%S) =====

 Please do the follows if apply this patch
   (1) Enter the root of the git reposity :
       $ cd ${GvRootPath}
   (2) Check the patch named 1
       $ git apply --stat 1
       $ git aplly --check 1
   (3) Apply the patch named 1
       $ git am --signoff < 1 

 File Tree:
 ├── SourceFiles
 │   ├── ... (Note: Store all Modification Files)
 │ 
 ├── FileList.txt (Note: Record all Modification Files)
 ├── 1 (Note: Git Format Patch which is named by digital) 
 ├── ... 
 


EOF

echo "===== Status ====="
git status -s | tee -a ${GvPatchPath}/FileList.txt
echo          | tee -a ${GvPatchPath}/FileList.txt
echo "===== Dump Commit Files As Follows ===== "  | tee -a ${GvPatchPath}/FileList.txt

if [ ! -e "${GvPatchPath}/SourceFiles" ]; then
    mkdir -pv ${GvPatchPath}/SourceFiles
    chmod -R 0777 ${GvPatchPath}/SourceFiles
fi

for GvGitFile in ${GvCompChoice}; do
    cp -rvf  ${GvGitFile}       ${GvPatchPath}/SourceFiles/
    echo "${GvGitFile}"         | tee -a ${GvPatchPath}/FileList.txt
    git add ${GvGitFile}        
done
git commit                       

# the patch is generated by comparing with HEAD^ version, hence the patch is only one,
# and it is called 1.
git format-patch HEAD^ -o ${GvPatchPath} -s --numbered-files


cat >${GvPatchPath}/ApplyGitFormatPatch.sh << EOF
#!/bin/bash
# Copyright(c) 2016-2100.   jielong.lin.   All rights reserved.
#
# The script will used to apply the patch

GvCurrentPath="\$(pwd)"
if [ ! -e "\${GvCurrentPath}/1" ]; then
    echo "Error-Exit: Dont exist the patch named 1 in \$(pwd)" 
    exit 0
fi

GvYourHome="\$(realpath ~)"
GvYourH=\$(ls \${GvYourHome})
declare -a GvMenu
declare -i GvMenuIdx=0
for GvM in \$GvYourH; do
    GvM="\${GvYourHome}/\${GvM}"
    if [ ! -e "\${GvM}/.repo" ]; then
        continue
    fi
    GvMenu[GvMenuIdx]="\${GvM}"
    GvMenuIdx=\$(( GvMenuIdx + 1 ))
done
unset GvYourHome
unset GvYourH
unset GvM

GvRootPath=/.repo

echo
while [ x"\${GvMenuIdx}" != x"0" ]; do
    echo "---------------------------------------------------------------"
    echo "Your Project maybe exist in as follows: "
    for(( GvIdx=0; GvIdx<GvMenuIdx; GvIdx++ )) do
        echo "\${GvIdx}: \${GvMenu[GvIdx]}"
    done
    echo "---------------------------------------------------------------"
    echo "Please input the Number of YOUR Project for applying this patch"
    read -p "[Your Project Number] " YourProjectNumber
    for(( GvIdx=0; GvIdx<GvMenuIdx; GvIdx++ )) do
        if [ x"\${GvIdx}" = x"\${YourProjectNumber}" ]; then
            YourRepoPath="\${GvMenu[GvIdx]}"
            break
        fi
    done
    if [ ! -e "\${YourRepoPath}" ]; then
        echo
        echo "Sorry for input, Dont exist PATH=\"\${YourRepoPath}\""
        echo
        continue
    fi
    YourRepoPath="\$(realpath \${YourRepoPath})"
    GvRootPath="\${YourRepoPath}${GvRepoPath}"
    if [ ! -e "\${GvRootPath}" ]; then
        echo
        echo "Sorry for merge, Dont exist PATH=\"\${GvRootPath}\""
        echo
        continue
    fi
    break;
done
unset GvMenu
unset GvMenuIdx

if [ ! -e \${GvRootPath} ]; then
    echo "Error-Exit: Dont exist the target git reposity \"\${GvRootPath}\""
    exit 0
fi

echo 
echo "(1) Enter the path of the git reposity : "
cd \${GvRootPath}
pwd
echo
echo "(2) Copy the patch named 1 into the specified git reposity :"
cp -rvf \${GvCurrentPath}/1  \${GvRootPath}/
echo
echo "(3) Apply the patch named 1 :"
git am -3 --ignore-whitespace 1
echo
rm -rvf \${GvRootPath}/1
echo

#echo "Disable Check about trailing whitespace"
#git config core.autocrlf true
#git config core.safecrlf true
#echo
echo
echo "Note: If issue is \"previous rebase directory ... still exists but mbox given.\", do the follows: "
echo "Note:   git rebase --abort; git clean -dfx; git reset --hard HEAD "
echo "Note: After do above steps, please try to run this script again!!!"
echo
echo "Note: When you have resolved this problem run \"git am --resolved\". "
echo "Note: If you would prefer to skip this patch, instead run \"git am --skip\".  "
echo "Note: To restore the original branch and stop patching run \"git am --abort\". "
echo
echo

EOF
    chmod +x ${GvPatchPath}/ApplyGitFormatPatch.sh


#
# Restore the uncommit environment
#
echo
echo "jll: Retore uncommit environment if press [y], or exit " 
read -p "jll: Your Choice is " GvYourChoice
echo
if [ x"${GvYourChoice}" = x"y" ]; then
    echo "git reset --mixed HEAD^" 
    git reset --mixed HEAD^
    echo
    if [ -e "${GvRootPath}/.git/COMMIT_EDITMSG" ]; then
        echo "Remove ${GvRootPath}/.git/COMMIT_EDITMSG" 
        rm -rvf ${GvRootPath}/.git/COMMIT_EDITMSG
    fi
    if [ -e "${GvRootPath}/.git/ORIG_HEAD" ]; then
        echo "Remove ${GvRootPath}/.git/ORIG_HEAD" 
        rm -rvf ${GvRootPath}/.git/ORIG_HEAD
    fi
    if [ -e "${GvRootPath}/.git/logs/HEAD" ]; then
        echo "Remove ${GvRootPath}/.git/logs/HEAD" 
        rm -rvf ${GvRootPath}/.git/logs/HEAD
    fi
fi

#
# Compress Your Patch with zip
#
echo
echo "jll: Compress Your Patch to ZIP if press [y], or skip " 
read -p "jll: Your Choice is " GvYourChoice
echo
if [ x"${GvYourChoice}" = x"y" ]; then
    cd  ${GvPatchRootPath}
    zip -r9 ${GvPatchDate}.zip ${GvPatchDate} 
cat >${GvPatchRootPath}/unzip_${GvPatchDate}.sh << EOF
#!/bin/bash
# Copyright(c) 2016-2100.   jielong.lin.   All rights reserved.
#
# The script will used to extract the zip file into the current path

if [ -e ./${GvPatchDate}.zip ]; then
    unzip -vt ${GvPatchDate}.zip
    unzip ${GvPatchDate}.zip  -d   ./
fi

EOF
    echo    "${GvPatchRootPath}/unzip_${GvPatchDate}.sh"
    chmod +x ${GvPatchRootPath}/unzip_${GvPatchDate}.sh
fi






echo
echo "OK"
echo      

#################################################################################

