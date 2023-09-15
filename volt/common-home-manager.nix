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
    /gnome.nix
    /haskell.nix
    /jetbrains.nix
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

  programs.git.includes = [
    {
      condition = "gitdir:~/Documents/Code/";
      contents = {
        user.email = "dev@jeremystucki.ch";
      };
    }
    {
      condition = "gitdir:~/Documents/Code/Valora/";
      contents = {
        user.email = "jeremy.stucki@valora.com";
      };
    }
    {
      condition = "gitdir:~/Documents/Code/GitLab-OST/";
      contents = {
        user.email = "jeremy.stucki@ost.ch";
      };
    }
  ];

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
