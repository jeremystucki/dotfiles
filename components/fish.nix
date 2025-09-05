{
  pkgs,
  lib,
  ...
}: {
  programs.fzf.enable = true;

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
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
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Environment variables
      set -gx EDITOR vi
      set -gx LESS -iR
      
      # Git prompt settings
      set -gx __fish_git_prompt_showdirtystate 1
      set -gx __fish_git_prompt_showuntrackedfiles 1
      set -gx __fish_git_prompt_showcolorhints 1

      # Key bindings
      bind \ca beginning-of-line
      bind \ce end-of-line
      bind \cn clear-screen
      bind \cv edit_command_line

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

    functions = {
      fish_prompt = {
        body = ''
          set_color $fish_color_cwd
          echo -n (prompt_pwd)
          set_color normal
          __fish_git_prompt
          echo
          echo -n '$ '
        '';
      };
    };
  };
}