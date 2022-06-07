{
  programs.git = {
    enable = true;
    userName = "Jeremy Stucki";

    aliases = {
      co = "checkout";
      l  = "log --pretty=oneline-extra --date=human"; 
      lg = "l --graph";
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };

    extraConfig = {
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;
      rebase.autosquash = true;
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
