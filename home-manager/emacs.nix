{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
    agda
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
      epkgs.evil
      epkgs.gruvbox-theme
      epkgs.agda2-mode
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

      ;; Disable bell and 'screen shake'
      (setq visible-bell 1)
      (setq ring-bell-function 'ignore)

      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (global-hl-line-mode +1)

      (set-frame-parameter nil 'alpha-background 90)
      (add-to-list 'default-frame-alist '(alpha-background . 90))

      (add-hook 'before-save-hook 'delete-trailing-whitespace)

      ;; Only display line numbers for programing language files
      (add-hook 'prog-mode-hook 'display-line-numbers-mode)

      (load-theme 'gruvbox-light-medium)
    '';
  };
}
