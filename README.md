This project contains a set of scripts to automate the secure boot process outlined
in the [Nvidia L4T Development Guide](https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fsecurity.html%23)

The scripts are currently hard-coded to use Jetson TX2 as the target

# Downloading Packages

Download from Jetson [https://developer.nvidia.com/embedded/linux-tegra-archive](archive page) and place in a "Downloads" directory.
You will need:
* Tegra186_Linux_R32.2.1_aarch64.tbz2
* Tegra_Linux_Sample-Root-Filesystem_R32.2.1_aarch64.tbz2
* secureboot_R32.2.1_aarch64.tbz2
TODO: auto download these with a download script

# Preparing for use
Run 
```
./preparing-for-use.sh
```
Put your device in recovery mode, then run
```
./flashing-and-booting.sh
```
Verify your device boots successfully

# Installing secureboot
Run
```
./installing-secureboot.sh
```
To install secureboot

# Creating a Private Key
Follow the instructions in [Generating the RSA Key Pair](https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fbootloader_secure_boot.html%23wwpID0E0BH0HA) to generate a key file, name it rsa_priv.pem and place it in the same directory as the scripts.

# Burning Fuses
Run
```
./burn-pkc.sh
```
To burn the PKC fuse on the part

# Signing PKC image
Run
```
./signing-pkc.sh
```
To sign your local images

# Re-flash the bootloader with signed images
Put your device in recovery mode.
Run
```
./bootloader-flash-signed.sh
```
To write signed images to the part
