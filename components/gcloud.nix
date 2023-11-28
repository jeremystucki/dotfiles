{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    google-cloud-sdk
    google-cloud-sql-proxy
  ];
}
