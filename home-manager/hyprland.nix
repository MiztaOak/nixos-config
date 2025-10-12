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
    swaylock
    cava
    libnotify

    # hyprpaper
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

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ~/.config/hypr/hyprlandActual.conf";
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
    settings = {
      plugin = {
        split-monitor-workspaces = {
          count = 5;
          keep_focused = 0;
          enable_notifications = 0;
          enable_persistent_workspaces = 1;
        };
      };
    };
  };
 }
