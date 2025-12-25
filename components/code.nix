{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = [pkgs.nil];

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;

    profiles.default = {
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
  };

  programs.vscode.profiles.default.userSettings = {
    vscode-neovim.neovimExecutablePaths.linux = "${config.home.homeDirectory}/.nix-profile/bin/nvim";
    window.autoDetectColorScheme = true;
    editor.cursorSurroundingLines = 8;

    nix = {
      enableLanguageServer = true;
      serverPath = "nil";
    };
  };
}
