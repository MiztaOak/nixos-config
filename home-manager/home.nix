{ 
  inputs,
  outputs,
  lib,
  config,
  pkgs, 
  ... 
}: {
  imports = [
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

    # misc
    tree

    # system tools
    sysstat
    lm_sensors # for `sensors` command

    #Gaming + etc
    discord-ptb
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

  #Configure neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = lib.fileContents ./neovim/init.vim;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.catppuccin-nvim
    ];
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

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
