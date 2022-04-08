# Secure Boot for Tegra

This project contains a set of scripts to automate the secure boot process outlined
in the [Nvidia L4T Development Guide](https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fsecurity.html%23)

The scripts are currently hard-coded to use Jetson AGX Xavier as the target.

The scripts are for the ``32.7.1`` (``Jetpack 4.6.1``) release. To change the version, make changes to the ``downloadfilenames`` file.

CAUTION: These scripts are only known to be good and run on a bare-metal Ubuntu 18.04 system. A virtual machine or other distribution is not recommended and may lead to unexpected behavior and "brick" your board.

## Downloading Packages and preparing for use

Run

```shell
./download-and-prepare-files.sh
```

## Flashing stock image (optional)

Put your device in recovery mode, then run

```shell
./flashing-and-booting.sh
```

Verify your device boots successfully

## Installing secureboot

Run

```shell
./installing-secureboot.sh
```

To install secureboot

## Creating a Private Key

Following the instructions in [Generating the RSA Key Pair](https://docs.nvidia.com/jetson/l4t/index.html#page/Tegra%2520Linux%2520Driver%2520Package%2520Development%2520Guide%2Fbootloader_secure_boot.html%23wwpID0E0BH0HA) we will generate a key file, name it `rsa_priv.pem` and place it in the same directory as the scripts.



Run

```shell
./gen-keys.sh
```

The above script also generated:

* Secure Boot Key (SBK) `sbk_hex_file`
* 256-bit Key Encryption Key (KEK256) `kek2256_hex_file`
* 128-bit KEK2 `kek2_hex_file`
* 128-bit `user_key_hex_file`
* the public key `rsa_pub.pem` file

You should store these files in a secure location with access limited to only those that need them to sign and encrypt images.

## Test (Not Burn) the Fuses

Put the device into Forced Reset mode.

Run

```shell
./test-sbkpkc-kek2-kek256.sh 2>&1 | tee test.log
```

This simulates burning the ``PKC``, ``SBK``, ``KEK2`` and ``KEK256`` fuses on the part. This will generate an ``odmfuse_pkc.xml`` file in `Linux_For_Tegra/bootloader``.

Inspect the ``test.log`` file for any errors, warnings or unexpected behavior.

## Generate Factory Fuse Blob

Run

```shell
./gen-factory-sbkpkc-kek2-kek256-odmfuse-file.sh 2>&1 | tee factory.log
```

This will generate a ``fuseblob.tbz2`` file in ``Linux_for_Tegra/``

Inspect the ``factory.log`` for any errors, warnings or unexpected behavior.

## Comparing the results

Extract the ``fuseblob.tbz2`` file from above, e.g. into a directory named ``fuseblob``.
Compare the ``fuseblob/odmfuse_pkc.xml`` file to the ``Linux_for_Tegra/bootloader/odmfuse_pkc.xml`` file from the "test" script. Ensure that these files are identical.

If they are different, you probably have something wrong with the "factory" script. For example, if your device is in the _unfused_ state, but you pass ``--auth SBKPKC`` to ``odmfuse.sh`` it will NOT generate the ``SBK`` or ``PKC`` lines. This is because the ``odmfuse.sh`` script (in off-line mode e.g. ``--no-flash``) does not know the state of the device and makes assumptions based on the arguments passed to ``odmfuse.sh``.

An example (correct) ``odmfuse_pkc.xml`` would look like:

```xml
<genericfuse MagicId="0x45535546" version="1.0.0">
<fuse name="SecureBootKey" size="16" value="0x94f769b99cb6903309cfda062751216b" />
<fuse name="Kek2" size="16" value="206f34b0fd5072c15e683d5a0e6e3a77" />
<fuse name="Kek256" size="32" value="0a90d71dcdfb5930ebc8e7a6a85ae80eb140b691d0c9e7751f676443d560376f" />
<fuse name="PublicKeyHash" size="32" value="0xed32eb0a8e1cb8de800361a4618a9753051285afa795881d0c9cd6dda6f17ce8" />
<fuse name="BootSecurityInfo" size="4" value="0x6" />
<fuse name="SecurityMode" size="4" value="0x1" />
</genericfuse>
```

## Burning the fuses

NVidia recommends burning all the fuses at once, with the ``fuseblob.tbz2`` generated previously. Assuming you extracted this to ``fuseblob``, you are now ready to burn the fuses.

WARNING: The fuses can only be changed from a "zero" to a "one" once. The following command will permanently change the state of the fuses on your board. If anything was wrong in the prior steps, you might render your board unbootable.

Put the device into Forced Recovery mode.

Run

```shell
pushd fuseblob/bootloader
sudo ./fusecmd.sh
popd
```

## Signing SBKPKC image

Run

```shell
./signing-sbkpkc.sh
```

To sign your local images.

## Re-flash the device with signed images

Put your device in recovery mode.

Run

```shell
./bootloader-flash-signed.sh
```

To write signed images to the part

Confirm the device booted into the NVidia Ubuntu OS.

## Signing and Encrypting images with meta-tegra

You can now create your own images with [Secure Boot Support](https://github.com/OE4T/meta-tegra/wiki/Secure-Boot-Support) and sign and encrypt them at build time by putting the following in your ``local.conf``, ``<distro>.conf`` or a ``<machine>.conf``.

```bash
TEGRA_SIGNING_ARGS = "-u /path/to/rsa_priv.pem -v /path/to/sbk_hex_file"
```

The ``<image>.tegraflash.tgz`` can be expanded and installed as normal, but will include encrypted and signed artifacts.
