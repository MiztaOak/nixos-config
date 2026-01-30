{
  inputs,
  config,
  outputs,
  pkgs,
  ...
}:
let
  lib = pkgs.lib;
  symlinkRoot = "/home/goaty/nixos-config/dotfiles";

  dotfiles = import ./dotfiles.nix {
    inherit config lib symlinkRoot;
  };
in
{
  imports = [
    # ./firefox.nix
    ./rofi.nix
    ./qutebrowser.nix
    ./foot.nix
    ./theming.nix
    ./alacritty.nix
    ./helix.nix
    dotfiles
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home.username = "goaty";
  home.homeDirectory = "/home/goaty";

  home.packages = with pkgs; [

    hyfetch
    fastfetch

    vivaldi

    #Cloud
    nextcloud-client

    #Productivity
    obsidian
    libreoffice

    #Terminal
    fish

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    git-credential-oauth
    pavucontrol
    tree-sitter
    bc
    nautilus
    bitwarden-desktop
    evince
    gnome-calculator
    piper

    # misc
    tree
    cowsay
    fortune
    imagemagick

    # system tools
    sysstat
    lm_sensors # for `sensors` command

    #Media stuff
    vlc
    mpv
    swayimg
    krita
    rmpc
    openutau
    reaper

    #Gaming
    stable.vesktop
    bolt-launcher
    lutris
    wine
    protonup-qt
    wowup-cf
    melonDS
    inputs.nix-citizen.packages.${stdenv.hostPlatform.system}.rsi-launcher
    xivlauncher
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Johan Ek";
        email = "johan.ek@tuta.com";
      };
      credential = {
        helper = "oauth";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      hyfetch
    '';

    shellAliases = {
      switch = "nh os switch ~/nixos-config";
      update = "nh os switch ~/nixos-config --update";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "intheloop";
    };
  };

  # programs.git-credential-oauth = {
  #   enable = true;
  # };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  xresources.properties = {
    "*background" = "#ebdbb2";
    "*foreground" = "#282828";
  };

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "vivaldi.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    };
  };

  xdg.autostart = {
    enable = true;
    entries = [
      "${pkgs.mullvad-vpn}/share/applications/mullvad-vpn.desktop"
    ];
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
