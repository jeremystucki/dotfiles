{
  programs.git = {
    enable = true;
    userName = "Jeremy Stucki";

    aliases = {
      co = "checkout";
      l  = "log --pretty=oneline-extra --date=human"; 
      lg = "l --graph";
    };

    extraConfig = {
      push.default = "current";
      pull.rebase = true;
      rerere.enabled = true;
      status.short = true;
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
