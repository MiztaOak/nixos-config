#based on https://github.com/ncreep/nixos-examples-blog/blob/master/symlinks/5.lists.nix
{
  config,
  symlinkRoot,
  lib,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib) map mergeAttrsList;

  toSrcFile = name: "${symlinkRoot}/${name}";
  link = name: mkOutOfStoreSymlink (toSrcFile name);

  linkFile = name: {${name}.source = link name;};
  linkDir = name: {
    ${name} = {
      source = link name;
      recursive = true;
    };
  };

  confFiles = map linkFile [
    "rofi/gruvbox-material.rasi"
    "rofi/wallSelect.rasi"
  ];

  confDirs = map linkDir [
    "fastfetch"
    "mako"
    "hypr"
    "rmpc"
    "waybar"
    "wlogout"
    "niri"
    "fish"
    "cava"
    "ghostty"
  ];

  links = mergeAttrsList (confFiles ++ confDirs);
in {
  xdg.configFile = links;
}
