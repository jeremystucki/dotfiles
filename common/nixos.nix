{ config, pkgs, pkgs-unstable, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    supportedFilesystems = [ "ntfs" ];
  };

  users.users.jeremy = {
    isNormalUser = true;
    description = "Jeremy Stucki";
    extraGroups = [ "networkmanager" "wheel" "i2c" "docker" "adbusers" ];

    packages = with pkgs; [
      alacritty
      chromium
      ddcutil
      etcher
      firefox
      nodejs
      nodePackages.pnpm
      nvd
      ruby
      slack
      telegram-desktop
      wl-clipboard
      xsel
      pkgs-unstable.android-studio
      pkgs-unstable.discord
      pkgs-unstable.jetbrains.rider
    ];
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  networking = {
    networkmanager.enable = true;
    firewall.trustedInterfaces = [ "tailscale0" ];
    # wireless.enable = true;
  };

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_US.UTF-8";
  
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    displayManager = { gdm.enable = true; };
    desktopManager = { gnome.enable = true; };
  };

  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.tailscale.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware.i2c.enable = true;

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.steam.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.openjdk17;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "jeremy" ];
  };

  programs.adb.enable = true;

  programs.ssh.extraConfig = ''
    Host *
        IdentityAgent ${config.users.users.jeremy.home}/.1password/agent.sock
  '';

  systemd.user.services._1password = {
    script = "${pkgs._1password-gui}/bin/1password --silent";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    TZDIR = "/etc/zoneinfo";
  };
}
