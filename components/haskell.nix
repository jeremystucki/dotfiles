{pkgs, ...}: {
  home.packages = with pkgs; [
    ghc
    haskell-language-server
    stack
  ];

  programs.vscode.profiles.default = {
    userSettings = {
      haskell.serverExecutablePath = "\${HOME}/.nix-profile/bin/haskell-language-server";
    };

    extensions = with pkgs.vscode-extensions; [
      haskell.haskell
      justusadam.language-haskell
    ];
  };
}
