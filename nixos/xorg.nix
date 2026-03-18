{ pkgs, ...}:
{
  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

    windowManager.i3 = {
      enable = false;
      extraPackages = with pkgs; [
        polybarFull
        maim
        feh
        xclip
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

  services.picom.enable = true;
}
