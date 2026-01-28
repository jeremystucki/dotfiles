{
  config,
  pkgs,
  pkgs-unstable,
  hostConfiguration,
  ...
}: {
  imports = [./nixos-hardware-configuration.nix];

  # Use latest Mesa from nixpkgs-unstable for better RDNA 4 (RX 9070) support
  hardware.graphics.package = pkgs-unstable.mesa;
  hardware.graphics.package32 = pkgs-unstable.pkgsi686Linux.mesa;

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

  environment.systemPackages = [
    pkgs.openrgb
  ];

  services.udev.packages = with pkgs; [
    openrgb
    zsa-udev-rules
  ];

  hardware.bluetooth.settings.General.Experimental = true;

  # Fix NVMe power management - drives run hot without this
  boot.kernelParams = [
    "pcie_aspm=force"
    "pcie_aspm.policy=powersupersave"
  ];

  # Enable runtime PM for NVMe devices so they can enter low-power states
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{class}=="0x010802", ATTR{power/control}="auto"
  '';
}
