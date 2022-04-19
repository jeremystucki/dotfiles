{
  imports = map (x: ./components + x) [
    /alacritty.nix
    /zsh.nix
    /cli.nix
    /git.nix
    /vim.nix
    /code.nix
    /jetbrains.nix
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
  ];
  
  programs.zsh.initExtra = "bindkey '^[[3~' delete-char";
}
