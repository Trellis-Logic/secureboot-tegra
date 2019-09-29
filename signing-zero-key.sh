#!/bin/bash
# See "Signing and Flashing Boot Files" section, sign and flash in separate steps
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0MF0HA
cd `dirname $0`
cd Linux_for_Tegra
sudo ./flash.sh --no-flash jetson-tx2 mmcblk0p1
