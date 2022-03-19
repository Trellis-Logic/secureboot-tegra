#!/bin/bash
# See "Burning PKC [DK(KEK), SBK] Fuses" instructions at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0QF0HA
cd `dirname $0`
keyfile=rsa_priv.pem
sbkfile=sbk_hex_file
kek2file=kek2_hex_file
kek256file=kek256_hex_file
if [ ! -e ${keyfile} ]; then
    echo "please create a key file or use an existing one at path ${keyfile}"
    exit 1
fi
if [ ! -e ${sbkfile} ]; then
    echo "please create a SBK file or use an existing one at path ${sbkfile}"
    exit 1
fi
if [ ! -e ${kek2file} ]; then
    echo "please create a KEK2 file or use an existing one at path ${kek2file}"
    exit 1
fi
if [ ! -e ${kek256file} ]; then
    echo "please create a KEK256 file or use an existing one at path ${kek256file}"
    exit 1
fi
read -p "Are you sure you want to test (not burn) the SBK and PKC fuses on this part?  Press y to continue:" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    set -e
    echo "Testing (not burning) SBK, PKC, KEK2 and KEK256 fuses, leaving JTAG enabled"
    cd Linux_for_Tegra
    echo sudo ./odmfuse.sh --test -i 0x19 -c SBKPKC -p -k ../${keyfile} -S ../${sbkfile} --KEK2 ../${kek2file} --KEK256 ../${kek256file} jetson-agx-xavier-devkit
    sudo ./odmfuse.sh --test -i 0x19 -c SBKPKC -p -k ../${keyfile} -S ../${sbkfile} --KEK2 ../${kek2file} --KEK256 ../${kek256file} jetson-agx-xavier-devkit
fi
