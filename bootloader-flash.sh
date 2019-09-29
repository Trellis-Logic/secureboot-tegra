#!/bin/bash
# See section 2. Flash of 
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/bootloader_secure_boot.html#wwpID0E0MF0HA
cd `dirname $0`
cd Linux_for_Tegra
cd bootloader
sudo bash ./flashcmd.txt
