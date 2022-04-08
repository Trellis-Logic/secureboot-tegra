#!/bin/bash
# See "Burning PKC [DK(KEK), SBK] Fuses" instructions at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0QF0HA
cd `dirname $0`
keyfile=rsa_priv.pem
sbkfile=sbk_hex_file
if [ ! -e ${keyfile} ]; then
    echo "please create a key file or use an existing one at path ${keyfile}"
    exit 1
fi
if [ ! -e ${sbkfile} ]; then
    echo "please create a SBK file or use an existing one at path ${sbk_hex_file}"
    exit 1
fi
read -p "Are you sure you want to burn the SBK and PKC fuses on this part?  This is not reversible.  Press y to continue:" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    set -e
    echo "Burning SBK and PKC fuses, leaving JTAG enabled"
    cd Linux_for_Tegra
    echo sudo ./odmfuse.sh -i 0x19 -c SBKPKC -p -k ../${keyfile} -S ../${sbkfile} jetson-agx-xavier-devkit
    sudo ./odmfuse.sh -i 0x19 -c SBKPKC -p -k ../${keyfile} -S ../${sbkfile} jetson-agx-xavier-devkit
fi
