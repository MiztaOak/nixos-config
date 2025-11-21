{ pkgs, lib, ... } : {
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser-overlay = prev.qutebrowser.override {
        enableVulkan = true;
      };
    })
  ];
  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser-overlay;
    loadAutoconfig = true;
    keyBindings = {
      normal = {
        "<ctrl-v>" = "spawn mpv {url}";
        "<ctrl-shift-v>" = "hint links spawn mpv {hint-url}";
      };
    };
    settings = {
      colors = {
        webpage.preferred_color_scheme = "dark";
      };
      fonts = {
        default_family = "JetBrainsMono Nerd Font Mono";
        default_size = "12pt";
      };
    };
    extraConfig = lib.fileContents ./gruvbox.py;
  };
}
