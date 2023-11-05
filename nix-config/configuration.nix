## REMEMBER, IF YOU ARE USING THIS CONFIG, CHANGE THE HARDWARE-CONFIGURATION.NIX IN ORDER TO AVOID ISSUES. :D

{ config, pkgs, ... }:

{
  imports =
    [ # Include hardware scans (UUI Labels), Desktop packages and configurations (Xfce, Sway, Hypr etc), Packages (All System packages) and All system variables (Printing, Bluetooth, Programs activation etc).
     ./hardware-configuration.nix
     ./desktop.nix
     ./packages.nix
     ./services-and-environment.nix
    ];

  # Auto-update and Auto-Cleaning
   system.autoUpgrade = {
      enable = true;
  };

  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "powr4e";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.powr4e = {
    isNormalUser = true;
    description = "powr4e";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define defaults shell system-wide
  environment.shells = with pkgs; [ fish ];

  # Solve a kinda buggy upgrade?
  nixpkgs.config.permittedInsecurePackages = [
                "electron-24.8.6"
  ];

################################################################################
################################ DON'T TOUCH ###################################
################################################################################





  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
