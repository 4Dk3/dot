# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: let
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
  in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Overlays

  # Waybar experimental overlay
    nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];


  # Cachix for gaming
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Auto-update and Auto-Cleaning
   system.autoUpgrade = {
      enable = true;
  };

  nix.settings.auto-optimise-store = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "powr4e";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  xdg-desktop-portal-gnome
  gnome-tour
]);

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    };


  # Configure keymap in X11
  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.powr4e = {
    isNormalUser = true;
    description = "powr4e";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "docker"];
  };

  # Define defaults shell system-wide
  environment.shells = with pkgs; [ fish ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install system packages
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    neovim
    wget
    git
    neofetch
    alacritty
    pavucontrol
    docker
    vscode
    rofi
    python3Full
    pulseaudio
    wineWowPackages.staging
    pamixer
    blueman
    lxappearance
    flameshot
    waybar
    htop
    jdk
    picom-next
    kdenlive
    obs-studio
    mako
    wofi
    xdg-utils
  
    #Gaming
    lutris
    gamescope
    #nix-gaming.packages.${pkgs.hostPlatform.system}.wine-tkg
    #nix-gaming.packages.${pkgs.hostPlatform.system}.proton-ge

    #Fish
    fishPlugins.bobthefish

    #Gnome
    gnomeExtensions.unite
    gnomeExtensions.just-perfection
    gnomeExtensions.dock-from-dash
    gnome.gnome-tweaks
    adw-gtk3

    #Sway
    swaybg
  ];	

  #################################
  ##### Environment Variables #####
  #################################

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  services.udev.extraHwdb = ''
evdev:input:b0003v04D9p1503*
 KEYBOARD_KEY_70039=leftmeta

evdev:atkbd:dmi:*            
 KEYBOARD_KEY_3a=leftmeta
  '';

  #################################
  ######## Services ###############
  #################################
  
  # Blueman
  services.blueman.enable = true;

  # DBUS
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  programs.dconf.enable = true;

  # Dri
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ]; 
  };
  
  # Intel
  hardware.cpu.intel.updateMicrocode = true;

  # Java
  programs.java.enable = true;

  # Font
  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "CascadiaCode" ]; })
];

  # Steam
  programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  	dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};
  programs.gamemode.enable = true;

  # Shell
  programs.fish.enable = true;

  # Brightness
  programs.light.enable = true;

  # Media codecs for fastest video playback
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Undervolt
  services.undervolt.enable = true;
  services.undervolt.analogioOffset = -60;
  services.undervolt.coreOffset = -50;
  services.undervolt.gpuOffset = -50;
  services.undervolt.p1.limit = 255;
  services.undervolt.p1.window = 90000;
  services.undervolt.p2.limit = 255;
  services.undervolt.p2.window = 90000;

  # Flatpak
  services.flatpak.enable = true;

  # Power Profiles Daemon
  services.power-profiles-daemon.enable = true;
  
  # SSH
  services.openssh.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
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
