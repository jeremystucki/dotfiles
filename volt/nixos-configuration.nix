{
  config,
  pkgs,
  hostConfiguration,
  ...
}: {
  imports = [./nixos-hardware-configuration.nix];

  boot.loader = {
    timeout = 300;

    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;

      windows.windows-11 = {
        title = "Windows 11";
        efiDeviceHandle = "FS7";
      };

      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i 's/default .*/default @saved/' /boot/loader/loader.conf
      '';
    };
  };

  networking.hostName = hostConfiguration.hostname;

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

  services.displayManager.autoLogin = {
    enable = true;
    user = hostConfiguration.username;
  };

  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = [pkgs.openrgb];

  services.udev.packages = with pkgs; [
    openrgb
    zsa-udev-rules
  ];

  hardware.bluetooth.settings.General.Experimental = true;

  #  environment.systemPackages = with pkgs.gnomeExtensions; [
  #    adjust-display-brightness
  #    blur-my-shell
  #    dash-to-dock
  #    just-perfection
  #  ];
}
