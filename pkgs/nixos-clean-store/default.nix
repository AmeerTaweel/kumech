# View configuration diff between last and current system builds
{ writeShellScriptBin, ... }:
writeShellScriptBin "nixos-clean-store" ''
  sudo nix-collect-garbage -d
  nix-collect-garbage -d
  nix-collect-garbage
  nix-store --gc
  nix-store --optimise
''
