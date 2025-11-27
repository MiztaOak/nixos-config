{
  config,
  outputs,
  pkgs,
  ...
}: let
  lib = pkgs.lib;
  symlinkRoot = "/home/goaty/nixos-config/dotfiles";

  dotfiles = import ./dotfiles.nix {
    inherit config lib symlinkRoot;
  };
in {
  imports = [
    ./firefox.nix
    ./nixvim.nix
    ./kitty.nix
    ./rofi.nix
    ./zed.nix
    ./niri.nix
    ./qutebrowser.nix
    ./foot.nix
    dotfiles
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      #neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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

    fastfetch

    #Cloud
    nextcloud-client

    #Productivity
    obsidian

    #Terminal
    kitty
    starship
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
    git-credential-manager
    pavucontrol
    tree-sitter
    bc
    nautilus
    bitwarden-desktop

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
    feishin
    nsxiv
    krita
    rmpc
    openutau
    reaper

    #Gaming
    vesktop
    bolt-launcher
    #TODO: remove unstable when lutris is no longer using depricated deps
    unstable.lutris
    wine
    protonup-qt
    wowup-cf
  ];


  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Johan Ek";
    userEmail = "johan.ek@tuta.com";
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "MiztaOak";
    extraConfig.credential.credentialStore = "cache";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Start the swww daemon
  services.swww.enable = true;

  xresources.properties = {
    "*background" =  "#282828";
    "*foreground" = "#ebdbb2";
  };

  # #cmus config
  # programs.cmus = {
  #   enable = true;
  #   theme = "gruvbox-alt";
  # };

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
