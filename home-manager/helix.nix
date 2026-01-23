{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nil
    ];
    settings = {
      theme = "gruvbox_transparent";
      editor = {
        true-color = true;
        line-number = "relative";
        cursorline = true;
        auto-format = false;
      };
      editor.indent-guides = {
        character = "|";
        render = true;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      editor.statusline = {
        left = [
          "mode"
          "spinner"
          "version-control"
          "file-name"
        ];
      };
      editor.file-picker = {
        hidden = false;
      };
      keys.normal = {
        space.space = "file_picker";
        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";
      };

    };
    themes = {
      gruvbox_transparent = {
        "inherits" = "gruvbox_light";
        "ui.background" = { };
      };
    };
  };
}
