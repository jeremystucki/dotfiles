{ pkgs, ... }:

let
  gitPackage = pkgs.git;
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9keparNqpev2qrDO3cAiDzyTUsAAN9Mh+JLbOsdiZs";
in
{
  home.shellAliases = {
    g = "git";
  };

  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-dash ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.zsh.initExtra = ''
    source ${gitPackage}/share/bash-completion/completions/git-prompt.sh
  '';

  programs.git = {
    enable = true;
    package = gitPackage;
    userName = "Jeremy Stucki";

    lfs.enable = true;

    aliases = {
      co = "checkout";
      cm = "!git co $(git symbolic-ref refs/remotes/origin/HEAD | awk -F '/' '{print $NF}')";
      l = "log --pretty=oneline --abbrev-commit";
      lg = "l --graph";
      s = "status";
      wip = "commit -m 'wip'";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      apply-ignore = "!apply-ignore() { git rm -r --cached . && git add . ;}; apply-ignore";
    };

    ignores = [
      ".direnv"
      ".idea"
    ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ ".DS_Store" ];

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;
      commit.verbose = true;

      rebase = {
        abbreviateCommands = true;
        autostash = true;
        autosquash = true;
        updateRefs = true;
      };

      commit.gpgsign = true;
      user.signingkey = publicKey;

      "gpg \"ssh\"".program =
        if pkgs.stdenv.isDarwin then
          "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else
          "${pkgs._1password-gui}/bin/op-ssh-sign";

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
          dev@jeremystucki.ch ${publicKey}
          jeremy.stucki@valora.com ${publicKey}
          jeremy.stucki@ost.ch ${publicKey}
        '';
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

    includes = [
      {
        condition = "hasconfig:remote.*.url:git@github.com:*/**";
        contents = {
          user.email = "dev@jeremystucki.ch";
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@github.com:valora-digital/**";
        contents = {
          user.email = "jeremy.stucki@valora.com";
        };
      }
      {
        condition = "hasconfig:remote.*.url:https://git.sonova.com/*/**";
        contents = {
          user.email = "jeremy.stucki.external@sonova.com";
        };
      }
      {
        condition = "hasconfig:remote.*.url:ssh://git@gitlab.ost.ch:*/**";
        contents = {
          user.email = "jeremy.stucki@ost.ch";
        };
      }
    ];
  };
}
