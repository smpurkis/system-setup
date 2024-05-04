{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    microsoft-edge
    vscode
    steam
    discord
    obsidian
    spotify
    discord

    git
    gh
    
    fish
    starship
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    killall

    rustup
  ];

  # programs.microsoft-edge.extraOpts = {
  #   "BrowserSignin" = 0;
  #   "SyncDisabled" = true;
  #   "PasswordManagerEnabled" = true;
  #   "SpellcheckEnabled" = true;
  #   "BrowserAddProfileEnabled" = false;
  #   "BrowserGuestModeEnabled" = false;
  #   "FamilySafetySettingsEnabled" = true;
  #   "ForceBingSafeSearch" = 2;
  #   "ForceGoogleSafeSearch" = true;
  #   "ForceYouTubeRestrict" = 1;
  #   "HubsSidebarEnabled" = false;
  #   "InPrivateModeAvailability" = 1;
  #   "SearchFiltersEnabled" = true;
  # };

  fonts.fontconfig.enable = true;

  programs.fish.enable = true;

  programs.starship = {
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sam/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
