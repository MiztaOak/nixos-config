{ pkgs, inputs, ...}:
{
  services.xserver = {
    enable = true;

    videoDrivers = [ "amdgpu" ];

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        polybarFull
        maim
        feh
        xclip
        (pkgs.st.overrideAttrs (_: {
          src = inputs.st;
          patches = [ ];
        }))
        ueberzugpp # Need for yazi to be able to display images
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

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(200,300)";
        height = "(0,150)";
        offset = "(30,50)";
        origin=  "top-right";
        transparency = "10";
        background = "#fbf1c7";
        foreground = "#3c3836";
        frame_color = "#076678";
        font = "JetBrainsMono Nerd Font 10";
      };
    };
  };
}
