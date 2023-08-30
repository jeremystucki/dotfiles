{ pkgs, ... }:

{
  home.packages = with pkgs; [
    typst
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    nvarner.typst-lsp
  ];
}
