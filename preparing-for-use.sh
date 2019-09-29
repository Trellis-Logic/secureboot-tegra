#!/bin/bash
# See instructions at https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fquick_start.html%23wwpID0E0RD0HA
set -e
cd `dirname $0`
source ./downloadfilenames
echo "Extracting ${L4T_RELEASE_PACKAGE}"
sudo tar xpf ${L4T_RELEASE_PACKAGE}
cd Linux_for_Tegra/rootfs/
echo "Extracting ${SAMPLE_FS_PACKAGE}"
sudo tar xpf ${SAMPLE_FS_PACKAGE}
cd ..
sudo ./apply_binaries.sh
