{
  params,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./custom-pkgs-overlay.nix
    ./nix.nix
    ./nix-index.nix
  ];

  boot.initrd.availableKernelModules = [
    "usbhid"
    "usb_storage"
    "vc4"
    "pcie_brcmstb" # required for the pcie bus to work
    "reset-raspberrypi" # required for vl805 firmware to load
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Headless / No Graphical Session
  services.xserver.enable = false;
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Hostname
  networking.hostName = params.hostname;

  # Timezone
  time.timeZone = params.timezone;

  # Internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Define user account
  # Set a password with `passwd`
  users.users.${params.username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    initialPassword = params.username;
    shell = pkgs.${params.shell};
  };

  # Enable popular shells
  programs = {
    fish.enable = true;
    zsh.enable = true;
  };

  # Git Configuration
  programs.git = {
    enable = true;
    config.init.defaultBranch = "master";
  };

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    nixos-change-summary
    nixos-clean-store
    rpi-update-firmware
  ];

  # Enable all the firmware with a license allowing redistribution
  hardware.enableRedistributableFirmware = true;
  # Load the wireless regulatory database at boot
  hardware.wirelessRegulatoryDatabase = true;

  # Networking
  networking.networkmanager.enable = true;
  # We want to use the wireless interface to create an aceess point
  # Don't manage the interface by `networkmanager`
  networking.networkmanager.unmanaged = ["interface-name:${params.wlan}"];

  # Access Point Configuration
  services.dnsmasq.enable = true;
  services.create_ap = {
    enable = true;
    settings = {
      CHANNEL = "default";
      GATEWAY = params.gateway;
      WPA_VERSION = 2;
      ETC_HOSTS = 0;
      DHCP_DNS = "gateway";
      NO_DNS = 0;
      NO_DNSMASQ = 0;
      HIDDEN = 0;
      MAC_FILTER = 0;
      ISOLATE_CLIENTS = 0;
      SHARE_METHOD = "none";
      IEEE80211N = 0;
      IEEE80211AC = 0;
      HT_CAPAB = "[HT40+]";
      VHT_CAPAB = "";
      DRIVER = "nl80211";
      NO_VIRT = 1;
      FREQ_BAND = "2.4";
      DAEMONIZE = 0;
      DAEMON_PIDFILE = "";
      DAEMON_LOGFILE = "/dev/null";
      NO_HAVEGED = 1;
      WIFI_IFACE = params.wlan;
      SSID = params.hostname;
      PASSPHRASE = "";
      USE_PSK = 0;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Local DNS
  # Lets hosts on the same network address the device by name
  services.resolved.enable = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;
  services.avahi.enable = true;

  # This option defines the first version of NixOS you have installed on this
  # particular machine, and is used to maintain compatibility with application
  # data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for
  # any reason, even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are
  # pulled from, so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your
  # system is out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes
  # it would make to your configuration, and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = params.state-version; # Did you read the comment?
}
