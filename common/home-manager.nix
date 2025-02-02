{ hostConfiguration, ... }:

{
  imports =
    [ ./apps.nix ]
    ++ map (x: ../components + x) [
      /alacritty.nix
      /android.nix
      /cli.nix
      /code.nix
      /databases.nix
      /dotnet.nix
      /git.nix
      /java.nix
      /rust.nix
      /tex.nix
      /tmux.nix
      /typst.nix
      /vim.nix
      /zsh.nix
    ];

  home.username = hostConfiguration.username;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
