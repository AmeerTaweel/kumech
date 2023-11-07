{
  description = "KUMechPI (Raspberry Pi 4 Model B Rev 1.5) Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    params = {
      system = "aarch64-linux";
      hostname = "kumechpi";
      username = "user";
      timezone = "Asia/Istanbul";
      state-version = "23.11";
    };
  in {
    nixosConfigurations.${params.hostname} = nixpkgs.lib.nixosSystem {
      inherit (params) system;
      specialArgs = {inherit inputs outputs params;};
      modules = [./configuration.nix];
    };
  };
}
