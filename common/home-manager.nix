{ pkgs, hostConfiguration, ... }:

{
  imports =
    map (x: ../components + x) [
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

  home = {
    stateVersion = "23.05";
    username = hostConfiguration.username;

    homeDirectory =
      if (pkgs.stdenv.isDarwin) then
        "/Users/${hostConfiguration.username}"
      else
        "/home/${hostConfiguration.username}";
  };

  programs.home-manager.enable = true;
}
