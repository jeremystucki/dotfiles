{ config, ... }:

{
  imports = [
    ./nixos-hardware-configuration.nix
  ];

  # Enable swap on luks
  boot.initrd.luks.devices."luks-e0d59253-c3ee-4fab-8ce0-182877db57c3".device = "/dev/disk/by-uuid/e0d59253-c3ee-4fab-8ce0-182877db57c3";
  boot.initrd.luks.devices."luks-e0d59253-c3ee-4fab-8ce0-182877db57c3".keyFile = "/crypto_keyfile.bin";

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  networking.hostName = "volt-nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Enable power management (do not disable this unless you have a reason to).
    # Likely to cause problems on laptops and with screen tearing if disabled.
    powerManagement.enable = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "jeremy";
  };

  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

#  environment.systemPackages = with pkgs.gnomeExtensions; [
#    adjust-display-brightness
#    blur-my-shell
#    dash-to-dock
#    just-perfection
#  ];
}
