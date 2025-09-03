{
  config,
  pkgs,
  pkgs-unstable,
  hostConfiguration,
  ...
}: {
  programs._1password = {
    enable = true;
    package = pkgs-unstable._1password-cli;
  };

  programs._1password-gui = {
    enable = true;
    package = pkgs-unstable._1password-gui;
    polkitPolicyOwners = [hostConfiguration.username];
  };

  programs.ssh.extraConfig = ''
    Host *
        IdentityAgent ${config.users.users.${hostConfiguration.username}.home}/.1password/agent.sock
  '';

  systemd.user.services._1password = {
    script = "${pkgs-unstable._1password-gui}/bin/1password --silent";
    after = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    wantedBy = ["graphical-session.target"];
  };
}
