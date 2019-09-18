#/bin/bash
#
#Copyright(c) 2019-2100.  jielong.lin@qq.com.   All rights reserved.
#
#Docker Technology

REPOSITORY=ubuntu
TAG=

imageinfo=$(docker images | grep "^${REPOSITORY}[ ]\{1,\}${TAG}")
echo "===== Docker Menu ====="
 
OldIFS="${IFS}"
IFS=$'\n'
i=0
for imginfo in ${imageinfo}; do
    echo "[$((i++))] ${imginfo}"
done
IFS="${OldIFS}"
read -p "YourChoice from [*]:  " yourCH


HostAddr=$(ifconfig | grep -e '^eth' -A 1 | grep -e 'inet addr:' | awk -F':' '{print $2}' \
                    | awk -F' ' '{print $1}')
OldIFS="${IFS}"
IFS=$'\n'
i=0
for imginfo in ${imageinfo}; do
    if [ x"$((i++))" = x"${yourCH}" ]; then
        imageid=$(echo "${imginfo}" | awk -F ' ' '{print $3}')
        if [ x"${imageid}" != x ]; then
            echo
            echo "===== Docker Network ====="
            echo "[0] host      by sharing physical network device"
            echo "[*] bridge    default by Network Address Translation(NAT)"
            read -p "YourChoice from [*]:  " yourNet
            if [ x"${yourNet}" = x"0" ]; then
                dockerNet="--network host"
            else
                dockerNet="--network bridge -p 11022:22"
            fi
            echo
            echo "JLLim: RUNing \"docker run -it --name root --privileged=true -v /:/ibs" \
                 "${dockerNet} ${imageid} /bin/bash\""
            echo
            echo "       LOGIN DOCKER UBUNTU BY docker attach root OR ssh root@YOUR_IP -p 11022"
            if [ x"${HostAddr}" != x ]; then
                echo "           ssh root@${HostAddr} -p 11022"
                echo
                echo "           IF Failure, please check the follows in docker ubuntu system"
                echo "               aptitude search openssh"
                echo "               Modify PermitRootLogin from without-password to yes in"
                echo "                   /etc/ssh/sshd_config"
                echo "               passwd root"
                echo "               /etc/init.d/ssh restart"
                echo
            fi
            echo "           / will be mapped to /ibs in docker ubuntu"
            echo
            echo

            docker run -it --name root --privileged=true -v /:/ibs ${dockerNet} ${imageid} /bin/bash
            docker rm -f $(docker ps -a -q)
            echo
            IFS="${OldIFS}"
            exit 0
        fi
    fi
done
IFS="${OldIFS}"

exit 0
imageid=$(echo "${imageinfo}" | awk -F ' ' '{print $3}')
if [ x"${imageid}" != x ]; then
    #echo "${imageinfo}"
    #sleep 2
    #echo
    #echo "JLLim: REPOSITORY=${REPOSITORY}"
    #echo "JLLim: TAG=${TAG}"
    for imgid in ${imageinfo}; do
        echo "${imgid}"
    done 
read -n 1 "yes" 
exit 0
    echo "JLLim: RUNing \"docker run -it -v /:/ibs ${imageid} /bin/bash\""
    echo
    docker run -it -v /:/ibs ${imageid} /bin/bash
    echo

    [ x"${imageid}" != x ] && unset imageid
else
    echo "JLLim: Not FOUND docker images named ${REPOSITORY}:${TAG}"
    echo "JLLim: RUNing \"docker pull ${REPOSITORY}:${TAG}\""
    echo
    docker pull ${REPOSITORY}:${TAG}
    echo
    imageinfo=$(docker images | grep "^${REPOSITORY}[ ]\{1,\}${TAG}")
    imageid=$(echo "${imageinfo}" | awk -F ' ' '{print $3}')
    if [ x"${imageid}" != x ]; then
        echo "${imageinfo}"
        sleep 2
        echo
        echo "JLLim: REPOSITORY=${REPOSITORY}"
        echo "JLLim: TAG=${TAG}"
        echo "JLLim: Trying to RUN \"docker run -it -v /:/ibs ${imageid} /bin/bash\""
        echo
        docker run -it -v /:/ibs ${imageid} /bin/bash
        echo
    fi
fi

[ x"${imageid}" != x ] && unset imageid
[ x"${imageinfo}" != x ] && unset imageid 
[ x"${TAG}" != x ] && unset TAG 
[ x"${REPOSITORY}" != x ] && unset REPOSITORY

