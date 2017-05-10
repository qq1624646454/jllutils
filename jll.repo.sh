#!/bin/bash
# Copyright (c) 2016-2100,  jielong_lin,  All rights reserved.
#
JLLFILE="$(which $0)"
JLLFILE="$(basename $0)"
JLLPATH="$(which $0)"
JLLPATH="$(dirname ${JLLPATH})"
#source ${JLLPATH}/BashShellLibrary

### Color Echo Usage ###
# Lfn_Sys_ColorEcho ${CvFgRed} ${CvBgWhite} "hello"
# echo -e "hello \033[0m\033[31m\033[43mworld\033[0m"

GvDate=$(date +%Y%m%d%H%M%S)
function Fn_Start()
{
    [ -e "$(realpath ~)/.ssh" ] && mv -vf ~/.ssh ~/.ssh_R${GvDate}
    [ ! -e "$(realpath ~)/.ssh" ] && mkdir -pv ~/.ssh
    echo
    echo "============ START ============"
    echo
    echo
}

function Fn_End()
{
    echo
    echo
    echo "============  END  ============"
    echo
    [ -e "$(realpath ~)/.ssh" ] && rm -rvf ~/.ssh
    [ -e "$(realpath ~)/.ssh_R${GvDate}" ] && mv -vf ~/.ssh_R${GvDate} ~/.ssh
}

function Fn_GenerateSSHKey_For_x13015851932()
{
cat >~/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA6H8ZiRnpoeau7NQOyUVX35RkRclJCcxFC/vTP+53/jMzNlm5
Q+wLRENDjRPj9nJKwEng6neiuCMo4N5p5lsI6xPFuPF8Zaz+ZgKw+VHsNZ8ZNJfS
2EOg+LQi6fUrl+jTVHrmpN6RL5wFrok7ismm06VaZyhnZaMEdIlhMQoQQSfziH2o
xioZzYe4pLgUxBW7F5IaLHqxObt892qRhLuQyAe1snKyOPVl2VJpedGIPGIOZqkr
Er6+SEB9mN/Q5dVgM9189IOcw78rWg8dcnf+ZUpt4rKeLG5KvCRrI1u9eaPgiB8/
2qmzuZ8mMmXpDb1ooTfMLSu+ASI/B1j/i8tGtQIDAQABAoIBAAHxriD7WnzEFQpd
65G7RrTT5NLAkB/I2Xr0LBwIvnAdtXvq3CW5P47ekR4I4IsbAY0CESNkxLONd7YJ
phELCdQNYkXdnxCqlaX8t8Yd7T+1iNxruJOeXSY3O2OBbU/j3oCCVpNiWQxw3YtM
EndioEZ8x3i9Wb/70Pm4fFuQnfote0KxAThdslkLKPvfMIwKksdUy/y22W/ILhcs
8zHIlzs6D/vWXUpYrsRZJAqOYtq8LSC9H9Ru9hn0mvzqoYl5o4/YppbsLMpzwPPp
daGjkfmN5xdniXP3PUF62FuU1i7QwPfUSo03x/HkydnAwKIAWiLCABcZoTT49wLm
zTqPzLECgYEA/NFm4qXRa0oEUK951xPLPMj4fdmM+JHVo0U2mj0tMtHNBzFRBXwn
wegv8ZXNeC4CiyLZ2BLo+YadgcLC6DpS4vL6tXb/b2UpL3GSwgZCqJD8YiIFmz4V
YL8rH8npGbtq1ni6q7jLmMpeKUmQNw+z10J6vpqHj9wGu+2O9isZ78MCgYEA62w4
c0RbJrGGMjhuoRWbZSAVQeyyyhzdgE2/ATbWxNIfBXEV76zuwVuwTQ3cKbFlLr/0
bk0DTLyiiwI0Df4dGYXs2mAyF5Zjzze1kCo+29gZbE9UyTyBc+36TfP8F8J076CO
ccrSWa9g37FtzpqKcCad0yG4l3C0vvVwSEYNQCcCgYAeqxA+AjtrNmlbmE3BZ2dK
El8CdTeCl75Atg6vmyg2d/jVHIhlj/AKt63JMpDgOUSZuDqQ2Yplao0Exql6Hkkb
urnq9Wp7Ctx6It7YpoXDiQL0rIfdkyRovgfvLUEXnAKTzcVnO12HRVUy0Perlj4M
qMXXBUvYiapPdbvX5NaanQKBgAkAiGAP+xRNsX32HnTWaKzDP0zYCjYkSGwBjQ40
1J2OE1WX72jMygxmvyUTJJoLiHzzJhuZokiq5eQ+31Kxptc1AcuP5hp0y7g+vxiW
JPUvHDnCBtHzGFggf3O/oqId826+SvQa91Qqmp+zHynJSwXi1CIgpfhUfPTYWcTJ
uPP9AoGBANfqmmeJP5RMhsOg9B7eI7Ee4TPTJFfmHbgHkG2cH4PPIIHX6p/605gc
pCZ6WCweDdqOS/l52AlS27vLWH5cBXZOdm1Pr/F833GtJcbh6NRr2JuVTyHvSwCu
+zDBc1E2DJhAKu2xbLzlPIMy+gzf/bONrNjLrXAeyEcaRQAgRvzt
-----END RSA PRIVATE KEY-----
EOF
    chmod 0500 ~/.ssh/id_rsa
cat >~/.ssh/id_rsa.pub <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDofxmJGemh5q7s1A7JRVfflGRFyUkJzEUL+9M/7nf+MzM2WblD7AtEQ0ONE+P2ckrASeDqd6K4Iyjg3mnmWwjrE8W48XxlrP5mArD5Uew1nxk0l9LYQ6D4tCLp9SuX6NNUeuak3pEvnAWuiTuKyabTpVpnKGdlowR0iWExChBBJ/OIfajGKhnNh7ikuBTEFbsXkhoserE5u3z3apGEu5DIB7WycrI49WXZUml50Yg8Yg5mqSsSvr5IQH2Y39Dl1WAz3Xz0g5zDvytaDx1yd/5lSm3isp4sbkq8JGsjW715o+CIHz/aqbO5nyYyZekNvWihN8wtK74BIj8HWP+Ly0a1 493164984@qq.com
EOF
}

function Fn_Usage()
{
cat >&1 <<EOF

  Usage:

      # Hint how to use 
      ${JLLFILE} [help]

      # initialize every git repositories via git clone according to .repoconf 
      ${JLLFILE} init

      # repo sync from remote git repository,
      # equals to repo forall -c 'git reset --hard HEAD;git clean -dfx;git pull -u origin master'
      ${JLLFILE} sync

      # traversal every git repositories to run the speicified command
      ${JLLFILE} forall -c '<YOUR_COMMAND>'  

EOF
}

#if [ x"$1" = x"init" -o x"$1" = x"sync" -o x"$1" = x"forall" ]; then
##
## Check if .jllrepoconf exist or not.
##
GvCurPath=$(pwd)
GvRootPath=$(find ${GvCurPath} -type f | grep -E "\.jllrepoconf$") 
while [ x"${GvRootPath}" = x ]; do
    GvOldPath=${GvCurPath}
    GvCurPath=$(cd ${GvOldPath}/../;pwd)
    echo
    echo "JLL-REPO: Try to check Path=\"${GvCurPath}\" "
    if [ x"${GvCurPath}" = x"/" ]; then
        echo
        echo "JLL-REPO: Error due to path to search for .jllrepoconf is up to \"/\""
        echo
        exit 0
    fi
    GvRootPath=$(find ${GvCurPath} -path "${GvOldPath}" -prune -o -print| grep -E "\.jllrepoconf$")
done
unset GvCurPath
if [ x"${GvRootPath}" = x -o ! -e "${GvRootPath}" ]; then
    echo
    if [ x"$1" = x"init" ]; then
        read -p "Create $(pwd)/.jllrepoconf if press [y], or exit" GvChoice
        if [ x"$GvChoice}" = x"y" ]; then 
            if [ ! -e "$(pwd)/.jllrepoconf" ]; then
                echo "#!/bin/bash"                                                > $(pwd)/.jllrepoconf
                echo "#copyright(c) 2016-2100, jielong_lin, All rights reserved." >> $(pwd)/.jllrepoconf
                echo "declare -a GitRepositoryTable=( "                           >> $(pwd)/.jllrepoconf
                echo "    \"git@code.csdn.net:x13015851932/jllutils.git\""        >> $(pwd)/.jllrepoconf
                echo ")"                                                          >> $(pwd)/.jllrepoconf
                echo                                                              >> $(pwd)/.jllrepoconf
            fi
            vim $(pwd)/.jllrepoconf
            GvRootPath=$(pwd)/.jllrepoconf
        else
            echo "JLL-REPO: Error and Exit due to lack of .jllrepoconf"
            exit 0 
        fi
    else
        echo "JLL-REPO: Error and Exit due to lack of .jllrepoconf"
        exit 0
    fi
fi
echo
echo "JLL-REPO: Retrieved rootpath=\"${GvRootPath%%/.jllrepoconf}\" "
source ${GvRootPath}
GvRootPath="${GvRootPath%%/.jllrepoconf}"
if [ ! -e "${GvRootPath}" ]; then
    echo
    echo "JLL-REPO: Error due to rootpath=\"${GvRootPath}\" is invalid"
    echo
    unset GvRootPath
    unset GitRepositoryTable
    exit 0
fi

if [ x"${GitRepositoryTable}" = x -o ${#GitRepositoryTable[@]} -lt 1 ]; then
    echo
    echo "JLL-REPO: Error due to ${GvRootPath}/.jllrepoconf don't define GitRepositoryTable"
    echo
    unset GvRootPath
    unset GitRepositoryTable
    exit 0
fi

#fi

if [ x"$1" = x ]; then
    Fn_Usage
    unset GvRootPath
    unset GitRepositoryTable
    echo
    exit 0
fi

cd ${GvRootPath}  1>/dev/null 2>/dev/null

case x"$1" in
x"init")
    Fn_Start
    Fn_GenerateSSHKey_For_x13015851932
    for(( i=0; i<${#GitRepositoryTable[@]}; i++ )) {
        echo
        echo
        echo -e "JLL-REPO: Checking \033[0m\033[31m\033[43m\"${GitRepositoryTable[i]}\"\033[0m"
        GvPath=${GitRepositoryTable[i]}
        GvPath=${GvPath##*/}
        [ x"${GvPath}" != x ] && GvPath=${GvPath%%.git}
        if [ x"${GvPath}" = x ]; then
            echo "JLL-REPO: Can't get Git Repository Name"
            echo
            Fn_End
            unset GitRepositoryTable
            unset GvPath
            unset GvRootPath
            exit 0 
        fi
        GvPath=${GvRootPath}/${GvPath}
        echo "JLL-REPO: Checking Git Path=\"${GvPath}\"" 
        if [ ! -e "${GvPath}" ]; then
            echo "JLL-REPO:  Doing by git clone ${GitRepositoryTable[i]}"
            echo
            git clone ${GitRepositoryTable[i]}
        else
            echo "JLL-REPO:  Nothing!!! Git Repository \"${GitRepositoryTable[i]##*/}\" has already existed"
            echo
        fi
    }
    Fn_End
    ;;
x"sync" | x"forall")
    GvCmd=""
    if [ x"$1" = x"forall" ]; then
        if [ x"$2" != x"-c" ]; then
            echo
            Fn_Usage
            unset GitRepositoryTable
            unset GvRootPath
            unset GvCmd
            echo
            exit 0
        fi
        GvCmd="$3"
    fi
    Fn_Start
    Fn_GenerateSSHKey_For_x13015851932
 
    for(( i=0; i<${#GitRepositoryTable[@]}; i++ )) {
        echo
        echo
        echo -e "JLL-REPO: Checking \033[0m\033[31m\033[43m\"${GitRepositoryTable[i]}\"\033[0m"
        GvPath=${GitRepositoryTable[i]}
        GvPath=${GvPath##*/}
        [ x"${GvPath}" != x ] && GvPath=${GvPath%%.git}
        if [ x"${GvPath}" = x ]; then
            echo "JLL-REPO: Can't get Git Repository Name"
            echo
            Fn_End
            unset GitRepositoryTable
            unset GvPath
            unset GvRootPath
            unset GvCmd
            exit 0 
        fi
        GvPath=${GvRootPath}/${GvPath}
        echo "JLL-REPO: Checking Git Path=\"${GvPath}\"" 
        if [ ! -e "${GvPath}" ]; then
            echo "JLL-REPO: Can't get Git Repository Path"
            echo
            Fn_End
            unset GitRepositoryTable
            unset GvPath
            unset GvCmd
            unset GvRootPath
            exit 0 
        fi
        cd ${GvPath} 1>/dev/null 2>/dev/null
        if [ -e "${GvPath}/desktop.ini" ]; then
            #echo "${GvPath}/desktop.ini" > .igitignore
	    mv -vf ${GvPath}/desktop.ini ${GvPath}/../desktop.ini.git_by_csdn
        fi
        if [ x"${GvCmd}" = x ]; then #repo sync
            GvCmd=$(git status -s)
            if [ x"${GvCmd}" != x ];then
                echo "---- git status -s -----"
                echo "${GvCmd}"
                read -p "JLL-REPO: RESET to clean those changes if press [y], or skip:   " GvChoice
                if [ x"${GvChoice}" = x"y" ]; then
                    git reset --hard HEAD
                    git clean -dfx
                fi
            fi
            git pull -u origin master
            GvCmd=""
        else
            eval ${GvCmd}
        fi
        if [ -e "${GvPath}/../desktop.ini.git_by_csdn" ]; then
            mv -vf ${GvPath}/../desktop.ini.git_by_csdn  ${GvPath}/desktop.ini
        fi
        cd -  1>/dev/null 2>/dev/null
    }
    unset GvCmd
    Fn_End
    ;;
*)
    Fn_Usage
    ;;
esac
unset GitRepositoryTable
unset GvRootPath
