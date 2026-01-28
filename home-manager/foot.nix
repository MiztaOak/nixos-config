{ pkgs, ... }: let
  # nix32Hash = nix-prefetch-url ${url}
  # hash = nix hash convert --hash-algo sha256 --from nix32 ${nix32Hash}
  gruvboxLightTheme = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/commit/135d4478a156ce2264afd0ee5203510132986381/themes/gruvbox-light";
    hash = "sha256-hU0BfTOQgleufVI+lCOU+o9c/jOYgm8nhF23IJUPzDI=";
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${gruvboxLightTheme}";
        term = "xterm-256color";
        shell="zsh";
        font = "JetBrainsMono Nerd Font Mono:size=12";
        dpi-aware = "yes";
        pad = "5x5 center-when-maximized-and-fullscreen";
      };
      colors = {
        alpha = 0.95;
      };
    };
  };
}
