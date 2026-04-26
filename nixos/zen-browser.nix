
{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    # Check these out at about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "privacy.clearOnShutdown.history" = false;
    "browser.urlbar.suggest.bookmark" = true;
    "browser.urlbar.suggest.engines" = false;
    "browser.urlbar.suggest.openpage" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.urlbar.suggest.topsites" = false;
    "browser.urlbar.suggest.history" = false;
    "browser.startup.couldRestoreSession.count" = 1;
    # Fix the broken tab discard
    "browser.low_commit_space_threshold_percent" = 100;
    "browser.tabs.unloadOnLowMemory" = true;
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

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
    (extension "hide-youtube-shorts" "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}")
    (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
    (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
    # ...
  ];

in
{
  environment.systemPackages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList (
            name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
          ) prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          Homepage = "previous-session";
          GenerativeAI = {
            Enabled = false;
            ChatBot = false;
            LinkPreviews = false;
            TabGroups = false;
          };
          OfferToSaveLogins = false;
          PasswordManagerEnabled = false;
          HardwareAcceleration = true;
          PromptForDownloadLocation = true;
          AutofillCreditCardEnabled = false;

          ExtensionSettings = builtins.listToAttrs extensions;

          SearchEngines = {
            Default = "ddg";
            Add = [
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
            ];
          };
        };
      }
    )
  ];
}
