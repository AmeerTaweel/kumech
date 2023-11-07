# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using `nix build .#example` or (legacy) `nix-build -A example`
{pkgs ? (import ../nixpkgs.nix) {}}: {
  nixos-change-summary = pkgs.callPackage ./nixos-change-summary {};
  nixos-clean-store = pkgs.callPackage ./nixos-clean-store {};
}
