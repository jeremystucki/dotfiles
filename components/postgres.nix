{ pkgs, ... }:

{
  home.file.".postgresqlrc".text = ''
    \set ON_ERROR_ROLLBACK interactive
    \set COMP_KEYWORD_CASE upper
    \set HISTSIZE 10000
    \x auto
    \pset null ¤
  '';
}
