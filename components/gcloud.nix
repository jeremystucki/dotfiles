{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-cloud-sdk
    cloud-sql-proxy
  ];
}
