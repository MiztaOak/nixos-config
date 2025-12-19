{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
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

    extraConfigLua = ''
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    '';

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
          fold.enable = true;
        };

      };

      telescope = {
        enable = true;

        highlightTheme = "gruvbox";

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
        settings = {
          signs = {
            add.text = "▎" ;
            change.text = "▎";
            delete.text = "";
            topdelete.text = "";
            changedelete.text = "▎";
            untracked.text = "▎";
          };
          signs_staged = {
            add.text = "▎";
            change.text = "▎";
            delete.text = "";
            topdelete.text = "";
            changedelete.text = "▎";
          };
        };
      };
      
      blink-cmp = {
        enable = true; 
        settings = {
          keymap = {
            preset = "super-tab";
          };
        };
      };

      blink-indent = {
        enable = true;
        settings = {
          scope = {
            underline = {
              enable = true;
            };
          };
        };
      };

      flash.enable = true;

      ts-comments.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "gruvbox";
          };
        };
      };

      mini-pairs = {
        enable = true;
        settings = {
          modes = {
            insert = true;
            command = true;
            terminal = false;
          };
          skip_next = ''[=[[%w%%%'%[%"%.%`%$]]=]''; 
          skip_ts = [
            "string"
          ];
          skip_unbalanced = true;
          markdown = true;
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            lua = [ "stylua" ];
            fish = [ "fish_indent" ];
            sh = [ "shfmt" ];
            nix = [ "nixfmt" ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
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
      # Conform
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>Format<cr>";
      }
    ];
  };
}
