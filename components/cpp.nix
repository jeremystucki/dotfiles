{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang
    cmake
    jetbrains.clion
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
  ];
}
