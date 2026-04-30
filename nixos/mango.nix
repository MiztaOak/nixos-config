{ pkgs, ...}:
{
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    mako
    waybar
    foot
    rofi
    slurp
    grim
    wl-clipboard
    btop
  ];
}
