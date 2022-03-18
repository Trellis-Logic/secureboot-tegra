#!/bin/bash
cd `dirname $0`
set -e
source ./downloadfilenames
mkdir -p ${DOWNLOADS_DIR}
pushd ${DOWNLOADS_DIR}
if [ ! -f ${L4T_RELEASE_PACKAGE} ]; then
    wget ${BASEURL}/${L4T_RELEASE_PACKAGE_NAME}
fi
if [ ! -f ${SECUREBOOT_PACKAGE} ]; then
    wget ${BASEURL}/${SECUREBOOT_PACKAGE_NAME}
fi
if [ ! -f ${SAMPLE_FS_PACKAGE} ]; then
    wget ${BASEURL}/${SAMPLE_FS_PACKAGE_NAME}
fi
popd
./preparing-for-use.sh
