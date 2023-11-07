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

Raspberry Pi:

- [Raspberry Pi Documentation - Getting Started](https://www.raspberrypi.com/documentation/computers/getting-started.html)
- [Raspberry Pi Documentation - Camera](https://www.raspberrypi.com/documentation/accessories/camera.html)
- [Raspberry Pi Companion with Pixhawk](https://docs.px4.io/main/en/companion_computer/pixhawk_rpi.html)

NixOS on Raspberry Pi:

- [Installing NixOS on a Raspberry Pi 4 Model B (nix.dev)](https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi)
- [NixOS on ARM](https://nixos.wiki/wiki/NixOS_on_ARM)
- [NixOS on ARM/Raspberry Pi 4](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_4)
- [NixOS on ARM/Raspberry Pi - Camera](https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi#Camera)
- [Installing NixOS on Raspberry Pi 4 (r/NixOS)](https://www.reddit.com/r/NixOS/comments/1531nyc/installing_nixos_on_raspberry_pi_4/)
- [Installing NixOS on Raspberry Pi 4 (Blog)](https://mtlynch.io/nixos-pi4/)
- [NixOS Hardware - Raspberry Pi 4](https://github.com/NixOS/nixos-hardware/tree/master/raspberry-pi/4)

[img-hydra]: https://hydra.nixos.org/job/nixos/trunk-combined/nixos.sd_image.aarch64-linux
