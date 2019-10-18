This project contains a set of scripts to automate the secure boot process outlined
in the [Nvidia L4T Development Guide](https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fsecurity.html%23)

The scripts are currently hard-coded to use Jetson TX2 as the target.

I'm not able to get the ```./burn-pkc.sh``` step to work on my setup at this time, see [this forum thread](https://devtalk.nvidia.com/default/topic/1064080/jetson-tx2/secure-boot-odmfuse-programming-step-fail-on-32-2-1/post/5393200) for details and current status.

# Downloading Packages and preparing for use
Run
```
./download-and-prepare-files.sh
```

# Flashing stock image (optional)
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
