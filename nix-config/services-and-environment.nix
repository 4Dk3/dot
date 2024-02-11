{ pkgs, ...}:

{

  #################################
  ######## Services ###############
  #################################

  # Pipewire cuz i fucked up something
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  
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




}
