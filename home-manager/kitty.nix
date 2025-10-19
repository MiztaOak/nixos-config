{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fish
    starship
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 12;
    };

    settings = {
      shell = "fish";
      enable_audio_bell = false;
      hide_window_decorations = true;
      enabled_layouts = "splits:split_axis=horizontal";
      background_opacity = 0.95;
    };

    keybindings = {
      "alt+-" = "launch --location=hsplit";
      "alt+|" = "launch --location=vsplit";

      "alt+h" = "neighboring_window left";
      "alt+l" = "neighboring_window right";
      "alt+k" = "neighboring_window up";
      "alt+j" = "neighboring_window down";

      "kitty_mod+k" = "scroll_line_up";
      "kitty_mod+j" = "scroll_line_down";
      "kitty_mod+l" = "next_tab";
      "kitty_mod+h" = "previous_tab";
    };

    themeFile = "GruvboxMaterialDarkHard";
  };
}
