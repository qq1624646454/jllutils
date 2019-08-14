#/bin/bash
#
#Copyright(c) 2019-2100.  jielong.lin@qq.com.   All rights reserved.
#
#Docker Technology

REPOSITORY=ubuntu
TAG=

imageinfo=$(docker images | grep "^${REPOSITORY}[ ]\{1,\}${TAG}")
echo "===== Docker Menu ====="    
i=0
for imginfo in ${imageinfo}; do
    echo "[$((i++))] ${imginfo}"
done
read -p "YourChoice from [*]:  " yourCH


imageid=$(echo "${imageinfo}" | awk -F ' ' '{print $3}')

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

