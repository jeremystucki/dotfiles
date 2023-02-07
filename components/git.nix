{
  home.shellAliases = { g = "git"; };

  programs.git = {
    enable = true;
    userName = "Jeremy Stucki";

    aliases = {
      co = "checkout";
      l  = "log --pretty=oneline --abbrev-commit";
      lg = "l --graph";
      s  = "status";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;

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
