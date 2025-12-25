{
  config,
  pkgs,
  pkgs-unstable,
  hostConfiguration,
  ...
}: {
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";

  users.users.${hostConfiguration.username} = {
    isNormalUser = true;
    description = "Jeremy Stucki";
    extraGroups = [
      "adbusers"
      "docker"
      "i2c"
      "networkmanager"
      "plugdev"
      "wheel"
    ];
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  networking = {
    networkmanager.enable = true;
    firewall.trustedInterfaces = ["tailscale0"];
    # wireless.enable = true;
  };

  time.timeZone = "Europe/Zurich";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_CH.UTF-8";
    };
  };

  services.openssh.enable = true;
  services.printing.enable = true;
  services.tailscale.enable = true;

  services.openssh.settings.Macs = [
    "hmac-sha2-512-etm@openssh.com"
    "hmac-sha2-256-etm@openssh.com"
    "umac-128-etm@openssh.com"
    "hmac-sha2-512"
  ];

  services.ratbagd.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  hardware.i2c.enable = true;

  programs.steam.enable = true;
  programs.adb.enable = true;

  systemd.user.services.tmux = {
    script = "${pkgs.tmux}/bin/tmux new-session -d";
    wantedBy = ["default.target"];
    serviceConfig.Type = "forking";
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [hostConfiguration.username];
  boot.kernelModules = ["vboxnetflt" "vboxnetadp"];

  environment.sessionVariables.TZDIR = "/etc/zoneinfo";

  programs.nix-ld.enable = true;
}
