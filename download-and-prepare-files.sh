#!/bin/bash
cd `dirname $0`
set -e
source ./downloadfilenames
mkdir -p ${DOWNLOADS_DIR}
pushd ${DOWNLOADS_DIR}
if [ ! -f ${L4T_RELEASE_PACKAGE} ]; then
    wget https://developer.nvidia.com/embedded/dlc/r32-2-1_Release_v1.0/TX2-AGX/${L4T_RELEASE_PACKAGE_NAME}
fi
if [ ! -f ${SECUREBOOT_PACKAGE} ]; then
    wget https://developer.nvidia.com/embedded/dlc/r32-2-1_Release_v1.0/TX2-AGX/${SECUREBOOT_PACKAGE_NAME}
fi
if [ ! -f ${SAMPLE_FS_PACKAGE} ]; then
    wget https://developer.nvidia.com/embedded/dlc/r32-2-1_Release_v1.0/TX2-AGX/${SAMPLE_FS_PACKAGE_NAME}
fi
popd
./preparing-for-use.sh
