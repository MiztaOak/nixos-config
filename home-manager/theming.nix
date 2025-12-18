{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yazi
    cava
    wlogout
    wl-clipboard
    mako
    waybar

    grim
    slurp

    #should prob be replaced with swaylock
    hyprlock
  ];

  services.polkit-gnome.enable = true;
  services.mako.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
