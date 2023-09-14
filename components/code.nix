{ pkgs, ... }:

{
  home.packages = [ pkgs.nil ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      asciidoctor.asciidoctor-vscode
      asvetliakov.vscode-neovim
      editorconfig.editorconfig
      jnoortheen.nix-ide
    ];

    userSettings = {
      git.mergeEditor = true;
    };
  };

  programs.zsh.shellAliases.code = "codium";

  programs.vscode.userSettings = {
    vscode-neovim.neovimExecutablePaths.linux = "/home/jeremy/.nix-profile/bin/nvim";

    editor.fontFamily = "Input Sans";
    editor.cursorSurroundingLines = 8;

    nix = {
      enableLanguageServer = true;
      serverPath = "nil";
    };
  };
}
