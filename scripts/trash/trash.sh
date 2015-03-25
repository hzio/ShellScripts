#!/bin/bash
#***********************************************
#      Function: a trash box implementation    *
#      Author  : BobZhao		       *
#      Date    : 2015-03-25		       *
#***********************************************

usage(){
	echo "Usage: `basename $0` file (delete files or directories)"
	echo "       `basename $0` -e   (empty trash)"
}
# check parameter
if [ $# -lt 1 ];then
	usage
	exit -1
fi

TRASH_PATH="/trash"
empty_trash(){
	echo "empty trash..."
    rm "-rf" "${TRASH_PATH}/*"
}
# check trash path if exists.
if [ ! -r ${TRASH_PATH} ];then
	echo "Making ${TRASH_PATH} directory."
    mkdir ${TRASH_PATH}
fi

param=$1
# clean trash
if [ ${param} == "-e" ];then
	empty_trash
	exit 0
fi

CUR_PATH=`pwd`
# check file if exists
if [ ! -r ${param} ];then
    echo "File or directory ${param} not exists."
    exit -1
fi

NOW=`date "+%Y-%m-%d_%H:%M:%S"`
TRASH_FILE="${TRASH_PATH}/${NOW}_${param}"
mv ${param} ${TRASH_FILE}

exit 0

