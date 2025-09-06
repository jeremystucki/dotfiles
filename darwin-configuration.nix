{
  pkgs,
  pkgs-unstable,
  inputs,
  hostConfiguration,
  ...
}: {
  nix.settings.trusted-users = [hostConfiguration.username];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  system.stateVersion = 4;
  system.primaryUser = hostConfiguration.username;
  ids.gids.nixbld = 350;

  environment.shells = with pkgs; [zsh fish];

  services.tailscale.enable = true;

  users.knownUsers = [hostConfiguration.username];
  users.users.${hostConfiguration.username} = {
    home = "/Users/${hostConfiguration.username}";
    uid = 501;
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  fonts.packages = [pkgs.nerd-fonts.jetbrains-mono];

  homebrew = {
    enable = true;
    casks = ["ghostty"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${hostConfiguration.username}.imports = [
      ./common/home-manager.nix
      ./components/dotnet.nix
    ];
    extraSpecialArgs = {inherit pkgs-unstable hostConfiguration;};
    sharedModules = [inputs.mac-app-util.homeManagerModules.default];
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
