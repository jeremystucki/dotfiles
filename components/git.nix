{pkgs, ...}: let
  gitPackage = pkgs.git;
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9keparNqpev2qrDO3cAiDzyTUsAAN9Mh+JLbOsdiZs";
  rsaPublicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIvAX/wQdFT4h2ifgPfi2JxZzKcDYY60uM9PRtbyoMXNc73QXvIVHs3wFB3sg3nISX745Et9z/FZUUYZZ0qey7jyRuzXIa7KH3xdDRJEj+JyZqr4cSvHcVSf5cYfkFRRGmaMPqdr4Q+52S/KtGNIBbH+GZlXk5T7GnmMn9f+EPBeggJ1CKAJoWctfbLcTQ9M7+ZIuAJKPMpPWuBL2Z7KVUmQPVzHvOfIybMBIDAuTotVpcJDgnKpw4I/Qang49RlT8Y3HxToIiPOZasAD/+bXktYzf3zFl+dpljfecX9tdWmF+DwXVMjhFNoY9w9RYKIU3KT3TEdrx45tDaNKK2wZ4o6elQyYwyQC8omAdqk91QxcZvaq85FKdRgdk04gZogQRSceDhRE6GAhQQGIn1Ne9MPxcElHpsniiJLJRtm9GXc1xZ25A4VAbZK4KRuC2AXeJhfYRdDp7QRobsY+cRXW0JcMVVnBkI34Az5kV05NUxifSNOFCPReBkWS5F/nHvu65qQaGg4nKCDVotHHcTDB8zjg6DPEOx2rAf8eN0PNkAcguy+y+/HylBeaj0fyIOKMoAutO5NiGiXLfzT/mJ35wv3rwx4ynBKocWB9qXZWVkutOkYtp60nTgLLz6isy1K0qJ1LL1YvTLXy/kiFn1N0Q3uTHC1VJnDkcZgXvMTxdGQ==";
in {
  home.shellAliases = {
    g = "git";
  };

  home.packages = pkgs.lib.optionals pkgs.stdenv.isDarwin [pkgs.git-format-staged];

  programs.gh = {
    enable = true;
    extensions = [pkgs.gh-dash];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.fish.interactiveShellInit = ''
    source ${gitPackage}/share/bash-completion/completions/git-prompt.sh
  '';

  programs.mergiraf.enable = true;

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
      fixup = "!git log -n 50 --pretty=format:'%h %s' --no-merges | fzf | cut -c -20 | xargs -o git commit --fixup";
      cr = "!git branch --sort=-committerdate | fzf | tr -d '[:space:]' | xargs -o git checkout";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      apply-ignore = "!apply-ignore() { git rm -r --cached . && git add . ;}; apply-ignore";
    };

    ignores =
      [
        ".direnv"
        ".idea"
      ]
      ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [".DS_Store"];

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;
      commit.verbose = true;
      fetch.prune = true;

      merge.conflictStyle = "diff3";

      rebase = {
        abbreviateCommands = true;
        autostash = true;
        autosquash = true;
        updateRefs = true;
      };

      commit.gpgsign = true;
      user.signingkey = publicKey;

      "gpg \"ssh\"".program =
        if pkgs.stdenv.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "${pkgs._1password-gui}/bin/op-ssh-sign";

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = builtins.toFile "allowed_signers" ''
          dev@jeremystucki.ch ${publicKey}
          jeremy.stucki@ost.ch ${publicKey}
          jeremy.stucki@digitecgalaxus.ch ${rsaPublicKey}
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
        condition = "hasconfig:remote.*.url:ssh://git@codeberg.org/*/**";
        contents = {
          user.email = "dev@jeremystucki.ch";
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@github.com:DigitecGalaxus/**";
        contents = {
          user.email = "jeremy.stucki@digitecgalaxus.ch";
        };
      }
      {
        condition = "hasconfig:remote.*.url:ssh://git@gitlab.ost.ch:*/**";
        contents = {
          user.email = "jeremy.stucki@ost.ch";
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@ssh.dev.azure.com:*/**";
        contents = {
          user.email = "jeremy.stucki@digitecgalaxus.ch";
          user.signingkey = rsaPublicKey;
        };
      }
    ];
  };
}
