{ pkgs, ...}:

{
  home.packages = with pkgs; [
    ghc
    haskell-language-server
    stack
  ];

  programs.vscode.userSettings = {
    haskell.serverExecutablePath = "\${HOME}/.nix-profile/bin/haskell-language-server";
  };
}
