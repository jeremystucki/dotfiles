{ pkgs, ... }:

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

  programs.git = {
    enable = true;
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
    ];

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
