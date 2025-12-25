{
  pkgs,
  hostConfiguration,
  ...
}: {
  imports = map (x: ../components + x) [
    /android.nix
    /apps.nix
    /cli.nix
    /code.nix
    /databases.nix
    /dotnet.nix
    /fish.nix
    /ghostty.nix
    /git.nix
    /haskell.nix
    /java.nix
    /rust.nix
    /tmux.nix
    /typst.nix
    /vim.nix
    /web.nix
    /zsh.nix
  ];

  home = {
    stateVersion = "23.05";
    inherit (hostConfiguration) username;

    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${hostConfiguration.username}"
      else "/home/${hostConfiguration.username}";
  };

  programs.home-manager.enable = true;
}
