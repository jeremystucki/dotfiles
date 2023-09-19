{ pkgs, ... }:

{
  home.packages = with pkgs; [
    boost180
    cmake
    gcc12
    gdb
    ninja
  ];

  programs.vscode.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
    ms-vscode.cmake-tools
  ];
}

