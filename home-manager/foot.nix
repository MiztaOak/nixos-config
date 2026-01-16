{ pkgs, ... }: let
  # nix32Hash = nix-prefetch-url ${url}
  # hash = nix hash convert --hash-algo sha256 --from nix32 ${nix32Hash}
  gruvboxTheme = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/gruvbox-dark";
    hash = "sha256-ubvnLgDEPGvNrwQdZRNguftg2SF5qcO1iVK0Tb5ZveI=";
  };
  # gruvboxLightTheme = pkgs.fetchurl {
  #   url = "https://codeberg.org/dnkl/foot/raw/commit/aa26676c43edf2cfcc3543a443a25e881e34473e/themes/gruvbox-light";
  #   hash = "sha256-XZbeR9JEF2DRsApettTM3gnmlOWp+369ROdnTECm2eQ=";
  # };
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
        shell="fish";
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
