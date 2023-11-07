{pkgs, ...}: let
  shellAliases = {
    # Enable `grep` colors when the output is a terminal
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";

    # Fast `cd` to parent directory
    ".." = "cd ..";
    ".1" = "cd ..";
    ".2" = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";

    # Create parent directories on demand
    mkdir = "mkdir -pv";

    # Use Eza instead of ls
    ls = "eza";
    l = "ls -lHF";
    ll = "ls -lHF";
    la = "ls -lHFa";
    lla = "ls -lHFa";
    lt = "ls --tree";
    lta = "ls --tree -a";
    lS = "ls -1"; # one column
    lSa = "ls -1a";
    lx = "ls -lbhHigUmuSa@"; # list extended

    # Tolerate Mistakes
    sl = "ls";
    "cd.." = "cd ..";
  };
in {
  programs.bash = {
    interactiveShellInit = ''
      # Enable Vi bindings
      set -o vi
    '';
    inherit shellAliases;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Enable Vi bindings
      fish_vi_key_bindings
      # Use block cursor even in insert mode
      set -U fish_cursor_insert block
      # Turn off the greeting message
      set fish_greeting
    '';
    inherit shellAliases;
  };

  # Easy directory jumping in all shells
  programs.autojump.enable = true;

  programs.htop.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cht-sh # Access cheatsheets from terminal
    tldr

    file # Determina file type
    tree # List directory contents in a tree-like format
    curl # Transfer URLs
    btop # Modern `htop`
    eza # Modern `ls` replacement

    ffmpeg # Video Converter

    ripgrep # `grep` clone
    fd # `find` clone
    bat # `cat` clone with syntax highlighting and `git` integration

    zip # Zip Compression
    unzip # Zip Decompression

    entr # Run arbitrary commands when files change
    watch # Execute a command repeatedly, and monitor the output in full-screen mode

    sshfs
  ];
}
