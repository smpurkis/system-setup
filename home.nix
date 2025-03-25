{ config, pkgs, ... }:

let
  # Function to create a wrapper for Electron apps that preserves desktop entries
  wrapElectronApp = pkg: name: pkgs.symlinkJoin {
    inherit name;
    paths = [ pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Find all desktop files and patch them
      find $out/share/applications -name "*.desktop" -exec sed -i \
        "s|Exec=${pkg}/bin/${name}|Exec=$out/bin/${name}|g" {} \;
      
      # Wrap the binary with --no-sandbox
      rm $out/bin/${name}
      makeWrapper ${pkg}/bin/${name} $out/bin/${name} \
        --add-flags "--no-sandbox"
    '';
  };
in
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
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Wrap Electron-based apps properly to preserve desktop entries
    # (wrapElectronApp microsoft-edge "microsoft-edge")
    microsoft-edge
    # (wrapElectronApp vscode "code")ˀ
    (wrapElectronApp discord "discord")
    (wrapElectronApp obsidian "obsidian")
    # Spotify might need the same treatment
    (wrapElectronApp spotify "spotify")
    
    # Non-Electron apps that don't need the sandbox workaround
    git
    gh
    wget
    
    fish
    starship
    killall
    htop

    rustup
    python3

    cmake
    gcc
    libgcc
    gnumake

    # cudatoolkit

    # docker
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

  targets.genericLinux.enable = true;
  xdg.enable = true;

  fonts.fontconfig.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Any fish shell initialization commands can go here
    '';
  };
  
  # Set fish as default shell
  home.shellAliases = {
    # Add any shell aliases here
  };
  
  # This will properly set fish as your default shell
  targets.genericLinux.extraXdgDataDirs = [];
  
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    if [[ -z "$INSIDE_EMACS" && -z "$TMUX" && -z "$FISH_INITIALIZED" ]]; then
      export FISH_INITIALIZED=1
      exec fish
    fi
  '';

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
    PATH = "$HOME/.nix-profile/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
