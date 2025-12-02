{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 14";
    theme = "~/.config/rofi/gruvbox-material.rasi";
    terminal = "kitty";
    modes = [
      "drun"
      "combi"
      "window"
    ];
    extraConfig = {
      show-icons = true;
      sort = true;
      matching = "fuzzy";
      display-ssh = "󰣀 ssh:";
      display-run = "󱓞 run:";
      display-drun = "󰣖 ";
      display-window = "󱂬 window:";
      display-dmenu = "󱂬 window:";
      display-combi = "󰕘 >";
      display-filebrowser = "󰉋 filebrowser:";
    };
  };
}
