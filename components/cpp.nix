{ pkgs, ... }:

{
  home.packages = with pkgs; [
    boost180
    cmake
    gcc12
    gdb
    ninja
  ];
}
