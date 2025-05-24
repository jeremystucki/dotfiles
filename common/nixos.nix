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

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

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

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };

    displayManager = {
      gdm.enable = true;
    };
    desktopManager = {
      gnome.enable = true;
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

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.ratbagd.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware.i2c.enable = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    input-fonts
  ];

  programs.steam.enable = true;

  programs._1password = {
    enable = true;
    package = pkgs-unstable._1password-cli;
  };

  programs._1password-gui = {
    enable = true;
    package = pkgs-unstable._1password-gui;

    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [hostConfiguration.username];
  };

  programs.adb.enable = true;

  programs.ssh.extraConfig = ''
    Host *
        IdentityAgent ${config.users.users.${hostConfiguration.username}.home}/.1password/agent.sock
  '';

  systemd.user.services._1password = {
    script = "${pkgs._1password-gui}/bin/1password --silent";
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };

  systemd.user.services.tmux = {
    script = "${pkgs.tmux}/bin/tmux new-session -d";
    wantedBy = ["default.target"];
    serviceConfig.Type = "forking";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TZDIR = "/etc/zoneinfo";
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [hostConfiguration.username];
  boot.kernelModules = ["vboxnetflt" "vboxnetadp"];
}
