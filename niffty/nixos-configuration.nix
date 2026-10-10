{
  config,
  pkgs,
  hostConfiguration,
  ...
}:
{
  imports = [ ./nixos-hardware-configuration.nix ];

  # Allow voltage/clock control for AMDGPU (needed by LACT)
  hardware.amdgpu.overdrive.enable = true;

  boot.loader = {
    timeout = 30;

    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;

      windows = {
        "windows-11" = {
          title = "Windows 11";
          efiDeviceHandle = "FS2";
        };
      };

      extraInstallCommands = ''
        ${pkgs.gnused}/bin/sed -i 's/default .*/default @saved/' /boot/loader/loader.conf
      '';
    };
  };

  networking.hostName = hostConfiguration.hostname;

  virtualisation.docker.daemon.settings.features.cdi = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = hostConfiguration.username;
  };

  # LACT for GPU management/undervolting (lactd daemon applies settings at boot)
  services.lact.enable = true;

  environment.systemPackages = [
    pkgs.openrgb
  ];

  services.udev.packages = with pkgs; [
    openrgb
    zsa-udev-rules
  ];

  hardware.bluetooth.settings.General.Experimental = true;

  # Enable runtime PM for NVMe devices so they can enter low-power states
  # (scoped to NVMe controllers only — global ASPM params were removed because
  # powersupersave caused the RX 9070 GPU to not wake from screen blanking)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{class}=="0x010802", ATTR{power/control}="auto"
  '';
}
