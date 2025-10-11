{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];
  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    nixpkgs.useGlobalPackages = true;
    dependencies.nodejs.enable = true;

    clipboard.register = "unnamedplus";
    clipboard.providers.wl-copy.enable = true;


    extraConfigVim = lib.fileContents ./neovim/init.vim;

    colorscheme = "gruvbox";
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "medium";
        transparentBg = true;
      };
    };

    plugins = {
      treesitter = {
        enable = true;

        nixvimInjections = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;
        };

      };

      telescope = {
        enable = true;

        highlightTheme = "catppuccin";

        keymaps = {
          # Find files using Telescope command-line sugar.
          "<leader><leader>" = "find_files";
          "<leader>/" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";
        };

        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
      };

      lazygit.enable = true;
      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

    };

    keymaps = [
      # Find TODOs
      {
        mode = "n";
        key = "<C-t>";
        action.__raw = ''
          function()
            require('telescope.builtin').live_grep({
              default_text="TODO",
              initial_mode="normal"
            })
          end
        '';
        options.silent = true;
      }
      # Lazygit
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
      }
      # Window splits
      {
        mode = "n";
        key = "<leader>|";
        action = "<cmd>vsplit<cr>";
      }
      # Window movement
      {
        mode = [
          "n"
          "t"
        ];
        key = "<leader>-";
        action = "<cmd>split<cr>";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-l>";
        action = "<C-w>l";
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
    ];
  };
}
