{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      editorconfig.editorconfig
      haskell.haskell
      james-yu.latex-workshop
      justusadam.language-haskell
    ];
  };

  programs.zsh.shellAliases.code = "codium";
}
