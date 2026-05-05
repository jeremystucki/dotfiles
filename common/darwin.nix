{
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  hostConfiguration,
  git-format-staged,
  ...
}: {
  nix.enable = false;
  nix.settings.trusted-users = [hostConfiguration.username];

  system.stateVersion = 4;
  system.primaryUser = hostConfiguration.username;
  ids.gids.nixbld = 350;

  # Workaround: fish 4.2.1 in nixpkgs ships with an invalid ad-hoc signature
  # on aarch64-darwin, so the kernel refuses to exec it. Re-sign in postFixup.
  nixpkgs.overlays = [
    (_: prev: {
      fish = prev.fish.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [prev.darwin.sigtool];
        postFixup =
          (old.postFixup or "")
          + ''
            codesign --force --sign - $out/bin/fish
          '';
      });
    })
  ];

  environment.shells = with pkgs; [zsh fish];

  services.tailscale.enable = true;

  users.knownUsers = [hostConfiguration.username];
  users.users.${hostConfiguration.username} = {
    home = "/Users/${hostConfiguration.username}";
    uid = 501;
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${hostConfiguration.username}.imports = [
      ./home-manager.nix
    ];
    extraSpecialArgs = {inherit pkgs-unstable hostConfiguration git-format-staged;};
    sharedModules = [inputs.mac-app-util.homeManagerModules.default];
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
