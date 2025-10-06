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

  # Amd graphics drivers

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];

  fileSystems = {
    "/".options = [ "compress=zstd" ];
  };

  networking.hostName = "nixos-desktop";
}
