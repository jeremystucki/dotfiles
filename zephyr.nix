{
  imports = map (x: ./components + x) [
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

  programs.git.includes = [
    {
      condition = "gitdir:~/GitHub/valora-digital/";
      contents = {
        user.email = "jeremy.stucki@valora.com";
      };
    }
    {
      condition = "gitdir:~/GitHub/";
      contents = {
        user.email = "dev@jeremystucki.ch";
      };
    }
  ];
}
