{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #Gnome
      gnome-tweaks
      gnomeExtensions.blur-my-shell
      gnomeExtensions.user-themes
      gnomeExtensions.vitals
      gnomeExtensions.vim-alt-tab
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.useless-gaps
      gnomeExtensions.search-light
  ];

  # Gnome settings and tweaks
  gtk = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
  };
  dconf = {
    enable = true;
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        user-themes.extensionUuid
        vitals.extensionUuid
        vim-alt-tab.extensionUuid
        appindicator.extensionUuid
        dash-to-dock.extensionUuid
        useless-gaps.extensionUuid
        search-light.extensionUuid
      ];
    };
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
