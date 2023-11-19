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
      #colloid-icon-theme
      gruvbox-gtk-theme
      gruvbox-dark-icons-gtk

      # For AwesomeWM or i3
      rofi
      plank
      xfce.xfce4-appfinder
      xfce.xfce4-clipman-plugin
      xfce.xfce4-cpugraph-plugin
      xfce.xfce4-dict
      xfce.xfce4-fsguard-plugin
      xfce.xfce4-genmon-plugin
      xfce.xfce4-netload-plugin
      xfce.xfce4-panel
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-systemload-plugin
      xfce.xfce4-weather-plugin
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-xkb-plugin
      xfce.xfce4-notifyd
      xfce.xfdashboard



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
      #displayManager =  {
      #  sddm.enable = true;
      #  defaultSession = "plasmawayland";
      #};
      #desktopManager.plasma5.enable = true;

      # Enable XFCE4
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };

      displayManager = {
        lightdm = {
          enable = true;
        };
      };

      # Enable i3
      windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        polybar
        feh
        flameshot
     ];
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
