{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9keparNqpev2qrDO3cAiDzyTUsAAN9Mh+JLbOsdiZs";
in {
  home.shellAliases = { g = "git"; };

  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-dash ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.git = {
    enable = true;
    userName = "Jeremy Stucki";

    lfs.enable = true;

    aliases = {
      co = "checkout";
      cm = "!git co $(git symbolic-ref refs/remotes/origin/HEAD | awk -F '/' '{print $NF}')";
      l  = "log --pretty=oneline --abbrev-commit";
      lg = "l --graph";
      s  = "status";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      apply-ignore = "!apply-ignore() { git rm -r --cached . && git add . ;}; apply-ignore";
    };

    ignores = [
      ".envrc"
      ".idea"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;

      commit.gpgsign = true;
      user.signingkey = publicKey;
      "gpg \"ssh\"".program = "${pkgs._1password-gui}/bin/op-ssh-sign";

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
          dev@jeremystucki.ch ${publicKey}
          jeremy.stucki@valora.com ${publicKey}
          jeremy.stucki@ost.ch ${publicKey}
        '';
      };

      rebase = {
        abbreviateCommands = true;
        autostash = true;
        autosquash = true;
        updateRefs = true;
      };
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
        file-style = "bold yellow ul";
      };
    };
  };
}
