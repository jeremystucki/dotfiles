{ pkgs, pkgs-unstable, ... }:

{
  home.packages = [ pkgs.nil ];

  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      asciidoctor.asciidoctor-vscode
      asvetliakov.vscode-neovim
      editorconfig.editorconfig
      jnoortheen.nix-ide
    ];

    userSettings = {
      git.mergeEditor = true;
      workbench.colorTheme = "Solarized Dark";
    };
  };

  programs.vscode.userSettings = {
    vscode-neovim.neovimExecutablePaths.linux = "/home/jeremy/.nix-profile/bin/nvim";
    window.autoDetectColorScheme = true;
    editor.cursorSurroundingLines = 8;

    nix = {
      enableLanguageServer = true;
      serverPath = "nil";
    };
  };
}
