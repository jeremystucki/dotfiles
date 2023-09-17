{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    typst
  ];

  programs.vscode.extensions = with pkgs-unstable.vscode-extensions; [
    nvarner.typst-lsp
  ];
}
