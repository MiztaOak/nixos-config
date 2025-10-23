{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xwayland-satellite

    waybar
    yazi
    cava
    wlogout
    wl-clipboard
    mako
    swaylock
  ];

  services.polkit-gnome.enable = true;
  services.mako.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
