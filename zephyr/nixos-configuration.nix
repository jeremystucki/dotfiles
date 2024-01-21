{ ... }:

{
  imports = [
    ./nixos-hardware-configuration.nix
  ];

  networking.hostName = "zephyr-nixos";
}
