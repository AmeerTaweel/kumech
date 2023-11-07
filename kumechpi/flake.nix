{
  description = "KUMechPI (Raspberry Pi 4 Model B Rev 1.5) Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    params = {
      system = "aarch64-linux";
      hostname = "kumechpi";
      username = "user";
      timezone = "Asia/Istanbul";
      state-version = "23.11";
      shell = "fish";
      wlan = "wlan0";
      gateway = "192.168.13.1";
    };
  in {
    # NixOS configuration entrypoint
    # Available through `nixos-rebuild --flake .#your-hostname`
    nixosConfigurations.${params.hostname} = nixpkgs.lib.nixosSystem {
      inherit (params) system;
      specialArgs = {inherit inputs outputs params;};
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${params.username} = {
            imports = [./home.nix];
            _module.args = {inherit inputs outputs params;};
          };
        }
      ];
    };
  };
}
