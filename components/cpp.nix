{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gdb
    gcc
    cmake
    ninja
  ];
}
