{ inputs, config, pkgs, ... }:
{
  # programs.librewolf = {
  #   enable = true;
  #
  #   settings = {
  #     "privacy.clearOnShutdown.history" = false;
  #     "ml.chat.enabled" = false;
  #   };
  #   search = {
  #     force = true;
  #     default = "DuckDuckGo";
  #     order = [ "DuckDuckGo" "Google" ];
  #   };
  # };
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    languagePacks = [ "en-US" "se" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Homepage = "previous-session";
      ExtensionSettings = {
        # Catpuccin Mocha - Lavender
        "{8446b178-c865-4f5c-8ccc-1d7887811ae3}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-lavender-git/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitdefender
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        # Hide youtube shorts
        "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/hide-youtube-shorts/latest.xpi";
          installation_mode = "force_installed";
        };
        # Return youtube dislike
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      HardwareAcceleration = true;
      Preferences = {
        "privacy.clearOnShutdown.history" = false;
        "ml.chat.enabled" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.startup.couldRestoreSession.count" = 1;
        "browser.startup.homepage" = "about:home";
        "sidebar.verticalTabs" = true;
      };
    };
  };
}
