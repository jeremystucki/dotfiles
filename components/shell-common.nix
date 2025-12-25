# Shared shell environment configuration
# This module is imported by both fish.nix and zsh.nix
{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "vi";
    LESS = "-iR";
  };

  # fnm (Fast Node Manager) setup - shell-specific init is handled in fish.nix/zsh.nix
  # Homebrew setup for Darwin - shell-specific init is handled in fish.nix/zsh.nix

  # Shared tools that benefit shell experience
  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };

  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      style = "compact";
      show_help = false;
      inline_height = 20;
      keymap_mode = "vim-insert";
    };
  };
}
