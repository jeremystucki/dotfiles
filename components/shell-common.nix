# Shared shell environment configuration
# This module is imported by both fish.nix and zsh.nix
{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  home.sessionVariables = {
    LESS = "-iR";
  };

  # fnm (Fast Node Manager) setup - shell-specific init is handled in fish.nix/zsh.nix
  # Homebrew setup for Darwin - shell-specific init is handled in fish.nix/zsh.nix

  # Shared tools that benefit shell experience
  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    package = pkgs-unstable.direnv;
    silent = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      sync_address = "http://piltover.hawk-typhon.ts.net:8888";
      style = "compact";
      show_help = false;
      inline_height = 20;
      keymap_mode = "vim-insert";
    };
  };
}
