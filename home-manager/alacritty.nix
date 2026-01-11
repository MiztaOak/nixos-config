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
        shell = "fish";
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
