{ pkgs, ... }: let
  # nix32Hash = nix-prefetch-url ${url}
  # hash = nix hash convert --hash-algo sha256 --from nix32 ${nix32Hash}
  gruvboxLightTheme = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/commit/4fd682b4e8d985ce25d2bd599c1d855bc1489650/themes/gruvbox-light";
    hash = "sha256-XZbeR9JEF2DRsApettTM3gnmlOWp+369ROdnTECm2eQ=";
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${gruvboxLightTheme}";
        term = "foot";
        shell="zsh";
        font = "JetBrainsMono Nerd Font Mono:size=12";
        dpi-aware = "yes";
        pad = "5x5 center-when-maximized-and-fullscreen";
      };
      colors-light = {
        alpha = 0.9;
      };
    };
  };
}
