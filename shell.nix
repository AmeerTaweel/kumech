# Development environment
# You can enter it through `nix develop` or (legacy) `nix-shell`
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      # Command Runner
      just

      # Network Tool
      nmap

      # NixOS SD Card Image Compression / Decompression
      zstd

      # Compress and Convert Videos
      # https://handbrake.fr/
      handbrake

      # Raspberry PI
      rpi-imager

      # Ground Control Software
      qgroundcontrol
    ];
  };
}
