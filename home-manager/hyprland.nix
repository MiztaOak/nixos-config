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
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   #package = pkgs.hyprland;
  #   xwayland.enable = true;
  #
  #   systemd.enable = true;
  #
  #   # settings = {
  #   #   exec-once = [
  #   #     "waybar"
  #   #   ];
  #   #
  #   #   input = {
  #   #     kb_layout = "us";
  #   #     follow_mouse = 1;
  #   #     sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
  #   #     touchpad = {
  #   #       natural_scroll = true;
  #   #     };
  #   #   };
  #   #
  #   # };
  # };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
  };
 }
