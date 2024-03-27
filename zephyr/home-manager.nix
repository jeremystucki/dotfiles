{
  targets.genericLinux.enable = true;

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
    /node.nix
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

  home.file.".config/alacritty/machine-specific-config.yml".text = "";

  programs.zathura.enable = true;

  programs.vscode.userSettings = {
    workbench.colorTheme = "Default Light+";
  };
}
