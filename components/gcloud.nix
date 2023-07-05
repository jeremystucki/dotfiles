{ pkgs, ... }:

{
  home.packages = [
    pkgs.google-cloud-sdk
    pkgs.cloud-sql-proxy
  ];
}
