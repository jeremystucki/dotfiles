{
  imports = map (x: ./components + x) [
    /alacritty.nix
    /zsh.nix
    /cli.nix
    /git.nix
    /vim.nix
    /code.nix
    /jetbrains.nix
    /haskell.nix
  ];

  home.username = "jeremy";
  home.homeDirectory = "/home/jeremy";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  home.file.".config/alacritty/machine-specific-config.yml".source = ./resources/alacritty-volt.yml;

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
    {
      condition = "gitdir:~/Documents/Code/GitLab-OST/";
      contents = {
        user = {
          email = "jeremy.stucki@ost.ch";
          signingkey = "8E5EF915A05542E62295B5BC3D33B691D8AE9CDF";
        };
        commit.gpgSign = true;
      };
    }
    {
      condition = "gitdir:~/Documents/Code/";
      contents = {
        user = {
          email = "dev@jeremystucki.ch";
          signingkey = "5336B63C29AE19E0A358EF0AD2A1E19158A33812";
        };
        commit.gpgSign = true;
      };
    }
  ];

  programs.zsh.initExtra = "bindkey '^[[3~' delete-char";

  programs.vscode.userSettings = {
    workbench.colorTheme = "Quiet Light";
  };
}
