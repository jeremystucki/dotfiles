{ pkgs, ... }:

{
  home.packages = with pkgs; [
    boost180
    cmake
    gcc
    gdb
    ninja
  ];
}
