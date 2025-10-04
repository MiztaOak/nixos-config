{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./hardware-configuration.nix
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };

  networking.hostName = "nixos-desktop";
}
