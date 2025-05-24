{pkgs-unstable, ...}: {
  home.packages = with pkgs-unstable; [
    typst
    tinymist
  ];

  programs.neovim.plugins = with pkgs-unstable.vimPlugins; [typst-vim];

  programs.vscode.profiles.default = {
    extensions = with pkgs-unstable.vscode-extensions; [
      myriad-dreamin.tinymist
      tomoki1207.pdf
    ];

    userSettings.typst-lsp = {
      exportPdf = "never";
    };
  };
}
