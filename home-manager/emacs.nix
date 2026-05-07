{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
      epkgs.evil
      epkgs.gruvbox-theme
    ];
    extraConfig = ''
      (setq inhibit-startup-screen t)
      (setq inhibit-startup-message t)
      (setq standard-indent 2)
      (set-fontset-font "fontset-default" 'unicode "JetBrainMono Nerd Font")

      ;; Enable Evil
      (setq evil-shift-width 2)
      (setq evil-undo-system 'undo-redo)
      (require 'evil)
      (evil-mode 1)

      (setq visible-bell 1)

      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (global-hl-line-mode +1)

      (add-hook 'before-save-hook 'delete-trailing-whitespace)

      ;; Only display line numbers for programing language files
      (add-hook 'prog-mode-hook 'display-line-numbers-mode)

      (load-theme 'gruvbox-light-medium)
    '';
  };
}
