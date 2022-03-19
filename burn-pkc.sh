#!/bin/bash
# See "Burning PKC [DK(KEK), SBK] Fuses" instructions at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0QF0HA
cd `dirname $0`
keyfile=rsa_priv.pem
if [ ! -e ${keyfile} ]; then
    echo "please create a key file or use an existing one at path ${keyfile}"
    exit 1
fi
read -p "Are you sure you want to burn the PKC fuse on this part?  This is not reversible.  Press y to continue:" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    set -e
    echo "Burning PKC fuse, leaving JTAG enabled"
    cd Linux_for_Tegra
    echo sudo ./odmfuse.sh -i 0x19 -c PKC -p -k ../${keyfile} jetson-agx-xavier-devkit
    sudo ./odmfuse.sh -i 0x19 -c PKC -p -k ../${keyfile} jetson-agx-xavier-devkit
fi
