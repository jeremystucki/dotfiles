{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Environment variables
      set -gx EDITOR vi
      set -gx LESS -iR
      
      # Git prompt settings for __fish_git_prompt
      set -gx __fish_git_prompt_showdirtystate 1
      set -gx __fish_git_prompt_showuntrackedfiles 1
      set -gx __fish_git_prompt_showcolorhints 1

      # Custom key bindings
      bind \cn clear-screen

      # fnm setup for Node.js version management
      ${pkgs.fnm}/bin/fnm env --use-on-cd --shell fish | source
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      # Homebrew setup for macOS
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    shellAliases = {
      c = "clear -x";
      clip = "xclip -selection c";
      base64 = "base64 -w 0";
    };
  };
}
