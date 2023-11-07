{ pkgs, ... }:

{
  # Packages for plasma to work/have my config
  environment = {
    systemPackages = with pkgs; [
      chromium
      firefox
      blueman
      adw-gtk3
      colloid-kde
      colloid-gtk-theme
      colloid-icon-theme
    ];
  };

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

    # Enable window managers along with xfce
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

    # Sound

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # X11 Activation, Display and XFCE

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      
      # Disable mouse acceleration

      libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        };
      };

      # Enable Plasma
      displayManager =  {
        sddm.enable = true;
        defaultSession = "plasmawayland";
      };
      desktopManager.plasma5.enable = true;

    };
  };

  # Disable pulse hardware
  hardware.pulseaudio.enable = false;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
}
