{ pkgs, ... }:

{
  # Packages for plasma to work/have my config
  environment = {
    systemPackages = with pkgs; [

      #General
      chromium
      firefox
      blueman
      adw-gtk3
      picom-allusive
      #colloid-gtk-theme
      colloid-icon-theme
      gruvbox-gtk-theme
      gruvbox-dark-icons-gtk
      kde-gruvbox
      gnome.gnome-tweaks
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
      
      # Disable mouse acceleration
      libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        };
      };

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

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  
}
