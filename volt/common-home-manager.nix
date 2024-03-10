{
  imports = map (x: ../components + x) [
    /alacritty.nix
    /cli.nix
    /code.nix
    /common-apps.nix
    /cpp.nix
    /dotnet.nix
    /gcloud.nix
    /git.nix
    #    /gnome.nix
    /haskell.nix
    /jetbrains.nix
    /postgres.nix
    /tex.nix
    /tmux.nix
    /typst.nix
    /vim.nix
    /zsh.nix
  ];

  home.username = "jeremy";
  home.homeDirectory = "/home/jeremy";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

  home.file.".config/alacritty/machine-specific-config.yml".source = ../resources/alacritty-volt.yml;

  programs.vscode.userSettings = {
    workbench.colorTheme = "Solarized Dark";
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/spotify/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/spotify" = {
      binding = "<Super>P";
      command = "sh -c 'wmctrl -xa Spotify || spotify'";
      name = "spotify nix";
    };
  };
}
