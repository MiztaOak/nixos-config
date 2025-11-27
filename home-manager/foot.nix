{ pkgs, ... }: let
  # nix32Hash = nix-prefetch-url ${url}
  # hash = nix hash convert --hash-algo sha256 --from nix32 ${nix32Hash}
  gruvboxTheme = pkgs.fetchurl {
    url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/gruvbox-dark";
    hash = "sha256-ubvnLgDEPGvNrwQdZRNguftg2SF5qcO1iVK0Tb5ZveI=";
  };
in {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        include = "${gruvboxTheme}";
        term = "xterm-256color";
        shell="fish";
        font = "JetBrainsMono Nerd Font Mono:size=12";
        dpi-aware = "yes";
      };
      colors = {
        alpha = 0.95;
      };
    };
  };
}
