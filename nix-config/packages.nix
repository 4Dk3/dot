{ pkgs, ... }:

{
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
    flameshot
    waybar
    htop
    jdk
    picom-next
    kdenlive
    obs-studio
    spicetify-cli
    mako
    wofi
    xdg-utils
    spicetify-cli
    spotify
    armcord
    distrobox
    adw-gtk3
    glib
  
    #Gaming
    lutris
    gamescope
    xonotic
    #nix-gaming.packages.${pkgs.hostPlatform.system}.wine-tkg
    #nix-gaming.packages.${pkgs.hostPlatform.system}.proton-ge

    #Fish
    fishPlugins.bobthefish

    #Sway
    swaybg
  ];
}
