{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    typst
    typst-lsp
  ];

  programs.vscode.extensions = with pkgs-unstable.vscode-extensions; [
    nvarner.typst-lsp
    tomoki1207.pdf
  ];
}
