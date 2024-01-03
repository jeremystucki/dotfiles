{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    clang
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
  ];
}

