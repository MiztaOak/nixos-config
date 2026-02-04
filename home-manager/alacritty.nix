{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fish
    ueberzugpp
  ];

  programs.alacritty = {
    enable = true;
    theme = "gruvbox_light";
    settings = {
      terminal = {
        shell = "zsh";
      };
      env = {
        XINIT_X11_SCALE_FACTOR = "1.0";
      };
      font = {
        size = 12;
      };
      font.normal = {
        family = "JetBrainsMono Nerd Font Mono";
      };
      window.padding = {
        x = 10;
        y = 5;
      };
      window = {
        opacity = 0.95;
      };
      general = {
        live_config_reload = true;
      };
    };
  };
}
