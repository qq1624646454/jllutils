#!/bin/bash
# Copyright(c) 2016-2100   jielong.lin   All rights reserved.
#

JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
source ${JLLPATH}/BashShellLibrary



Lfn_Sys_CheckRoot

Lfn_Sys_GetAllUsers GvUserList 

echo
echo        " UserList "
for GvUser in ${GvUserList}; do
    echo    "  |--- ${GvUser}"
done 
echo        "  |"
echo 

if [ x"$1" = x"add" ]; then
    echo        "jll: All the exist valid users as above"
    echo        "jll: Now please type an new user as system user and samba user"
    read -p     "     New User = " GvNewUser
    if [ x"$GvNewUser" = x ]; then
        echo    "jll: Exit due to the invalid user is specified"
        echo
        exit 0
    fi

    echo "Creating New User:$GvNewUser for system and samba"
    /usr/sbin/useradd -s /bin/bash -m $GvNewUser
    /usr/bin/passwd  $GvNewUser
    /usr/bin/smbpasswd -a $GvNewUser 

    if [ ! -e "/home/$GvNewUser" ]; then
        echo
        Lfn_Sys_ColorEcho ${CvBgBlue}  ${CvFgRed} "Error-Exit: Donot found home directory for the New User:$GvNewUser"
        echo
        exit 0
    fi
    if [ ! -e "/home/${GvNewUser}/.vim" ]; then
        mkdir -pv /home/${GvNewUser}/.vim
        chown -R ${GvNewUser}:${GvNewUser} /home/${GvNewUser}/.vim
    fi
    cp -rvf ${CvScriptPath}/vimenv/mark-2.8.5/* /home/${GvNewUser}/.vim/
    chown -R ${GvNewUser}:${GvNewUser} /home/${GvNewUser}/.vim
    chmod -R 0700 /home/${GvNewUser}/.vim
    echo
    Lfn_Sys_ColorEcho ${CvBgBlue}  ${CvFgWhite} "Done: Create New User:$GvNewUser for system and samba"
    echo
    exit 0
fi

if [ x"$1" = x"del" ]; then
    echo        "jll: All the exist valid users as above"
    echo        "jll: Now please type an above user to delete"
    read -p     "     Delete User = " GvDelUser
    if [ x"$GvDelUser" = x ]; then
        echo    "jll: Exit due to the invalid user is specified"
        echo
        exit 0
    fi

    for GvUser in ${GvUserList}; do
        if [ x"$GvUser" = x"$GvDelUser" ]; then
            echo "Deleting the User:$GvDelUser"
            /usr/bin/smbpasswd -x $GvDelUser
            /usr/sbin/userdel -r $GvDelUser
 
            echo
            Lfn_Sys_ColorEcho ${CvBgBlue}  ${CvFgWhite} "Done: Delete the User:$GvDelUser"
            echo
            break 
        fi
    done
    exit 0
fi

if [ x"$1" = x"users" ]; then
    w
    echo
    who
    echo
    exit 0
fi

cat >&1 <<EOF

    ${CvScriptName} [help]
    ${CvScriptName} add
    ${CvScriptName} del

    ${CvScriptName} users 

EOF
