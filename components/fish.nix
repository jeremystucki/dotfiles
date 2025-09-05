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

      # Custom key bindings
      bind \cn clear-screen

      # Git prompt configuration - show all git states with colors
      set -g __fish_git_prompt_hide_untrackedfiles 0
      set -g __fish_git_prompt_showdirtystate 1
      set -g __fish_git_prompt_showstagedfiles 1
      set -g __fish_git_prompt_showcolorhints 1
      
      # Hide user@hostname for local sessions (non-SSH, non-root)
      if not set -q SSH_CLIENT; and not set -q SSH_CONNECTION; and test (id -u) -ne 0
        function fish_prompt
          # Add newline before prompt for spacing
          echo
          # Show ~ for home directory, otherwise show last folder
          if test (pwd) = $HOME
            echo "~"
          else
            echo -s (basename (pwd)) (fish_vcs_prompt)
          end
          echo -n "\$ "
        end
      end

      # fnm setup for Node.js version management
      ${pkgs.fnm}/bin/fnm env --use-on-cd --shell fish | source
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      # Homebrew setup for macOS
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    shellAliases = lib.mkMerge [
      {
        c = "clear -x";
        base64 = "${pkgs.coreutils}/bin/base64 -w 0";
      }
      (lib.optionalAttrs pkgs.stdenv.isDarwin {
        clip = "pbcopy";
      })
      (lib.optionalAttrs pkgs.stdenv.isLinux {
        clip = "xclip -selection c";
      })
    ];
  };
}
