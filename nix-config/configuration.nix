## REMEMBER, IF YOU ARE USING THIS CONFIG, CHANGE THE HARDWARE-CONFIGURATION.NIX IN ORDER TO AVOID ISSUES. :D

{ config, pkgs, ... }:

{
  imports =
    [ 
     ./hardware-configuration.nix
    ];


  # Enabling flakes
  nix.settings.experimental-features = [ "nix-command" "flakes"];


  # Auto-update and Auto-Cleaning
   system.autoUpgrade = {
      enable = true;
  };

  #nix.package = pkgs.nixUnstable;
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  
  # Swappiness
  boot.kernel.sysctl = { "vm.swappiness" = 20;};

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "powr4e";

  # Default Kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # Xanmod Kernel
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Liquorix Kernel
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  
  # Zen Kernel
  #boot.kernelPackages = pkgs.linuxPackages_zen;

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

############################
######## DESKTOP ###########
############################

# Packages for plasma to work/have my config

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };



    # Enable window managers (Wayland)
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  #security.pam.services.gdm.enableGnomeKeyring = true;
  
  # Enable necessary services such as pipewire

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;

    # Libinput
   
    # Disable mouse acceleration
      libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        };
      };



    # Sound

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # X11 Activation, Display and Plasma

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      
      # gnome
      displayManager = {
        gdm = {
          enable = true;
          };
        };
      desktopManager.gnome.enable = true;


      # Enable bspWM
      windowManager.bspwm = {
        enable = true;
    };
  };
};

  # Disable pulse hardware
  hardware.pulseaudio.enable = false;

  #sound = {
  #  enable = true;
  #  mediaKeys.enable = true;
  #};




############################
####### PACKAGES ###########
############################

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
    heroic
    rofi
    python3Full
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    pulseaudio
    wineWowPackages.staging
    pamixer
    waybar
    htop
    jdk
    kdenlive
    obs-studio
    spicetify-cli
    mako
    wofi
    xdg-utils
    spicetify-cli
    distrobox
    adw-gtk3
    glib
    eww
    gcc
    playerctl
  
    #Gaming
    lutris
    gamescope
    xonotic
    #nix-gaming.packages.${pkgs.hostPlatform.system}.wine-tkg
    #nix-gaming.packages.${pkgs.hostPlatform.system}.proton-ge

    #Fish
    fishPlugins.pure

    #Sway
    swaybg

    #General
      chromium
      firefox
      blueman
      adw-gtk3
      #colloid-gtk-theme
      colloid-icon-theme
      gruvbox-gtk-theme
      gruvbox-dark-icons-gtk
      kde-gruvbox
      gnome-tweaks
      gnomeExtensions.unite

      # For AwesomeWM or i3
      rofi
      bspwm
      sxhkd
      lemonbar
      polybarFull
      feh
      dunst



  ];


#################################
  ######## Services ###############
  #################################

  # Pipewire cuz i fucked up something
  security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #  # If you want to use JACK applications, uncomment this
  #  #jack.enable = true;
  #};
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable printing
  services.printing.enable = true;

  # XDG Variables
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  # Udev Config
  services.udev.extraHwdb = ''
evdev:input:b0003v0C45pA512*
 KEYBOARD_KEY_70039=leftmeta

evdev:atkbd:dmi:*            
 KEYBOARD_KEY_3a=leftmeta
  '';

  # Docker
  virtualisation.docker.enable = true;
  
  # Enable dbus
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
  #rograms.dconf.enable = true;

  # Dri
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ]; 
  };
  
  # Intel
  hardware.cpu.intel.updateMicrocode = true;

  # Java
  programs.java.enable = true;

  # Font
  fonts.packages = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraCode" "CascadiaCode" "JetBrainsMono" "0xProto"]; })
  inter
];

  # Steam
  programs.steam = {
  	enable = true;
  	remotePlay.openFirewall = true;
  	dedicatedServer.openFirewall = true;
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
  #services.undervolt.enable = true;
  #services.undervolt.analogioOffset = -60;
  #services.undervolt.coreOffset = -50;
  #services.undervolt.gpuOffset = -50;
  #services.undervolt.p1.limit = 255;
  #services.undervolt.p1.window = 90000;
  #services.undervolt.p2.limit = 255;
  #services.undervolt.p2.window = 90000;

  # Flatpak
  services.flatpak.enable = true;

  # Power Profiles Daemon
  services.power-profiles-daemon.enable = true;
  
  # SSH
  services.openssh.enable = true;






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
