{ lib, pkgs, ... }:
{

  #Configure neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = lib.fileContents ./neovim/init.vim;
    extraPackages = with pkgs; [
      nodejs
    ];
    plugins = [
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.catppuccin-nvim

      # Example Plugin: nvim-treesitter with Lua config
      {
        plugin = pkgs.vimPlugins.nvim-treesitter;
        config = ''
          packadd! nvim-treesitter
          lua <<EOF
            require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,              -- false will disable the whole extension
                disable = {},               -- list of languages that will be disabled
              },
              incremental_selection = {
                enable = true,
                keymaps = {
                  init_selection = "gnn",
                  node_incremental = "grn",
                  scope_incremental = "grc",
                  node_decremental = "grm",
                },
              },
              textobjects = {
                select = {
                  enable = true,
                  lookahead = true,
                  keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                  },
                },
              },
            }
          EOF
        '';
      }
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

}
