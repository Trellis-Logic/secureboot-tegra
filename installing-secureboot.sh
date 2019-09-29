#!/bin/bash
# See https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fbootloader_secure_boot.html%23wwpID0E0ZH0HA
set -e
cd `dirname $0`
SECUREBOOT_PACKAGE_NAME=secureboot_R32.2.1_aarch64.tbz2
sudo tar xvjf Downloads/${SECUREBOOT_PACKAGE_NAME}
