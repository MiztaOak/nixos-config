{ inputs, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
    waybar
    yazi
    wlogout
    fuzzel
    waypaper
    swaylock
    cava
    libnotify

    hyprpaper
    hyprlock
    hyprpicker
  ];

  services.mako.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
  };
 }
