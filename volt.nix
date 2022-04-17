{
  imports = map (x: ./components + x) [
    /zsh.nix
    /cli.nix
    /git.nix
    /vim.nix
  ];

  home.username = "jeremy";
  home.homeDirectory = "/home/jeremy";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  programs.git.includes = [
    {
      condition = "gitdir:~/Documents/Code/Valora/";
      contents = {
        user = {
          email = "jeremy.stucki@valora.com";
          signingkey = "D91A765A08EB40E57C150BEC9E7DB73D85F91ED2";
        };
        commit.gpgSign = true;
      };
    }
  ];
  
  programs.zsh.initExtra = "bindkey '^[[3~' delete-char";

  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 12.0;
        offset.y = 2;
      };

      colors = {
        primary = {
          background = "#2b2b2b";
          foreground = "#bbbbbb";
        };

        normal = {
          black   = "#ffffff";
          red     = "#ff6b68";
          green   = "#a8c023";
          yellow  = "#d6bf55";
          blue    = "#5394ec";
          magenta = "#ae8abe";
          cyan    = "#299999";
          white   = "#1f1f1f";
        };

        bright = {
          black   = "#575b70";
          red     = "#ff8785";
          green   = "#a8ca23";
          yellow  = "#ffff00";
          blue    = "#7eaef1";
          magenta = "#ff99ff";
          cyan    = "#6cdada";
          white   = "#e6e6e6";
        };
      };
    };
  };
}
