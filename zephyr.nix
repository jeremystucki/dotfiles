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

  home.file.".config/alacritty/machine-specific-config.yml".text = "";

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
