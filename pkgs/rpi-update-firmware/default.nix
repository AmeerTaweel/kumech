# Update Raspberry Pi firmware
{
  raspberrypi-eeprom,
  writeShellScriptBin,
  ...
}:
writeShellScriptBin "rpi-update-firmware" ''
  sudo mount /dev/disk/by-label/FIRMWARE /mnt
  sudo BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable ${raspberrypi-eeprom}/bin/rpi-eeprom-update -d -a
  sudo umount /mnt
''
