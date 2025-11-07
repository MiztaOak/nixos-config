{ ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "se" ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Homepage = "previous-session";
      ExtensionSettings = {
        # Gruvbox theme
        "{21ab01a8-2464-4824-bccb-6db15659347e}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/gruvbox-material-soft-theme/latest.xpi";
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
        #Vimium
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        };
        #600% Sound volume
        "{c4b582ec-4343-438c-bda2-2f691c16c262}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/600-sound-volume/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      HardwareAcceleration = true;
      Preferences = {
        "privacy.clearOnShutdown.history" = false;
        "browser.urlbar.suggest.bookmark" = true;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.startup.couldRestoreSession.count" = 1;
        "browser.startup.homepage" = "about:home";
        "sidebar.verticalTabs" = true;
        #Kill all ai features
        "browser.ml.enable" = false; 
        "browser.ml.chat.enabled" = false; 
        "browser.ml.chat.sidebar" = false;
        "browser.ml.chat.menu" = false; 
        "browser.ml.chat.page" = false; 
        "extensions.ml.enabled" = false; 
        "browser.ml.linkPreview.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false; 
        "browser.tabs.groups.smart.userEnabled" = false;
        "pdfjs.enableAltTextModelDownload" = false; 
        "pdfjs.enableGuessAltText" = false; 
      };
    };
  };
}
