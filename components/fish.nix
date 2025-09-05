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
