{
  config,
  params,
  pkgs,
  ...
}: {
  imports = [
    ./shell.nix
    ./tmux
    ./vim
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  home = {
    inherit (params) username;
    homeDirectory = "/home/${params.username}";
  };

  home.sessionVariables = {
    FLAKEDIR = "${config.home.homeDirectory}/kumech/${params.hostname}";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
  };

  programs.fish.shellAbbrs = let
    flake-dir = config.home.sessionVariables.FLAKEDIR;
    flake = "${flake-dir}#${params.hostname}";
    nix-summary = "${pkgs.nixos-change-summary}/bin/nixos-change-summary";
  in {
    nx-boot = "sudo nixos-rebuild boot --flake ${flake} && ${nix-summary}";
    nx-build = "nixos-rebuild build --flake ${flake}";
    nx-switch = "sudo nixos-rebuild switch --flake ${flake} && ${nix-summary}";
    nx-summary = nix-summary;
  };

  xdg.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = params.state-version;
}
