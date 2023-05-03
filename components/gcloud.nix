{ pkgs, ... }:

{
  home.packages = [
    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.cloud-datastore-emulator
    ])
  ];
}
