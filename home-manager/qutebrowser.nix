{ pkgs, lib, ... } : {
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     qutebrowser-overlay = prev.qutebrowser.override {
  #       enableVulkan = true;
  #     };
  #   })
  # ];
  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser;
    loadAutoconfig = true;
    keyBindings = {
      normal = {
        "<ctrl-v>" = "spawn mpv {url}";
        "<ctrl-shift-v>" = "hint links spawn mpv {hint-url}";
      };
    };
    settings = {
      changelog_after_upgrade = "never";
      colors = {
        webpage.preferred_color_scheme = "light";
      };
      fonts = {
        default_family = "JetBrainsMono Nerd Font Mono";
        default_size = "12pt";
      };
    };
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&amp;go=Go&amp;ns0=1";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      np = "https://search.nixos.org/packages?query={}";
      sf = "https://scryfall.com/search?q={}";
    };
    extraConfig = lib.fileContents ./gruvbox-light.py;
  };

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "org.qutebrowser.qutebrowser.desktop";
  #     "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
  #     "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
  #     "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
  #     "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
  #   };
  # };
}
