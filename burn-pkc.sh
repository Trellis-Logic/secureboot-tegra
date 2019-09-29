#!/bin/bash
# See "Burning PKC Fuses" instructions at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fbootloader_secure_boot.html%23wwpID0E0LG0HA
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
    echo sudo ./odmfuse.sh -j -i 0x18 -c PKC -p -k ../${keyfile} jetson-tx2
    sudo ./odmfuse.sh -j -i 0x18 -c PKC -p -k ../${keyfile} jetson-tx2
fi
