{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    typst
    typst-lsp
  ];

  programs.neovim.plugins = with pkgs-unstable.vimPlugins; [ typst-vim ];

  programs.vscode = {
    extensions = with pkgs-unstable.vscode-extensions; [
      nvarner.typst-lsp
      tomoki1207.pdf
    ];

    userSettings.typst-lsp = {
      exportPdf = "never";
    };
  };
}
