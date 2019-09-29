#!/bin/bash
# See instructions at https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fquick_start.html%23wwpID0E0RD0HA
set -e
cd `dirname $0`
ABS_PATH_BASE=`pwd`
L4T_RELEASE_PACKAGE=${ABS_PATH_BASE}/Downloads/Tegra186_Linux_R32.2.1_aarch64.tbz2 
SAMPLE_FS_PACKAGE=${ABS_PATH_BASE}/Downloads/Tegra_Linux_Sample-Root-Filesystem_R32.2.1_aarch64.tbz2
#L4T_RELEASE_PACKAGE=${ABS_PATH_BASE}/Downloads/JAX-TX2-Jetson_Linux_R32.1.0_aarch64.tbz2
#SAMPLE_FS_PACKAGE=${ABS_PATH_BASE}/Downloads/JAX-TX2-Tegra_Linux_Sample-Root-Filesystem_R32.1.0_aarch64.tbz2
echo "Extracting ${L4T_RELEASE_PACKAGE}"
sudo tar xpf ${L4T_RELEASE_PACKAGE}
cd Linux_for_Tegra/rootfs/
echo "Extracting ${SAMPLE_FS_PACKAGE}"
sudo tar xpf ${SAMPLE_FS_PACKAGE}
cd ..
sudo ./apply_binaries.sh
