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

      # fnm setup for Node.js version management
      ${pkgs.fnm}/bin/fnm env --use-on-cd --shell fish | source
    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      # Homebrew setup for macOS
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    functions = {
      fish_prompt = ''
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

        if not set -q __fish_git_prompt_show_informative_status
          set -g __fish_git_prompt_show_informative_status 1
        end
        if not set -q __fish_git_prompt_hide_untrackedfiles
          set -g __fish_git_prompt_hide_untrackedfiles 1
        end
        if not set -q __fish_git_prompt_color_branch
          set -g __fish_git_prompt_color_branch magenta --bold
        end
        if not set -q __fish_git_prompt_showupstream
          set -g __fish_git_prompt_showupstream informative
        end
        if not set -q __fish_git_prompt_color_dirtystate
          set -g __fish_git_prompt_color_dirtystate blue
        end
        if not set -q __fish_git_prompt_color_stagedstate
          set -g __fish_git_prompt_color_stagedstate yellow
        end
        if not set -q __fish_git_prompt_color_invalidstate
          set -g __fish_git_prompt_color_invalidstate red
        end
        if not set -q __fish_git_prompt_color_untrackedfiles
          set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
        end
        if not set -q __fish_git_prompt_color_cleanstate
          set -g __fish_git_prompt_color_cleanstate green --bold
        end

        set -l color_cwd
        set -l suffix
        if functions -q fish_is_root_user; and fish_is_root_user
          if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
          else
            set color_cwd $fish_color_cwd
          end
          set suffix '#'
        else
          set color_cwd $fish_color_cwd
          set suffix '$'
        end

        # Show user@hostname only if:
        # - We're in an SSH session, or
        # - We're root user, or  
        # - The user is not the default system user
        set -l show_host 0
        if set -q SSH_CLIENT; or set -q SSH_CONNECTION
          set show_host 1
        else if functions -q fish_is_root_user; and fish_is_root_user
          set show_host 1
        end

        # Write pipestatus
        # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
        set -l bold_flag --bold
        set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
        if test $__fish_prompt_status_generation = $status_generation
          set bold_flag
        end
        set __fish_prompt_status_generation $status_generation
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color $bold_flag $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        if test $show_host -eq 1
          echo -n -s (set_color $fish_color_user) "$USER" (set_color normal) @ (set_color $fish_color_host) (prompt_hostname) (set_color normal) ' '
        end
        echo -n -s (set_color $color_cwd) (prompt_pwd) (set_color normal) (fish_vcs_prompt) $prompt_status " " $suffix " "
      '';
    };

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
