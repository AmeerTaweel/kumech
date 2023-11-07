# KUMech Software Team

## Device

- Raspberry Pi 4 Model B Rev 1.5
- Raspberry Pi Camera Module 2

## First-Time Setup

Download a recent NixOS `aarch64` live image from [Hydra][img-hydra], by
clicking on the latest successful build (marked with a green checkmark), and
copying the link to the build product image.


Uncompress the downloaded `.zstd` file by:

```bash
unzstd $IMG_NAME.img.zst
```

Fash the uncompressed image to the SD Card with:

```bash
sudo dd if=$IMG_NAME.img of=/dev/sdX bs=4096 conv=fsync status=progress
sync
```

Insert the SD Card to the Raspberry Pi and power it on.

On the Raspberry Pi:

- Clone this repository.
- `cd` into the root of this repository.
- Run `sudo nixos-rebuild boot --flake kumechpi#kumechpi`.
- Reboot the Raspberry Pi.
- Remove the old home directory at `/home/nixos`.
- Set password for normal user and root user using `passwd`.

## Usage

- There is a NixOS module available.
- Connect to the access-point created by the Raspberry Pi and `ssh` by hostname.
- Check the `justfile` for recipes.
- Check shell abbreviations and aliases for useful shortcuts.

## Resources

- [Raspberry Pi Documentation - Getting Started](https://www.raspberrypi.com/documentation/computers/getting-started.html)
- [Raspberry Pi Documentation - Camera](https://www.raspberrypi.com/documentation/accessories/camera.html)
- [Raspberry Pi Companion with Pixhawk](https://docs.px4.io/main/en/companion_computer/pixhawk_rpi.html)

[img-hydra]: https://hydra.nixos.org/job/nixos/trunk-combined/nixos.sd_image.aarch64-linux
