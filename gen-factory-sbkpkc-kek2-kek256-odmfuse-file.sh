#!/bin/bash
# See "Burning PKC [DK(KEK), SBK] Fuses" instructions at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0QF0HA
cd `dirname $0`
keyfile=rsa_priv.pem
sbkfile=sbk_hex_file
kek2file=kek2_hex_file
kek256file=kek256_hex_file
chipid=0x19
FAB=400
BOARDID=2888
BOARDSKU=0001
BOARDREV=L.0
TargetBoard=jetson-agx-xavier-devkit
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
read -p "Are you sure you want to generate the factory fuseblob.tbz2 with the SBK and PKC fuses? Press y to continue:" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    set -e
    echo "Generating factory fuseblob.tbz2 with SBK, PKC, KEK2 and KEK256 fuses, leaving JTAG enabled"
    cd Linux_for_Tegra
    if  ! command -v ./odmfuse.sh ; then
	    echo "Please run ./install-secureboot.sh before running this script"
	    exit 1
    fi
    # Odmfuse requires variable FAB, BOARDID, BOARDSKU and BOARDREV in order to run in the offline mode.
    # Otherwise odmfuse needs to access on board EEPROM. Make sure the board is in recovery mode.
    # Board ID(2888) version(400) sku(0001) revision(L.0)
    # As the board is unfused, the --auth mode is NS in order to generate all the fuses.
    echo sudo FAB=${FAB} BOARDID=${BOARDID}  BOARDSKU=${BOARDSKU}  BOARDREV=${BOARDREV} ./odmfuse.sh -i ${chipid} -p --noburn --auth NS -k ../${keyfile} --KEK2 ../${kek2file} --KEK256 ../${kek256file} -S ../${sbkfile} ${TargetBoard}
    sudo FAB=${FAB} BOARDID=${BOARDID}  BOARDSKU=${BOARDSKU}  BOARDREV=${BOARDREV} ./odmfuse.sh -i ${chipid} -p --noburn --auth NS -k ../${keyfile} --KEK2 ../${kek2file} --KEK256 ../${kek256file} -S ../${sbkfile} ${TargetBoard}
fi
