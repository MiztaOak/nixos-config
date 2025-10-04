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

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ~/.config/hypr/hyprlandActual.conf";
    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
    settings = {
      # "$mod" = "SUPER";
      # bind = [
      #   "$mainMod, 1, split-workspace, 1"
      #   "$mainMod, 2, split-workspace, 2"
      #   "$mainMod, 3, split-workspace, 3"
      #   "$mainMod, 4, split-workspace, 4"
      #   "$mainMod, 5, split-workspace, 5"
      # ];
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
