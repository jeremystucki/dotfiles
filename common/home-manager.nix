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
    /haskell.nix
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
}
