# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "uas"
    "usbhid"
    "usb_storage"
    "xhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ca62bf97-ca05-43c6-95e1-c28df5de45a0";
    fsType = "ext4";
  };

  fileSystems."/home/jeremy/Documents" = {
    device = "/dev/disk/by-uuid/5fd3f27f-f766-4b84-839f-355f06c4de04";
    fsType = "ext4";
  };

  fileSystems."/home/jeremy/Games" = {
    device = "/dev/disk/by-uuid/2a697660-240b-446e-8c67-cb02e7be264a";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-119076f9-eea0-4e5f-bd28-a8620993ff06".device = "/dev/disk/by-uuid/119076f9-eea0-4e5f-bd28-a8620993ff06";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3698-B1B2";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/23bc6b92-e781-4f0a-8647-259692e7966c"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp6s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
