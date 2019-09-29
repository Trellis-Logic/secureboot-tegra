#!/bin/bash
# See "Flashing and Booting the Target Device" at
# https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fflashing.html%23
cd `dirname $0`
cd Linux_for_Tegra
sudo ./flash.sh jetson-tx2 mmcblk0p1
