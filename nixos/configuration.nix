# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        polybarFull
        maim
        feh
        (pkgs.st.overrideAttrs (_: {
          src = inputs.st;
          patches = [ ];
        }))
      ];
    };

    # Configure keymap in X11
    xkb = {
      layout = "us,se";
      options = "grp:win_space_toggle";
    };

    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    enableCtrlAltBackspace = true;
    exportConfiguration = true;
  };

  # Remove the god awful mouse acceleration
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      middleEmulation = false;
    };
  };

  # # Enable the ly Desktop Environment.
  services.displayManager = {
    ly.enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaysome
      mako
      waybar
      foot
      rofi
      slurp
      grim
      wl-clipboard
      wlogout
      swaylock-effects
      btop
    ];
  };

  programs.mango = {
    enable = true;
  };

  # Enable screen sharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "enter";
            delete = "backspace";
          };
        };
      };
    };
  };

  # Mouse config service required by piper
  services.ratbagd.enable = true;

  # Enable Mullvad VPN
  services.mullvad-vpn = {
    enable = true;
    # enable gui application
    # package = pkgs.mullvad-vpn;
  };

  # Add support for svg icons
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.enableAllFirmware = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # MPD
  services.mpd = {
    enable = true;

    settings = {

      music_directory = "/home/goaty/Music";
      audio_output = [
        {
          type = "pipewire";
          name = "My PipeWire Output";
        }
        {
          type = "fifo";
          name = "my_fifo";
          path = "/tmp/mpd.fifo";
          format = "44100:16:2";
        }
      ];

    };
    user = "goaty";
    # Optional:
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
  };

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;

      auto-optimise-store = true;

      # Cachix for nix-citizen
      substituters = [ "https://nix-citizen.cachix.org" ];
      trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
    };

    optimise = {
      automatic = true;
      dates = [ "0:00" ];
    };

    #Currently replaced by nh
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 30d";
    # };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.goaty = {
    isNormalUser = true;
    description = "Goaty";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.backupFileExtension = "hm-backup";

  #Install steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  #Install and configure nh the nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 10";
    flake = "/home/goaty/nixos-config";
  };

  programs.obs-studio.enable = true;
  programs.obs-studio.enableVirtualCamera = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    fastfetch
    fzf
    git
    lazygit
    stow
    ripgrep
    ast-grep
    zip
    unzipNLS
    fd
    btop-rocm
    wget
    wl-clipboard
    gcc
    neovim
    inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww
    gruvbox-gtk-theme
    foot
    helix
    wlr-randr
  ];

  programs.zsh.enable = true;

  users.extraUsers.goaty = {
    shell = pkgs.zsh;
  };

  programs.dconf.enable = true;

  environment.variables.EDITOR = "hx";

  #Add nerd font
  fonts.packages = with pkgs; [
    font-awesome
    takao
    nerd-fonts.jetbrains-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
