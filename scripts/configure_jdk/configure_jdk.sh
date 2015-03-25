#!/bin/bash

usage(){
    echo "Usage: ./`basename $0` xxoo.tar.gz"
}
# check parameter
if [ $# -lt 1 ]; then
    echo "Argument missing"
    usage
    exit 1
fi

FILE=$1
if [ ! -f $FILE ];then
    echo "$FIle not exists."
    exit 1
fi

# copy file to the destination and decompress
CUR_PATH=`pwd`
DEST_PATH="/usr/java/jdk"
mkdir -p $DEST_PATH
rm -rf "${DEST_PATH}/*"
cd ${DEST_PATH}
cp "${CUR_PATH}/$FILE" ${DEST_PATH}
tar zxvf $FILE
rm -f "${DEST_PATH}/$FILE"

DIR_NAME=`ls`
JDK_PATH="${DEST_PATH}/${DIR_NAME}"

echo "${FILE} was decompressed to ${DEST_PATH}"
echo "Begin to start confiuring /etc/profile..."
# configure profile for Java Environment
cat >> /etc/profile << EOF
export JAVA_HOME=$JDK_PATH
export JRE_HOME=$JDK_PATH/jre
export PATH=\$PATH:\$JAVA_HOME/bin
EOF

echo "========== ALL DONE. ========="
