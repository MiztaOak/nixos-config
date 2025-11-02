{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # services.xserver.desktopManager.gnome.enable = true;
  #
  # environment.gnome.excludePackages = (with pkgs; [
  #     atomix # puzzle game
  #     cheese # webcam tool
  #     epiphany # web browser
  #     # evince # document viewer
  #     geary # email reader
  #     gedit # text editor
  #     gnome-characters
  #     gnome-music
  #     gnome-photos
  #     gnome-terminal
  #     gnome-tour
  #     hitori # sudoku game
  #     iagno # go game
  #     tali # poker game
  #     totem # video player
  # ]);

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    sync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  networking.hostName = "nixos-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
